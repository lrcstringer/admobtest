// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Engagement {

 String get id; String get userId; String? get audienceCampaignId; String get earnOpportunityId; EngagementStatus get status; DateTime get startedAt; DateTime? get completedAt; int get watchDurationSeconds; int get requiredDurationSeconds; List<SurveyResponse> get answers; EngagementEvidence? get evidence; double? get tokensEarned;/// Gross tokens generated before the 90/5/5 split (bonus-adjusted)
 double? get totalTokensGenerated; String? get failureReason; int get attemptNumber; DateTime get createdAt; DateTime? get updatedAt;// Denormalized fields for targeting queries
/// Thread ID denormalized from opportunity
 String? get threadId;/// Client ID denormalized from thread
 String? get clientId;// Streak audit fields
/// What day of streak this completion was on
 int? get streakDayAtCompletion;/// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
 double? get multiplierApplied;// AdMob tracking fields
/// True when ad was fully watched
 bool get adWatched;/// AdMob transaction ID for SSV verification
 String? get adTransactionId;/// Timestamp when ad completed
 DateTime? get adCompletedAt;// Reward escrow fields
/// Reward item ID (set after engagement completion — confirmed allocation)
 String? get rewardItemId;/// Reward campaign name (denormalized for display)
 String? get rewardCampaignName;/// Reward type (e.g. 'voucher', 'digital_code', 'physical')
 String? get rewardType;
/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EngagementCopyWith<Engagement> get copyWith => _$EngagementCopyWithImpl<Engagement>(this as Engagement, _$identity);

  /// Serializes this Engagement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Engagement&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.audienceCampaignId, audienceCampaignId) || other.audienceCampaignId == audienceCampaignId)&&(identical(other.earnOpportunityId, earnOpportunityId) || other.earnOpportunityId == earnOpportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.requiredDurationSeconds, requiredDurationSeconds) || other.requiredDurationSeconds == requiredDurationSeconds)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.totalTokensGenerated, totalTokensGenerated) || other.totalTokensGenerated == totalTokensGenerated)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.streakDayAtCompletion, streakDayAtCompletion) || other.streakDayAtCompletion == streakDayAtCompletion)&&(identical(other.multiplierApplied, multiplierApplied) || other.multiplierApplied == multiplierApplied)&&(identical(other.adWatched, adWatched) || other.adWatched == adWatched)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adCompletedAt, adCompletedAt) || other.adCompletedAt == adCompletedAt)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,audienceCampaignId,earnOpportunityId,status,startedAt,completedAt,watchDurationSeconds,requiredDurationSeconds,const DeepCollectionEquality().hash(answers),evidence,tokensEarned,totalTokensGenerated,failureReason,attemptNumber,createdAt,updatedAt,threadId,clientId,streakDayAtCompletion,multiplierApplied,adWatched,adTransactionId,adCompletedAt,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'Engagement(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, totalTokensGenerated: $totalTokensGenerated, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class $EngagementCopyWith<$Res>  {
  factory $EngagementCopyWith(Engagement value, $Res Function(Engagement) _then) = _$EngagementCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String? audienceCampaignId, String earnOpportunityId, EngagementStatus status, DateTime startedAt, DateTime? completedAt, int watchDurationSeconds, int requiredDurationSeconds, List<SurveyResponse> answers, EngagementEvidence? evidence, double? tokensEarned, double? totalTokensGenerated, String? failureReason, int attemptNumber, DateTime createdAt, DateTime? updatedAt, String? threadId, String? clientId, int? streakDayAtCompletion, double? multiplierApplied, bool adWatched, String? adTransactionId, DateTime? adCompletedAt, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


$EngagementEvidenceCopyWith<$Res>? get evidence;

}
/// @nodoc
class _$EngagementCopyWithImpl<$Res>
    implements $EngagementCopyWith<$Res> {
  _$EngagementCopyWithImpl(this._self, this._then);

  final Engagement _self;
  final $Res Function(Engagement) _then;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? audienceCampaignId = freezed,Object? earnOpportunityId = null,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? watchDurationSeconds = null,Object? requiredDurationSeconds = null,Object? answers = null,Object? evidence = freezed,Object? tokensEarned = freezed,Object? totalTokensGenerated = freezed,Object? failureReason = freezed,Object? attemptNumber = null,Object? createdAt = null,Object? updatedAt = freezed,Object? threadId = freezed,Object? clientId = freezed,Object? streakDayAtCompletion = freezed,Object? multiplierApplied = freezed,Object? adWatched = null,Object? adTransactionId = freezed,Object? adCompletedAt = freezed,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,audienceCampaignId: freezed == audienceCampaignId ? _self.audienceCampaignId : audienceCampaignId // ignore: cast_nullable_to_non_nullable
as String?,earnOpportunityId: null == earnOpportunityId ? _self.earnOpportunityId : earnOpportunityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EngagementStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchDurationSeconds: null == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredDurationSeconds: null == requiredDurationSeconds ? _self.requiredDurationSeconds : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<SurveyResponse>,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidence?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as double?,totalTokensGenerated: freezed == totalTokensGenerated ? _self.totalTokensGenerated : totalTokensGenerated // ignore: cast_nullable_to_non_nullable
as double?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,streakDayAtCompletion: freezed == streakDayAtCompletion ? _self.streakDayAtCompletion : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
as int?,multiplierApplied: freezed == multiplierApplied ? _self.multiplierApplied : multiplierApplied // ignore: cast_nullable_to_non_nullable
as double?,adWatched: null == adWatched ? _self.adWatched : adWatched // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adCompletedAt: freezed == adCompletedAt ? _self.adCompletedAt : adCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceCopyWith<$Res>? get evidence {
    if (_self.evidence == null) {
    return null;
  }

  return $EngagementEvidenceCopyWith<$Res>(_self.evidence!, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}


/// Adds pattern-matching-related methods to [Engagement].
extension EngagementPatterns on Engagement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Engagement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Engagement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Engagement value)  $default,){
final _that = this;
switch (_that) {
case _Engagement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Engagement value)?  $default,){
final _that = this;
switch (_that) {
case _Engagement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  EngagementStatus status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponse> answers,  EngagementEvidence? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Engagement() when $default != null:
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  EngagementStatus status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponse> answers,  EngagementEvidence? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)  $default,) {final _that = this;
switch (_that) {
case _Engagement():
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String? audienceCampaignId,  String earnOpportunityId,  EngagementStatus status,  DateTime startedAt,  DateTime? completedAt,  int watchDurationSeconds,  int requiredDurationSeconds,  List<SurveyResponse> answers,  EngagementEvidence? evidence,  double? tokensEarned,  double? totalTokensGenerated,  String? failureReason,  int attemptNumber,  DateTime createdAt,  DateTime? updatedAt,  String? threadId,  String? clientId,  int? streakDayAtCompletion,  double? multiplierApplied,  bool adWatched,  String? adTransactionId,  DateTime? adCompletedAt,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,) {final _that = this;
switch (_that) {
case _Engagement() when $default != null:
return $default(_that.id,_that.userId,_that.audienceCampaignId,_that.earnOpportunityId,_that.status,_that.startedAt,_that.completedAt,_that.watchDurationSeconds,_that.requiredDurationSeconds,_that.answers,_that.evidence,_that.tokensEarned,_that.totalTokensGenerated,_that.failureReason,_that.attemptNumber,_that.createdAt,_that.updatedAt,_that.threadId,_that.clientId,_that.streakDayAtCompletion,_that.multiplierApplied,_that.adWatched,_that.adTransactionId,_that.adCompletedAt,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Engagement extends Engagement {
  const _Engagement({required this.id, required this.userId, this.audienceCampaignId, required this.earnOpportunityId, required this.status, required this.startedAt, this.completedAt, required this.watchDurationSeconds, required this.requiredDurationSeconds, required final  List<SurveyResponse> answers, this.evidence, this.tokensEarned, this.totalTokensGenerated, this.failureReason, required this.attemptNumber, required this.createdAt, this.updatedAt, this.threadId, this.clientId, this.streakDayAtCompletion, this.multiplierApplied, this.adWatched = false, this.adTransactionId, this.adCompletedAt, this.rewardItemId, this.rewardCampaignName, this.rewardType}): _answers = answers,super._();
  factory _Engagement.fromJson(Map<String, dynamic> json) => _$EngagementFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String? audienceCampaignId;
@override final  String earnOpportunityId;
@override final  EngagementStatus status;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
@override final  int watchDurationSeconds;
@override final  int requiredDurationSeconds;
 final  List<SurveyResponse> _answers;
@override List<SurveyResponse> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override final  EngagementEvidence? evidence;
@override final  double? tokensEarned;
/// Gross tokens generated before the 90/5/5 split (bonus-adjusted)
@override final  double? totalTokensGenerated;
@override final  String? failureReason;
@override final  int attemptNumber;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
// Denormalized fields for targeting queries
/// Thread ID denormalized from opportunity
@override final  String? threadId;
/// Client ID denormalized from thread
@override final  String? clientId;
// Streak audit fields
/// What day of streak this completion was on
@override final  int? streakDayAtCompletion;
/// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
@override final  double? multiplierApplied;
// AdMob tracking fields
/// True when ad was fully watched
@override@JsonKey() final  bool adWatched;
/// AdMob transaction ID for SSV verification
@override final  String? adTransactionId;
/// Timestamp when ad completed
@override final  DateTime? adCompletedAt;
// Reward escrow fields
/// Reward item ID (set after engagement completion — confirmed allocation)
@override final  String? rewardItemId;
/// Reward campaign name (denormalized for display)
@override final  String? rewardCampaignName;
/// Reward type (e.g. 'voucher', 'digital_code', 'physical')
@override final  String? rewardType;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementCopyWith<_Engagement> get copyWith => __$EngagementCopyWithImpl<_Engagement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EngagementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Engagement&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.audienceCampaignId, audienceCampaignId) || other.audienceCampaignId == audienceCampaignId)&&(identical(other.earnOpportunityId, earnOpportunityId) || other.earnOpportunityId == earnOpportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.requiredDurationSeconds, requiredDurationSeconds) || other.requiredDurationSeconds == requiredDurationSeconds)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.totalTokensGenerated, totalTokensGenerated) || other.totalTokensGenerated == totalTokensGenerated)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.streakDayAtCompletion, streakDayAtCompletion) || other.streakDayAtCompletion == streakDayAtCompletion)&&(identical(other.multiplierApplied, multiplierApplied) || other.multiplierApplied == multiplierApplied)&&(identical(other.adWatched, adWatched) || other.adWatched == adWatched)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adCompletedAt, adCompletedAt) || other.adCompletedAt == adCompletedAt)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,audienceCampaignId,earnOpportunityId,status,startedAt,completedAt,watchDurationSeconds,requiredDurationSeconds,const DeepCollectionEquality().hash(_answers),evidence,tokensEarned,totalTokensGenerated,failureReason,attemptNumber,createdAt,updatedAt,threadId,clientId,streakDayAtCompletion,multiplierApplied,adWatched,adTransactionId,adCompletedAt,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'Engagement(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, totalTokensGenerated: $totalTokensGenerated, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class _$EngagementCopyWith<$Res> implements $EngagementCopyWith<$Res> {
  factory _$EngagementCopyWith(_Engagement value, $Res Function(_Engagement) _then) = __$EngagementCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String? audienceCampaignId, String earnOpportunityId, EngagementStatus status, DateTime startedAt, DateTime? completedAt, int watchDurationSeconds, int requiredDurationSeconds, List<SurveyResponse> answers, EngagementEvidence? evidence, double? tokensEarned, double? totalTokensGenerated, String? failureReason, int attemptNumber, DateTime createdAt, DateTime? updatedAt, String? threadId, String? clientId, int? streakDayAtCompletion, double? multiplierApplied, bool adWatched, String? adTransactionId, DateTime? adCompletedAt, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


@override $EngagementEvidenceCopyWith<$Res>? get evidence;

}
/// @nodoc
class __$EngagementCopyWithImpl<$Res>
    implements _$EngagementCopyWith<$Res> {
  __$EngagementCopyWithImpl(this._self, this._then);

  final _Engagement _self;
  final $Res Function(_Engagement) _then;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? audienceCampaignId = freezed,Object? earnOpportunityId = null,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? watchDurationSeconds = null,Object? requiredDurationSeconds = null,Object? answers = null,Object? evidence = freezed,Object? tokensEarned = freezed,Object? totalTokensGenerated = freezed,Object? failureReason = freezed,Object? attemptNumber = null,Object? createdAt = null,Object? updatedAt = freezed,Object? threadId = freezed,Object? clientId = freezed,Object? streakDayAtCompletion = freezed,Object? multiplierApplied = freezed,Object? adWatched = null,Object? adTransactionId = freezed,Object? adCompletedAt = freezed,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_Engagement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,audienceCampaignId: freezed == audienceCampaignId ? _self.audienceCampaignId : audienceCampaignId // ignore: cast_nullable_to_non_nullable
as String?,earnOpportunityId: null == earnOpportunityId ? _self.earnOpportunityId : earnOpportunityId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EngagementStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchDurationSeconds: null == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredDurationSeconds: null == requiredDurationSeconds ? _self.requiredDurationSeconds : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<SurveyResponse>,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidence?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as double?,totalTokensGenerated: freezed == totalTokensGenerated ? _self.totalTokensGenerated : totalTokensGenerated // ignore: cast_nullable_to_non_nullable
as double?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,streakDayAtCompletion: freezed == streakDayAtCompletion ? _self.streakDayAtCompletion : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
as int?,multiplierApplied: freezed == multiplierApplied ? _self.multiplierApplied : multiplierApplied // ignore: cast_nullable_to_non_nullable
as double?,adWatched: null == adWatched ? _self.adWatched : adWatched // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adCompletedAt: freezed == adCompletedAt ? _self.adCompletedAt : adCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceCopyWith<$Res>? get evidence {
    if (_self.evidence == null) {
    return null;
  }

  return $EngagementEvidenceCopyWith<$Res>(_self.evidence!, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}


/// @nodoc
mixin _$SurveyResponse {

 String get questionId; String get questionType; DateTime get answeredAt;// single_select
 String? get selectedOption;// multi_select
 List<String>? get selectedOptions;// text_input
 List<String>? get textResponses;// likert
 int? get likertValue;// star_tags
 int? get starRating; List<String>? get selectedTags;// slider
 double? get sliderValue;// attention check result
 bool? get isCorrect;
/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyResponseCopyWith<SurveyResponse> get copyWith => _$SurveyResponseCopyWithImpl<SurveyResponse>(this as SurveyResponse, _$identity);

  /// Serializes this SurveyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyResponse&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other.selectedOptions, selectedOptions)&&const DeepCollectionEquality().equals(other.textResponses, textResponses)&&(identical(other.likertValue, likertValue) || other.likertValue == likertValue)&&(identical(other.starRating, starRating) || other.starRating == starRating)&&const DeepCollectionEquality().equals(other.selectedTags, selectedTags)&&(identical(other.sliderValue, sliderValue) || other.sliderValue == sliderValue)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionType,answeredAt,selectedOption,const DeepCollectionEquality().hash(selectedOptions),const DeepCollectionEquality().hash(textResponses),likertValue,starRating,const DeepCollectionEquality().hash(selectedTags),sliderValue,isCorrect);

@override
String toString() {
  return 'SurveyResponse(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $SurveyResponseCopyWith<$Res>  {
  factory $SurveyResponseCopyWith(SurveyResponse value, $Res Function(SurveyResponse) _then) = _$SurveyResponseCopyWithImpl;
@useResult
$Res call({
 String questionId, String questionType, DateTime answeredAt, String? selectedOption, List<String>? selectedOptions, List<String>? textResponses, int? likertValue, int? starRating, List<String>? selectedTags, double? sliderValue, bool? isCorrect
});




}
/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._self, this._then);

  final SurveyResponse _self;
  final $Res Function(SurveyResponse) _then;

/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? questionType = null,Object? answeredAt = null,Object? selectedOption = freezed,Object? selectedOptions = freezed,Object? textResponses = freezed,Object? likertValue = freezed,Object? starRating = freezed,Object? selectedTags = freezed,Object? sliderValue = freezed,Object? isCorrect = freezed,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,selectedOption: freezed == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String?,selectedOptions: freezed == selectedOptions ? _self.selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>?,textResponses: freezed == textResponses ? _self.textResponses : textResponses // ignore: cast_nullable_to_non_nullable
as List<String>?,likertValue: freezed == likertValue ? _self.likertValue : likertValue // ignore: cast_nullable_to_non_nullable
as int?,starRating: freezed == starRating ? _self.starRating : starRating // ignore: cast_nullable_to_non_nullable
as int?,selectedTags: freezed == selectedTags ? _self.selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<String>?,sliderValue: freezed == sliderValue ? _self.sliderValue : sliderValue // ignore: cast_nullable_to_non_nullable
as double?,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyResponse].
extension SurveyResponsePatterns on SurveyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyResponse value)  $default,){
final _that = this;
switch (_that) {
case _SurveyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)  $default,) {final _that = this;
switch (_that) {
case _SurveyResponse():
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String questionType,  DateTime answeredAt,  String? selectedOption,  List<String>? selectedOptions,  List<String>? textResponses,  int? likertValue,  int? starRating,  List<String>? selectedTags,  double? sliderValue,  bool? isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
return $default(_that.questionId,_that.questionType,_that.answeredAt,_that.selectedOption,_that.selectedOptions,_that.textResponses,_that.likertValue,_that.starRating,_that.selectedTags,_that.sliderValue,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyResponse implements SurveyResponse {
  const _SurveyResponse({required this.questionId, required this.questionType, required this.answeredAt, this.selectedOption, final  List<String>? selectedOptions, final  List<String>? textResponses, this.likertValue, this.starRating, final  List<String>? selectedTags, this.sliderValue, this.isCorrect}): _selectedOptions = selectedOptions,_textResponses = textResponses,_selectedTags = selectedTags;
  factory _SurveyResponse.fromJson(Map<String, dynamic> json) => _$SurveyResponseFromJson(json);

@override final  String questionId;
@override final  String questionType;
@override final  DateTime answeredAt;
// single_select
@override final  String? selectedOption;
// multi_select
 final  List<String>? _selectedOptions;
// multi_select
@override List<String>? get selectedOptions {
  final value = _selectedOptions;
  if (value == null) return null;
  if (_selectedOptions is EqualUnmodifiableListView) return _selectedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// text_input
 final  List<String>? _textResponses;
// text_input
@override List<String>? get textResponses {
  final value = _textResponses;
  if (value == null) return null;
  if (_textResponses is EqualUnmodifiableListView) return _textResponses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// likert
@override final  int? likertValue;
// star_tags
@override final  int? starRating;
 final  List<String>? _selectedTags;
@override List<String>? get selectedTags {
  final value = _selectedTags;
  if (value == null) return null;
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// slider
@override final  double? sliderValue;
// attention check result
@override final  bool? isCorrect;

/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyResponseCopyWith<_SurveyResponse> get copyWith => __$SurveyResponseCopyWithImpl<_SurveyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyResponse&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.selectedOption, selectedOption) || other.selectedOption == selectedOption)&&const DeepCollectionEquality().equals(other._selectedOptions, _selectedOptions)&&const DeepCollectionEquality().equals(other._textResponses, _textResponses)&&(identical(other.likertValue, likertValue) || other.likertValue == likertValue)&&(identical(other.starRating, starRating) || other.starRating == starRating)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.sliderValue, sliderValue) || other.sliderValue == sliderValue)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionId,questionType,answeredAt,selectedOption,const DeepCollectionEquality().hash(_selectedOptions),const DeepCollectionEquality().hash(_textResponses),likertValue,starRating,const DeepCollectionEquality().hash(_selectedTags),sliderValue,isCorrect);

@override
String toString() {
  return 'SurveyResponse(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$SurveyResponseCopyWith<$Res> implements $SurveyResponseCopyWith<$Res> {
  factory _$SurveyResponseCopyWith(_SurveyResponse value, $Res Function(_SurveyResponse) _then) = __$SurveyResponseCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String questionType, DateTime answeredAt, String? selectedOption, List<String>? selectedOptions, List<String>? textResponses, int? likertValue, int? starRating, List<String>? selectedTags, double? sliderValue, bool? isCorrect
});




}
/// @nodoc
class __$SurveyResponseCopyWithImpl<$Res>
    implements _$SurveyResponseCopyWith<$Res> {
  __$SurveyResponseCopyWithImpl(this._self, this._then);

  final _SurveyResponse _self;
  final $Res Function(_SurveyResponse) _then;

/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? questionType = null,Object? answeredAt = null,Object? selectedOption = freezed,Object? selectedOptions = freezed,Object? textResponses = freezed,Object? likertValue = freezed,Object? starRating = freezed,Object? selectedTags = freezed,Object? sliderValue = freezed,Object? isCorrect = freezed,}) {
  return _then(_SurveyResponse(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,selectedOption: freezed == selectedOption ? _self.selectedOption : selectedOption // ignore: cast_nullable_to_non_nullable
as String?,selectedOptions: freezed == selectedOptions ? _self._selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as List<String>?,textResponses: freezed == textResponses ? _self._textResponses : textResponses // ignore: cast_nullable_to_non_nullable
as List<String>?,likertValue: freezed == likertValue ? _self.likertValue : likertValue // ignore: cast_nullable_to_non_nullable
as int?,starRating: freezed == starRating ? _self.starRating : starRating // ignore: cast_nullable_to_non_nullable
as int?,selectedTags: freezed == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<String>?,sliderValue: freezed == sliderValue ? _self.sliderValue : sliderValue // ignore: cast_nullable_to_non_nullable
as double?,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
