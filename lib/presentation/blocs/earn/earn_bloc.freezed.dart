// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarnEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent()';
}


}

/// @nodoc
class $EarnEventCopyWith<$Res>  {
$EarnEventCopyWith(EarnEvent _, $Res Function(EarnEvent) __);
}


/// Adds pattern-matching-related methods to [EarnEvent].
extension EarnEventPatterns on EarnEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadThreads value)?  loadThreads,TResult Function( _SelectThread value)?  selectThread,TResult Function( _SelectThreadFromInbox value)?  selectThreadFromInbox,TResult Function( _LoadOpportunities value)?  loadOpportunities,TResult Function( _SelectOpportunity value)?  selectOpportunity,TResult Function( _SetSelectedOpportunity value)?  setSelectedOpportunity,TResult Function( _StartEngagement value)?  startEngagement,TResult Function( _UpdateWatchProgress value)?  updateWatchProgress,TResult Function( _SubmitSurvey value)?  submitSurvey,TResult Function( _AbandonEngagement value)?  abandonEngagement,TResult Function( _LoadHistory value)?  loadHistory,TResult Function( _LoadMoreHistory value)?  loadMoreHistory,TResult Function( _Refresh value)?  refresh,TResult Function( _ClearError value)?  clearError,TResult Function( _ResetEngagement value)?  resetEngagement,TResult Function( _LoadAdVideo value)?  loadAdVideo,TResult Function( _AdVideoCompleted value)?  adVideoCompleted,TResult Function( _AdVideoFailed value)?  adVideoFailed,TResult Function( _AdShowFailed value)?  adShowFailed,TResult Function( _AdReadyStateChanged value)?  adReadyStateChanged,TResult Function( _AdLoadingStateChanged value)?  adLoadingStateChanged,TResult Function( _AdLoadAttemptChanged value)?  adLoadAttemptChanged,TResult Function( _AdLoadComplete value)?  adLoadComplete,TResult Function( _SubmitUpload value)?  submitUpload,TResult Function( _UploadProgressChanged value)?  uploadProgressChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads(_that);case _SelectThread() when selectThread != null:
return selectThread(_that);case _SelectThreadFromInbox() when selectThreadFromInbox != null:
return selectThreadFromInbox(_that);case _LoadOpportunities() when loadOpportunities != null:
return loadOpportunities(_that);case _SelectOpportunity() when selectOpportunity != null:
return selectOpportunity(_that);case _SetSelectedOpportunity() when setSelectedOpportunity != null:
return setSelectedOpportunity(_that);case _StartEngagement() when startEngagement != null:
return startEngagement(_that);case _UpdateWatchProgress() when updateWatchProgress != null:
return updateWatchProgress(_that);case _SubmitSurvey() when submitSurvey != null:
return submitSurvey(_that);case _AbandonEngagement() when abandonEngagement != null:
return abandonEngagement(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory(_that);case _Refresh() when refresh != null:
return refresh(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ResetEngagement() when resetEngagement != null:
return resetEngagement(_that);case _LoadAdVideo() when loadAdVideo != null:
return loadAdVideo(_that);case _AdVideoCompleted() when adVideoCompleted != null:
return adVideoCompleted(_that);case _AdVideoFailed() when adVideoFailed != null:
return adVideoFailed(_that);case _AdShowFailed() when adShowFailed != null:
return adShowFailed(_that);case _AdReadyStateChanged() when adReadyStateChanged != null:
return adReadyStateChanged(_that);case _AdLoadingStateChanged() when adLoadingStateChanged != null:
return adLoadingStateChanged(_that);case _AdLoadAttemptChanged() when adLoadAttemptChanged != null:
return adLoadAttemptChanged(_that);case _AdLoadComplete() when adLoadComplete != null:
return adLoadComplete(_that);case _SubmitUpload() when submitUpload != null:
return submitUpload(_that);case _UploadProgressChanged() when uploadProgressChanged != null:
return uploadProgressChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadThreads value)  loadThreads,required TResult Function( _SelectThread value)  selectThread,required TResult Function( _SelectThreadFromInbox value)  selectThreadFromInbox,required TResult Function( _LoadOpportunities value)  loadOpportunities,required TResult Function( _SelectOpportunity value)  selectOpportunity,required TResult Function( _SetSelectedOpportunity value)  setSelectedOpportunity,required TResult Function( _StartEngagement value)  startEngagement,required TResult Function( _UpdateWatchProgress value)  updateWatchProgress,required TResult Function( _SubmitSurvey value)  submitSurvey,required TResult Function( _AbandonEngagement value)  abandonEngagement,required TResult Function( _LoadHistory value)  loadHistory,required TResult Function( _LoadMoreHistory value)  loadMoreHistory,required TResult Function( _Refresh value)  refresh,required TResult Function( _ClearError value)  clearError,required TResult Function( _ResetEngagement value)  resetEngagement,required TResult Function( _LoadAdVideo value)  loadAdVideo,required TResult Function( _AdVideoCompleted value)  adVideoCompleted,required TResult Function( _AdVideoFailed value)  adVideoFailed,required TResult Function( _AdShowFailed value)  adShowFailed,required TResult Function( _AdReadyStateChanged value)  adReadyStateChanged,required TResult Function( _AdLoadingStateChanged value)  adLoadingStateChanged,required TResult Function( _AdLoadAttemptChanged value)  adLoadAttemptChanged,required TResult Function( _AdLoadComplete value)  adLoadComplete,required TResult Function( _SubmitUpload value)  submitUpload,required TResult Function( _UploadProgressChanged value)  uploadProgressChanged,}){
final _that = this;
switch (_that) {
case _LoadThreads():
return loadThreads(_that);case _SelectThread():
return selectThread(_that);case _SelectThreadFromInbox():
return selectThreadFromInbox(_that);case _LoadOpportunities():
return loadOpportunities(_that);case _SelectOpportunity():
return selectOpportunity(_that);case _SetSelectedOpportunity():
return setSelectedOpportunity(_that);case _StartEngagement():
return startEngagement(_that);case _UpdateWatchProgress():
return updateWatchProgress(_that);case _SubmitSurvey():
return submitSurvey(_that);case _AbandonEngagement():
return abandonEngagement(_that);case _LoadHistory():
return loadHistory(_that);case _LoadMoreHistory():
return loadMoreHistory(_that);case _Refresh():
return refresh(_that);case _ClearError():
return clearError(_that);case _ResetEngagement():
return resetEngagement(_that);case _LoadAdVideo():
return loadAdVideo(_that);case _AdVideoCompleted():
return adVideoCompleted(_that);case _AdVideoFailed():
return adVideoFailed(_that);case _AdShowFailed():
return adShowFailed(_that);case _AdReadyStateChanged():
return adReadyStateChanged(_that);case _AdLoadingStateChanged():
return adLoadingStateChanged(_that);case _AdLoadAttemptChanged():
return adLoadAttemptChanged(_that);case _AdLoadComplete():
return adLoadComplete(_that);case _SubmitUpload():
return submitUpload(_that);case _UploadProgressChanged():
return uploadProgressChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadThreads value)?  loadThreads,TResult? Function( _SelectThread value)?  selectThread,TResult? Function( _SelectThreadFromInbox value)?  selectThreadFromInbox,TResult? Function( _LoadOpportunities value)?  loadOpportunities,TResult? Function( _SelectOpportunity value)?  selectOpportunity,TResult? Function( _SetSelectedOpportunity value)?  setSelectedOpportunity,TResult? Function( _StartEngagement value)?  startEngagement,TResult? Function( _UpdateWatchProgress value)?  updateWatchProgress,TResult? Function( _SubmitSurvey value)?  submitSurvey,TResult? Function( _AbandonEngagement value)?  abandonEngagement,TResult? Function( _LoadHistory value)?  loadHistory,TResult? Function( _LoadMoreHistory value)?  loadMoreHistory,TResult? Function( _Refresh value)?  refresh,TResult? Function( _ClearError value)?  clearError,TResult? Function( _ResetEngagement value)?  resetEngagement,TResult? Function( _LoadAdVideo value)?  loadAdVideo,TResult? Function( _AdVideoCompleted value)?  adVideoCompleted,TResult? Function( _AdVideoFailed value)?  adVideoFailed,TResult? Function( _AdShowFailed value)?  adShowFailed,TResult? Function( _AdReadyStateChanged value)?  adReadyStateChanged,TResult? Function( _AdLoadingStateChanged value)?  adLoadingStateChanged,TResult? Function( _AdLoadAttemptChanged value)?  adLoadAttemptChanged,TResult? Function( _AdLoadComplete value)?  adLoadComplete,TResult? Function( _SubmitUpload value)?  submitUpload,TResult? Function( _UploadProgressChanged value)?  uploadProgressChanged,}){
final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads(_that);case _SelectThread() when selectThread != null:
return selectThread(_that);case _SelectThreadFromInbox() when selectThreadFromInbox != null:
return selectThreadFromInbox(_that);case _LoadOpportunities() when loadOpportunities != null:
return loadOpportunities(_that);case _SelectOpportunity() when selectOpportunity != null:
return selectOpportunity(_that);case _SetSelectedOpportunity() when setSelectedOpportunity != null:
return setSelectedOpportunity(_that);case _StartEngagement() when startEngagement != null:
return startEngagement(_that);case _UpdateWatchProgress() when updateWatchProgress != null:
return updateWatchProgress(_that);case _SubmitSurvey() when submitSurvey != null:
return submitSurvey(_that);case _AbandonEngagement() when abandonEngagement != null:
return abandonEngagement(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory(_that);case _Refresh() when refresh != null:
return refresh(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ResetEngagement() when resetEngagement != null:
return resetEngagement(_that);case _LoadAdVideo() when loadAdVideo != null:
return loadAdVideo(_that);case _AdVideoCompleted() when adVideoCompleted != null:
return adVideoCompleted(_that);case _AdVideoFailed() when adVideoFailed != null:
return adVideoFailed(_that);case _AdShowFailed() when adShowFailed != null:
return adShowFailed(_that);case _AdReadyStateChanged() when adReadyStateChanged != null:
return adReadyStateChanged(_that);case _AdLoadingStateChanged() when adLoadingStateChanged != null:
return adLoadingStateChanged(_that);case _AdLoadAttemptChanged() when adLoadAttemptChanged != null:
return adLoadAttemptChanged(_that);case _AdLoadComplete() when adLoadComplete != null:
return adLoadComplete(_that);case _SubmitUpload() when submitUpload != null:
return submitUpload(_that);case _UploadProgressChanged() when uploadProgressChanged != null:
return uploadProgressChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadThreads,TResult Function( String threadId)?  selectThread,TResult Function( String threadId,  String title,  String? description,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  bool isPinned,  bool isFeatured,  int availableOpportunities)?  selectThreadFromInbox,TResult Function( String threadId)?  loadOpportunities,TResult Function( String opportunityId)?  selectOpportunity,TResult Function( EarnOpportunity opportunity)?  setSelectedOpportunity,TResult Function( String opportunityId)?  startEngagement,TResult Function( String engagementId,  int watchDurationSeconds)?  updateWatchProgress,TResult Function( String engagementId,  List<EngagementAnswer> answers,  EngagementEvidence evidence)?  submitSurvey,TResult Function( String engagementId)?  abandonEngagement,TResult Function( int? limit)?  loadHistory,TResult Function()?  loadMoreHistory,TResult Function()?  refresh,TResult Function()?  clearError,TResult Function()?  resetEngagement,TResult Function()?  loadAdVideo,TResult Function( String transactionId,  int rewardAmount,  String? responseId)?  adVideoCompleted,TResult Function( String reason)?  adVideoFailed,TResult Function()?  adShowFailed,TResult Function( bool isReady)?  adReadyStateChanged,TResult Function( bool isLoading)?  adLoadingStateChanged,TResult Function( int attempt)?  adLoadAttemptChanged,TResult Function( bool success)?  adLoadComplete,TResult Function( String engagementId,  List<UploadedFileEvidence> uploadedFiles,  String? textResponse,  EngagementEvidence evidence)?  submitUpload,TResult Function( double progress,  int bytesTransferred,  int totalBytes)?  uploadProgressChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads();case _SelectThread() when selectThread != null:
return selectThread(_that.threadId);case _SelectThreadFromInbox() when selectThreadFromInbox != null:
return selectThreadFromInbox(_that.threadId,_that.title,_that.description,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.isPinned,_that.isFeatured,_that.availableOpportunities);case _LoadOpportunities() when loadOpportunities != null:
return loadOpportunities(_that.threadId);case _SelectOpportunity() when selectOpportunity != null:
return selectOpportunity(_that.opportunityId);case _SetSelectedOpportunity() when setSelectedOpportunity != null:
return setSelectedOpportunity(_that.opportunity);case _StartEngagement() when startEngagement != null:
return startEngagement(_that.opportunityId);case _UpdateWatchProgress() when updateWatchProgress != null:
return updateWatchProgress(_that.engagementId,_that.watchDurationSeconds);case _SubmitSurvey() when submitSurvey != null:
return submitSurvey(_that.engagementId,_that.answers,_that.evidence);case _AbandonEngagement() when abandonEngagement != null:
return abandonEngagement(_that.engagementId);case _LoadHistory() when loadHistory != null:
return loadHistory(_that.limit);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory();case _Refresh() when refresh != null:
return refresh();case _ClearError() when clearError != null:
return clearError();case _ResetEngagement() when resetEngagement != null:
return resetEngagement();case _LoadAdVideo() when loadAdVideo != null:
return loadAdVideo();case _AdVideoCompleted() when adVideoCompleted != null:
return adVideoCompleted(_that.transactionId,_that.rewardAmount,_that.responseId);case _AdVideoFailed() when adVideoFailed != null:
return adVideoFailed(_that.reason);case _AdShowFailed() when adShowFailed != null:
return adShowFailed();case _AdReadyStateChanged() when adReadyStateChanged != null:
return adReadyStateChanged(_that.isReady);case _AdLoadingStateChanged() when adLoadingStateChanged != null:
return adLoadingStateChanged(_that.isLoading);case _AdLoadAttemptChanged() when adLoadAttemptChanged != null:
return adLoadAttemptChanged(_that.attempt);case _AdLoadComplete() when adLoadComplete != null:
return adLoadComplete(_that.success);case _SubmitUpload() when submitUpload != null:
return submitUpload(_that.engagementId,_that.uploadedFiles,_that.textResponse,_that.evidence);case _UploadProgressChanged() when uploadProgressChanged != null:
return uploadProgressChanged(_that.progress,_that.bytesTransferred,_that.totalBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadThreads,required TResult Function( String threadId)  selectThread,required TResult Function( String threadId,  String title,  String? description,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  bool isPinned,  bool isFeatured,  int availableOpportunities)  selectThreadFromInbox,required TResult Function( String threadId)  loadOpportunities,required TResult Function( String opportunityId)  selectOpportunity,required TResult Function( EarnOpportunity opportunity)  setSelectedOpportunity,required TResult Function( String opportunityId)  startEngagement,required TResult Function( String engagementId,  int watchDurationSeconds)  updateWatchProgress,required TResult Function( String engagementId,  List<EngagementAnswer> answers,  EngagementEvidence evidence)  submitSurvey,required TResult Function( String engagementId)  abandonEngagement,required TResult Function( int? limit)  loadHistory,required TResult Function()  loadMoreHistory,required TResult Function()  refresh,required TResult Function()  clearError,required TResult Function()  resetEngagement,required TResult Function()  loadAdVideo,required TResult Function( String transactionId,  int rewardAmount,  String? responseId)  adVideoCompleted,required TResult Function( String reason)  adVideoFailed,required TResult Function()  adShowFailed,required TResult Function( bool isReady)  adReadyStateChanged,required TResult Function( bool isLoading)  adLoadingStateChanged,required TResult Function( int attempt)  adLoadAttemptChanged,required TResult Function( bool success)  adLoadComplete,required TResult Function( String engagementId,  List<UploadedFileEvidence> uploadedFiles,  String? textResponse,  EngagementEvidence evidence)  submitUpload,required TResult Function( double progress,  int bytesTransferred,  int totalBytes)  uploadProgressChanged,}) {final _that = this;
switch (_that) {
case _LoadThreads():
return loadThreads();case _SelectThread():
return selectThread(_that.threadId);case _SelectThreadFromInbox():
return selectThreadFromInbox(_that.threadId,_that.title,_that.description,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.isPinned,_that.isFeatured,_that.availableOpportunities);case _LoadOpportunities():
return loadOpportunities(_that.threadId);case _SelectOpportunity():
return selectOpportunity(_that.opportunityId);case _SetSelectedOpportunity():
return setSelectedOpportunity(_that.opportunity);case _StartEngagement():
return startEngagement(_that.opportunityId);case _UpdateWatchProgress():
return updateWatchProgress(_that.engagementId,_that.watchDurationSeconds);case _SubmitSurvey():
return submitSurvey(_that.engagementId,_that.answers,_that.evidence);case _AbandonEngagement():
return abandonEngagement(_that.engagementId);case _LoadHistory():
return loadHistory(_that.limit);case _LoadMoreHistory():
return loadMoreHistory();case _Refresh():
return refresh();case _ClearError():
return clearError();case _ResetEngagement():
return resetEngagement();case _LoadAdVideo():
return loadAdVideo();case _AdVideoCompleted():
return adVideoCompleted(_that.transactionId,_that.rewardAmount,_that.responseId);case _AdVideoFailed():
return adVideoFailed(_that.reason);case _AdShowFailed():
return adShowFailed();case _AdReadyStateChanged():
return adReadyStateChanged(_that.isReady);case _AdLoadingStateChanged():
return adLoadingStateChanged(_that.isLoading);case _AdLoadAttemptChanged():
return adLoadAttemptChanged(_that.attempt);case _AdLoadComplete():
return adLoadComplete(_that.success);case _SubmitUpload():
return submitUpload(_that.engagementId,_that.uploadedFiles,_that.textResponse,_that.evidence);case _UploadProgressChanged():
return uploadProgressChanged(_that.progress,_that.bytesTransferred,_that.totalBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadThreads,TResult? Function( String threadId)?  selectThread,TResult? Function( String threadId,  String title,  String? description,  String clientId,  String clientName,  String? clientAvatarImage,  String? clientAvatarColor,  String? threadImage,  bool isPinned,  bool isFeatured,  int availableOpportunities)?  selectThreadFromInbox,TResult? Function( String threadId)?  loadOpportunities,TResult? Function( String opportunityId)?  selectOpportunity,TResult? Function( EarnOpportunity opportunity)?  setSelectedOpportunity,TResult? Function( String opportunityId)?  startEngagement,TResult? Function( String engagementId,  int watchDurationSeconds)?  updateWatchProgress,TResult? Function( String engagementId,  List<EngagementAnswer> answers,  EngagementEvidence evidence)?  submitSurvey,TResult? Function( String engagementId)?  abandonEngagement,TResult? Function( int? limit)?  loadHistory,TResult? Function()?  loadMoreHistory,TResult? Function()?  refresh,TResult? Function()?  clearError,TResult? Function()?  resetEngagement,TResult? Function()?  loadAdVideo,TResult? Function( String transactionId,  int rewardAmount,  String? responseId)?  adVideoCompleted,TResult? Function( String reason)?  adVideoFailed,TResult? Function()?  adShowFailed,TResult? Function( bool isReady)?  adReadyStateChanged,TResult? Function( bool isLoading)?  adLoadingStateChanged,TResult? Function( int attempt)?  adLoadAttemptChanged,TResult? Function( bool success)?  adLoadComplete,TResult? Function( String engagementId,  List<UploadedFileEvidence> uploadedFiles,  String? textResponse,  EngagementEvidence evidence)?  submitUpload,TResult? Function( double progress,  int bytesTransferred,  int totalBytes)?  uploadProgressChanged,}) {final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads();case _SelectThread() when selectThread != null:
return selectThread(_that.threadId);case _SelectThreadFromInbox() when selectThreadFromInbox != null:
return selectThreadFromInbox(_that.threadId,_that.title,_that.description,_that.clientId,_that.clientName,_that.clientAvatarImage,_that.clientAvatarColor,_that.threadImage,_that.isPinned,_that.isFeatured,_that.availableOpportunities);case _LoadOpportunities() when loadOpportunities != null:
return loadOpportunities(_that.threadId);case _SelectOpportunity() when selectOpportunity != null:
return selectOpportunity(_that.opportunityId);case _SetSelectedOpportunity() when setSelectedOpportunity != null:
return setSelectedOpportunity(_that.opportunity);case _StartEngagement() when startEngagement != null:
return startEngagement(_that.opportunityId);case _UpdateWatchProgress() when updateWatchProgress != null:
return updateWatchProgress(_that.engagementId,_that.watchDurationSeconds);case _SubmitSurvey() when submitSurvey != null:
return submitSurvey(_that.engagementId,_that.answers,_that.evidence);case _AbandonEngagement() when abandonEngagement != null:
return abandonEngagement(_that.engagementId);case _LoadHistory() when loadHistory != null:
return loadHistory(_that.limit);case _LoadMoreHistory() when loadMoreHistory != null:
return loadMoreHistory();case _Refresh() when refresh != null:
return refresh();case _ClearError() when clearError != null:
return clearError();case _ResetEngagement() when resetEngagement != null:
return resetEngagement();case _LoadAdVideo() when loadAdVideo != null:
return loadAdVideo();case _AdVideoCompleted() when adVideoCompleted != null:
return adVideoCompleted(_that.transactionId,_that.rewardAmount,_that.responseId);case _AdVideoFailed() when adVideoFailed != null:
return adVideoFailed(_that.reason);case _AdShowFailed() when adShowFailed != null:
return adShowFailed();case _AdReadyStateChanged() when adReadyStateChanged != null:
return adReadyStateChanged(_that.isReady);case _AdLoadingStateChanged() when adLoadingStateChanged != null:
return adLoadingStateChanged(_that.isLoading);case _AdLoadAttemptChanged() when adLoadAttemptChanged != null:
return adLoadAttemptChanged(_that.attempt);case _AdLoadComplete() when adLoadComplete != null:
return adLoadComplete(_that.success);case _SubmitUpload() when submitUpload != null:
return submitUpload(_that.engagementId,_that.uploadedFiles,_that.textResponse,_that.evidence);case _UploadProgressChanged() when uploadProgressChanged != null:
return uploadProgressChanged(_that.progress,_that.bytesTransferred,_that.totalBytes);case _:
  return null;

}
}

}

/// @nodoc


class _LoadThreads implements EarnEvent {
  const _LoadThreads();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadThreads);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.loadThreads()';
}


}




/// @nodoc


class _SelectThread implements EarnEvent {
  const _SelectThread(this.threadId);
  

 final  String threadId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectThreadCopyWith<_SelectThread> get copyWith => __$SelectThreadCopyWithImpl<_SelectThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectThread&&(identical(other.threadId, threadId) || other.threadId == threadId));
}


@override
int get hashCode => Object.hash(runtimeType,threadId);

@override
String toString() {
  return 'EarnEvent.selectThread(threadId: $threadId)';
}


}

/// @nodoc
abstract mixin class _$SelectThreadCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SelectThreadCopyWith(_SelectThread value, $Res Function(_SelectThread) _then) = __$SelectThreadCopyWithImpl;
@useResult
$Res call({
 String threadId
});




}
/// @nodoc
class __$SelectThreadCopyWithImpl<$Res>
    implements _$SelectThreadCopyWith<$Res> {
  __$SelectThreadCopyWithImpl(this._self, this._then);

  final _SelectThread _self;
  final $Res Function(_SelectThread) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,}) {
  return _then(_SelectThread(
null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectThreadFromInbox implements EarnEvent {
  const _SelectThreadFromInbox({required this.threadId, required this.title, this.description, required this.clientId, required this.clientName, this.clientAvatarImage, this.clientAvatarColor, this.threadImage, required this.isPinned, required this.isFeatured, required this.availableOpportunities});
  

 final  String threadId;
 final  String title;
 final  String? description;
 final  String clientId;
 final  String clientName;
 final  String? clientAvatarImage;
 final  String? clientAvatarColor;
 final  String? threadImage;
 final  bool isPinned;
 final  bool isFeatured;
 final  int availableOpportunities;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectThreadFromInboxCopyWith<_SelectThreadFromInbox> get copyWith => __$SelectThreadFromInboxCopyWithImpl<_SelectThreadFromInbox>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectThreadFromInbox&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAvatarImage, clientAvatarImage) || other.clientAvatarImage == clientAvatarImage)&&(identical(other.clientAvatarColor, clientAvatarColor) || other.clientAvatarColor == clientAvatarColor)&&(identical(other.threadImage, threadImage) || other.threadImage == threadImage)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.availableOpportunities, availableOpportunities) || other.availableOpportunities == availableOpportunities));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,title,description,clientId,clientName,clientAvatarImage,clientAvatarColor,threadImage,isPinned,isFeatured,availableOpportunities);

@override
String toString() {
  return 'EarnEvent.selectThreadFromInbox(threadId: $threadId, title: $title, description: $description, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, threadImage: $threadImage, isPinned: $isPinned, isFeatured: $isFeatured, availableOpportunities: $availableOpportunities)';
}


}

/// @nodoc
abstract mixin class _$SelectThreadFromInboxCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SelectThreadFromInboxCopyWith(_SelectThreadFromInbox value, $Res Function(_SelectThreadFromInbox) _then) = __$SelectThreadFromInboxCopyWithImpl;
@useResult
$Res call({
 String threadId, String title, String? description, String clientId, String clientName, String? clientAvatarImage, String? clientAvatarColor, String? threadImage, bool isPinned, bool isFeatured, int availableOpportunities
});




}
/// @nodoc
class __$SelectThreadFromInboxCopyWithImpl<$Res>
    implements _$SelectThreadFromInboxCopyWith<$Res> {
  __$SelectThreadFromInboxCopyWithImpl(this._self, this._then);

  final _SelectThreadFromInbox _self;
  final $Res Function(_SelectThreadFromInbox) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? title = null,Object? description = freezed,Object? clientId = null,Object? clientName = null,Object? clientAvatarImage = freezed,Object? clientAvatarColor = freezed,Object? threadImage = freezed,Object? isPinned = null,Object? isFeatured = null,Object? availableOpportunities = null,}) {
  return _then(_SelectThreadFromInbox(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAvatarImage: freezed == clientAvatarImage ? _self.clientAvatarImage : clientAvatarImage // ignore: cast_nullable_to_non_nullable
as String?,clientAvatarColor: freezed == clientAvatarColor ? _self.clientAvatarColor : clientAvatarColor // ignore: cast_nullable_to_non_nullable
as String?,threadImage: freezed == threadImage ? _self.threadImage : threadImage // ignore: cast_nullable_to_non_nullable
as String?,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,availableOpportunities: null == availableOpportunities ? _self.availableOpportunities : availableOpportunities // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _LoadOpportunities implements EarnEvent {
  const _LoadOpportunities({required this.threadId});
  

 final  String threadId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadOpportunitiesCopyWith<_LoadOpportunities> get copyWith => __$LoadOpportunitiesCopyWithImpl<_LoadOpportunities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadOpportunities&&(identical(other.threadId, threadId) || other.threadId == threadId));
}


@override
int get hashCode => Object.hash(runtimeType,threadId);

@override
String toString() {
  return 'EarnEvent.loadOpportunities(threadId: $threadId)';
}


}

/// @nodoc
abstract mixin class _$LoadOpportunitiesCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$LoadOpportunitiesCopyWith(_LoadOpportunities value, $Res Function(_LoadOpportunities) _then) = __$LoadOpportunitiesCopyWithImpl;
@useResult
$Res call({
 String threadId
});




}
/// @nodoc
class __$LoadOpportunitiesCopyWithImpl<$Res>
    implements _$LoadOpportunitiesCopyWith<$Res> {
  __$LoadOpportunitiesCopyWithImpl(this._self, this._then);

  final _LoadOpportunities _self;
  final $Res Function(_LoadOpportunities) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,}) {
  return _then(_LoadOpportunities(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectOpportunity implements EarnEvent {
  const _SelectOpportunity(this.opportunityId);
  

 final  String opportunityId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectOpportunityCopyWith<_SelectOpportunity> get copyWith => __$SelectOpportunityCopyWithImpl<_SelectOpportunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectOpportunity&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId));
}


@override
int get hashCode => Object.hash(runtimeType,opportunityId);

@override
String toString() {
  return 'EarnEvent.selectOpportunity(opportunityId: $opportunityId)';
}


}

/// @nodoc
abstract mixin class _$SelectOpportunityCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SelectOpportunityCopyWith(_SelectOpportunity value, $Res Function(_SelectOpportunity) _then) = __$SelectOpportunityCopyWithImpl;
@useResult
$Res call({
 String opportunityId
});




}
/// @nodoc
class __$SelectOpportunityCopyWithImpl<$Res>
    implements _$SelectOpportunityCopyWith<$Res> {
  __$SelectOpportunityCopyWithImpl(this._self, this._then);

  final _SelectOpportunity _self;
  final $Res Function(_SelectOpportunity) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? opportunityId = null,}) {
  return _then(_SelectOpportunity(
null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SetSelectedOpportunity implements EarnEvent {
  const _SetSelectedOpportunity(this.opportunity);
  

 final  EarnOpportunity opportunity;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetSelectedOpportunityCopyWith<_SetSelectedOpportunity> get copyWith => __$SetSelectedOpportunityCopyWithImpl<_SetSelectedOpportunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetSelectedOpportunity&&(identical(other.opportunity, opportunity) || other.opportunity == opportunity));
}


@override
int get hashCode => Object.hash(runtimeType,opportunity);

@override
String toString() {
  return 'EarnEvent.setSelectedOpportunity(opportunity: $opportunity)';
}


}

/// @nodoc
abstract mixin class _$SetSelectedOpportunityCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SetSelectedOpportunityCopyWith(_SetSelectedOpportunity value, $Res Function(_SetSelectedOpportunity) _then) = __$SetSelectedOpportunityCopyWithImpl;
@useResult
$Res call({
 EarnOpportunity opportunity
});


$EarnOpportunityCopyWith<$Res> get opportunity;

}
/// @nodoc
class __$SetSelectedOpportunityCopyWithImpl<$Res>
    implements _$SetSelectedOpportunityCopyWith<$Res> {
  __$SetSelectedOpportunityCopyWithImpl(this._self, this._then);

  final _SetSelectedOpportunity _self;
  final $Res Function(_SetSelectedOpportunity) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? opportunity = null,}) {
  return _then(_SetSelectedOpportunity(
null == opportunity ? _self.opportunity : opportunity // ignore: cast_nullable_to_non_nullable
as EarnOpportunity,
  ));
}

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarnOpportunityCopyWith<$Res> get opportunity {
  
  return $EarnOpportunityCopyWith<$Res>(_self.opportunity, (value) {
    return _then(_self.copyWith(opportunity: value));
  });
}
}

/// @nodoc


class _StartEngagement implements EarnEvent {
  const _StartEngagement({required this.opportunityId});
  

 final  String opportunityId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartEngagementCopyWith<_StartEngagement> get copyWith => __$StartEngagementCopyWithImpl<_StartEngagement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartEngagement&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId));
}


@override
int get hashCode => Object.hash(runtimeType,opportunityId);

@override
String toString() {
  return 'EarnEvent.startEngagement(opportunityId: $opportunityId)';
}


}

/// @nodoc
abstract mixin class _$StartEngagementCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$StartEngagementCopyWith(_StartEngagement value, $Res Function(_StartEngagement) _then) = __$StartEngagementCopyWithImpl;
@useResult
$Res call({
 String opportunityId
});




}
/// @nodoc
class __$StartEngagementCopyWithImpl<$Res>
    implements _$StartEngagementCopyWith<$Res> {
  __$StartEngagementCopyWithImpl(this._self, this._then);

  final _StartEngagement _self;
  final $Res Function(_StartEngagement) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? opportunityId = null,}) {
  return _then(_StartEngagement(
opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateWatchProgress implements EarnEvent {
  const _UpdateWatchProgress({required this.engagementId, required this.watchDurationSeconds});
  

 final  String engagementId;
 final  int watchDurationSeconds;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateWatchProgressCopyWith<_UpdateWatchProgress> get copyWith => __$UpdateWatchProgressCopyWithImpl<_UpdateWatchProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateWatchProgress&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,engagementId,watchDurationSeconds);

@override
String toString() {
  return 'EarnEvent.updateWatchProgress(engagementId: $engagementId, watchDurationSeconds: $watchDurationSeconds)';
}


}

/// @nodoc
abstract mixin class _$UpdateWatchProgressCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$UpdateWatchProgressCopyWith(_UpdateWatchProgress value, $Res Function(_UpdateWatchProgress) _then) = __$UpdateWatchProgressCopyWithImpl;
@useResult
$Res call({
 String engagementId, int watchDurationSeconds
});




}
/// @nodoc
class __$UpdateWatchProgressCopyWithImpl<$Res>
    implements _$UpdateWatchProgressCopyWith<$Res> {
  __$UpdateWatchProgressCopyWithImpl(this._self, this._then);

  final _UpdateWatchProgress _self;
  final $Res Function(_UpdateWatchProgress) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? engagementId = null,Object? watchDurationSeconds = null,}) {
  return _then(_UpdateWatchProgress(
engagementId: null == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String,watchDurationSeconds: null == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SubmitSurvey implements EarnEvent {
  const _SubmitSurvey({required this.engagementId, required final  List<EngagementAnswer> answers, required this.evidence}): _answers = answers;
  

 final  String engagementId;
 final  List<EngagementAnswer> _answers;
 List<EngagementAnswer> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

 final  EngagementEvidence evidence;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitSurveyCopyWith<_SubmitSurvey> get copyWith => __$SubmitSurveyCopyWithImpl<_SubmitSurvey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSurvey&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.evidence, evidence) || other.evidence == evidence));
}


@override
int get hashCode => Object.hash(runtimeType,engagementId,const DeepCollectionEquality().hash(_answers),evidence);

@override
String toString() {
  return 'EarnEvent.submitSurvey(engagementId: $engagementId, answers: $answers, evidence: $evidence)';
}


}

/// @nodoc
abstract mixin class _$SubmitSurveyCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SubmitSurveyCopyWith(_SubmitSurvey value, $Res Function(_SubmitSurvey) _then) = __$SubmitSurveyCopyWithImpl;
@useResult
$Res call({
 String engagementId, List<EngagementAnswer> answers, EngagementEvidence evidence
});


$EngagementEvidenceCopyWith<$Res> get evidence;

}
/// @nodoc
class __$SubmitSurveyCopyWithImpl<$Res>
    implements _$SubmitSurveyCopyWith<$Res> {
  __$SubmitSurveyCopyWithImpl(this._self, this._then);

  final _SubmitSurvey _self;
  final $Res Function(_SubmitSurvey) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? engagementId = null,Object? answers = null,Object? evidence = null,}) {
  return _then(_SubmitSurvey(
engagementId: null == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<EngagementAnswer>,evidence: null == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidence,
  ));
}

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceCopyWith<$Res> get evidence {
  
  return $EngagementEvidenceCopyWith<$Res>(_self.evidence, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}

/// @nodoc


class _AbandonEngagement implements EarnEvent {
  const _AbandonEngagement(this.engagementId);
  

 final  String engagementId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbandonEngagementCopyWith<_AbandonEngagement> get copyWith => __$AbandonEngagementCopyWithImpl<_AbandonEngagement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbandonEngagement&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId));
}


@override
int get hashCode => Object.hash(runtimeType,engagementId);

@override
String toString() {
  return 'EarnEvent.abandonEngagement(engagementId: $engagementId)';
}


}

/// @nodoc
abstract mixin class _$AbandonEngagementCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AbandonEngagementCopyWith(_AbandonEngagement value, $Res Function(_AbandonEngagement) _then) = __$AbandonEngagementCopyWithImpl;
@useResult
$Res call({
 String engagementId
});




}
/// @nodoc
class __$AbandonEngagementCopyWithImpl<$Res>
    implements _$AbandonEngagementCopyWith<$Res> {
  __$AbandonEngagementCopyWithImpl(this._self, this._then);

  final _AbandonEngagement _self;
  final $Res Function(_AbandonEngagement) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? engagementId = null,}) {
  return _then(_AbandonEngagement(
null == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadHistory implements EarnEvent {
  const _LoadHistory({this.limit});
  

 final  int? limit;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadHistoryCopyWith<_LoadHistory> get copyWith => __$LoadHistoryCopyWithImpl<_LoadHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHistory&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString() {
  return 'EarnEvent.loadHistory(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadHistoryCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$LoadHistoryCopyWith(_LoadHistory value, $Res Function(_LoadHistory) _then) = __$LoadHistoryCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$LoadHistoryCopyWithImpl<$Res>
    implements _$LoadHistoryCopyWith<$Res> {
  __$LoadHistoryCopyWithImpl(this._self, this._then);

  final _LoadHistory _self;
  final $Res Function(_LoadHistory) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_LoadHistory(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LoadMoreHistory implements EarnEvent {
  const _LoadMoreHistory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreHistory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.loadMoreHistory()';
}


}




/// @nodoc


class _Refresh implements EarnEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.refresh()';
}


}




/// @nodoc


class _ClearError implements EarnEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.clearError()';
}


}




/// @nodoc


class _ResetEngagement implements EarnEvent {
  const _ResetEngagement();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetEngagement);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.resetEngagement()';
}


}




/// @nodoc


class _LoadAdVideo implements EarnEvent {
  const _LoadAdVideo();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAdVideo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.loadAdVideo()';
}


}




/// @nodoc


class _AdVideoCompleted implements EarnEvent {
  const _AdVideoCompleted({required this.transactionId, required this.rewardAmount, this.responseId});
  

 final  String transactionId;
 final  int rewardAmount;
 final  String? responseId;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdVideoCompletedCopyWith<_AdVideoCompleted> get copyWith => __$AdVideoCompletedCopyWithImpl<_AdVideoCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdVideoCompleted&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.rewardAmount, rewardAmount) || other.rewardAmount == rewardAmount)&&(identical(other.responseId, responseId) || other.responseId == responseId));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,rewardAmount,responseId);

@override
String toString() {
  return 'EarnEvent.adVideoCompleted(transactionId: $transactionId, rewardAmount: $rewardAmount, responseId: $responseId)';
}


}

/// @nodoc
abstract mixin class _$AdVideoCompletedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdVideoCompletedCopyWith(_AdVideoCompleted value, $Res Function(_AdVideoCompleted) _then) = __$AdVideoCompletedCopyWithImpl;
@useResult
$Res call({
 String transactionId, int rewardAmount, String? responseId
});




}
/// @nodoc
class __$AdVideoCompletedCopyWithImpl<$Res>
    implements _$AdVideoCompletedCopyWith<$Res> {
  __$AdVideoCompletedCopyWithImpl(this._self, this._then);

  final _AdVideoCompleted _self;
  final $Res Function(_AdVideoCompleted) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? rewardAmount = null,Object? responseId = freezed,}) {
  return _then(_AdVideoCompleted(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,rewardAmount: null == rewardAmount ? _self.rewardAmount : rewardAmount // ignore: cast_nullable_to_non_nullable
as int,responseId: freezed == responseId ? _self.responseId : responseId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AdVideoFailed implements EarnEvent {
  const _AdVideoFailed({required this.reason});
  

 final  String reason;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdVideoFailedCopyWith<_AdVideoFailed> get copyWith => __$AdVideoFailedCopyWithImpl<_AdVideoFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdVideoFailed&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'EarnEvent.adVideoFailed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$AdVideoFailedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdVideoFailedCopyWith(_AdVideoFailed value, $Res Function(_AdVideoFailed) _then) = __$AdVideoFailedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class __$AdVideoFailedCopyWithImpl<$Res>
    implements _$AdVideoFailedCopyWith<$Res> {
  __$AdVideoFailedCopyWithImpl(this._self, this._then);

  final _AdVideoFailed _self;
  final $Res Function(_AdVideoFailed) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(_AdVideoFailed(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AdShowFailed implements EarnEvent {
  const _AdShowFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdShowFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnEvent.adShowFailed()';
}


}




/// @nodoc


class _AdReadyStateChanged implements EarnEvent {
  const _AdReadyStateChanged({required this.isReady});
  

 final  bool isReady;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdReadyStateChangedCopyWith<_AdReadyStateChanged> get copyWith => __$AdReadyStateChangedCopyWithImpl<_AdReadyStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdReadyStateChanged&&(identical(other.isReady, isReady) || other.isReady == isReady));
}


@override
int get hashCode => Object.hash(runtimeType,isReady);

@override
String toString() {
  return 'EarnEvent.adReadyStateChanged(isReady: $isReady)';
}


}

/// @nodoc
abstract mixin class _$AdReadyStateChangedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdReadyStateChangedCopyWith(_AdReadyStateChanged value, $Res Function(_AdReadyStateChanged) _then) = __$AdReadyStateChangedCopyWithImpl;
@useResult
$Res call({
 bool isReady
});




}
/// @nodoc
class __$AdReadyStateChangedCopyWithImpl<$Res>
    implements _$AdReadyStateChangedCopyWith<$Res> {
  __$AdReadyStateChangedCopyWithImpl(this._self, this._then);

  final _AdReadyStateChanged _self;
  final $Res Function(_AdReadyStateChanged) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isReady = null,}) {
  return _then(_AdReadyStateChanged(
isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _AdLoadingStateChanged implements EarnEvent {
  const _AdLoadingStateChanged({required this.isLoading});
  

 final  bool isLoading;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdLoadingStateChangedCopyWith<_AdLoadingStateChanged> get copyWith => __$AdLoadingStateChangedCopyWithImpl<_AdLoadingStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdLoadingStateChanged&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'EarnEvent.adLoadingStateChanged(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$AdLoadingStateChangedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdLoadingStateChangedCopyWith(_AdLoadingStateChanged value, $Res Function(_AdLoadingStateChanged) _then) = __$AdLoadingStateChangedCopyWithImpl;
@useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class __$AdLoadingStateChangedCopyWithImpl<$Res>
    implements _$AdLoadingStateChangedCopyWith<$Res> {
  __$AdLoadingStateChangedCopyWithImpl(this._self, this._then);

  final _AdLoadingStateChanged _self;
  final $Res Function(_AdLoadingStateChanged) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isLoading = null,}) {
  return _then(_AdLoadingStateChanged(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _AdLoadAttemptChanged implements EarnEvent {
  const _AdLoadAttemptChanged({required this.attempt});
  

 final  int attempt;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdLoadAttemptChangedCopyWith<_AdLoadAttemptChanged> get copyWith => __$AdLoadAttemptChangedCopyWithImpl<_AdLoadAttemptChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdLoadAttemptChanged&&(identical(other.attempt, attempt) || other.attempt == attempt));
}


@override
int get hashCode => Object.hash(runtimeType,attempt);

@override
String toString() {
  return 'EarnEvent.adLoadAttemptChanged(attempt: $attempt)';
}


}

/// @nodoc
abstract mixin class _$AdLoadAttemptChangedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdLoadAttemptChangedCopyWith(_AdLoadAttemptChanged value, $Res Function(_AdLoadAttemptChanged) _then) = __$AdLoadAttemptChangedCopyWithImpl;
@useResult
$Res call({
 int attempt
});




}
/// @nodoc
class __$AdLoadAttemptChangedCopyWithImpl<$Res>
    implements _$AdLoadAttemptChangedCopyWith<$Res> {
  __$AdLoadAttemptChangedCopyWithImpl(this._self, this._then);

  final _AdLoadAttemptChanged _self;
  final $Res Function(_AdLoadAttemptChanged) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attempt = null,}) {
  return _then(_AdLoadAttemptChanged(
attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AdLoadComplete implements EarnEvent {
  const _AdLoadComplete({required this.success});
  

 final  bool success;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdLoadCompleteCopyWith<_AdLoadComplete> get copyWith => __$AdLoadCompleteCopyWithImpl<_AdLoadComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdLoadComplete&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,success);

@override
String toString() {
  return 'EarnEvent.adLoadComplete(success: $success)';
}


}

/// @nodoc
abstract mixin class _$AdLoadCompleteCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$AdLoadCompleteCopyWith(_AdLoadComplete value, $Res Function(_AdLoadComplete) _then) = __$AdLoadCompleteCopyWithImpl;
@useResult
$Res call({
 bool success
});




}
/// @nodoc
class __$AdLoadCompleteCopyWithImpl<$Res>
    implements _$AdLoadCompleteCopyWith<$Res> {
  __$AdLoadCompleteCopyWithImpl(this._self, this._then);

  final _AdLoadComplete _self;
  final $Res Function(_AdLoadComplete) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? success = null,}) {
  return _then(_AdLoadComplete(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SubmitUpload implements EarnEvent {
  const _SubmitUpload({required this.engagementId, required final  List<UploadedFileEvidence> uploadedFiles, this.textResponse, required this.evidence}): _uploadedFiles = uploadedFiles;
  

 final  String engagementId;
 final  List<UploadedFileEvidence> _uploadedFiles;
 List<UploadedFileEvidence> get uploadedFiles {
  if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadedFiles);
}

 final  String? textResponse;
 final  EngagementEvidence evidence;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitUploadCopyWith<_SubmitUpload> get copyWith => __$SubmitUploadCopyWithImpl<_SubmitUpload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitUpload&&(identical(other.engagementId, engagementId) || other.engagementId == engagementId)&&const DeepCollectionEquality().equals(other._uploadedFiles, _uploadedFiles)&&(identical(other.textResponse, textResponse) || other.textResponse == textResponse)&&(identical(other.evidence, evidence) || other.evidence == evidence));
}


@override
int get hashCode => Object.hash(runtimeType,engagementId,const DeepCollectionEquality().hash(_uploadedFiles),textResponse,evidence);

@override
String toString() {
  return 'EarnEvent.submitUpload(engagementId: $engagementId, uploadedFiles: $uploadedFiles, textResponse: $textResponse, evidence: $evidence)';
}


}

/// @nodoc
abstract mixin class _$SubmitUploadCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$SubmitUploadCopyWith(_SubmitUpload value, $Res Function(_SubmitUpload) _then) = __$SubmitUploadCopyWithImpl;
@useResult
$Res call({
 String engagementId, List<UploadedFileEvidence> uploadedFiles, String? textResponse, EngagementEvidence evidence
});


$EngagementEvidenceCopyWith<$Res> get evidence;

}
/// @nodoc
class __$SubmitUploadCopyWithImpl<$Res>
    implements _$SubmitUploadCopyWith<$Res> {
  __$SubmitUploadCopyWithImpl(this._self, this._then);

  final _SubmitUpload _self;
  final $Res Function(_SubmitUpload) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? engagementId = null,Object? uploadedFiles = null,Object? textResponse = freezed,Object? evidence = null,}) {
  return _then(_SubmitUpload(
engagementId: null == engagementId ? _self.engagementId : engagementId // ignore: cast_nullable_to_non_nullable
as String,uploadedFiles: null == uploadedFiles ? _self._uploadedFiles : uploadedFiles // ignore: cast_nullable_to_non_nullable
as List<UploadedFileEvidence>,textResponse: freezed == textResponse ? _self.textResponse : textResponse // ignore: cast_nullable_to_non_nullable
as String?,evidence: null == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as EngagementEvidence,
  ));
}

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementEvidenceCopyWith<$Res> get evidence {
  
  return $EngagementEvidenceCopyWith<$Res>(_self.evidence, (value) {
    return _then(_self.copyWith(evidence: value));
  });
}
}

/// @nodoc


class _UploadProgressChanged implements EarnEvent {
  const _UploadProgressChanged({required this.progress, required this.bytesTransferred, required this.totalBytes});
  

 final  double progress;
 final  int bytesTransferred;
 final  int totalBytes;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadProgressChangedCopyWith<_UploadProgressChanged> get copyWith => __$UploadProgressChangedCopyWithImpl<_UploadProgressChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadProgressChanged&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.bytesTransferred, bytesTransferred) || other.bytesTransferred == bytesTransferred)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes));
}


@override
int get hashCode => Object.hash(runtimeType,progress,bytesTransferred,totalBytes);

@override
String toString() {
  return 'EarnEvent.uploadProgressChanged(progress: $progress, bytesTransferred: $bytesTransferred, totalBytes: $totalBytes)';
}


}

/// @nodoc
abstract mixin class _$UploadProgressChangedCopyWith<$Res> implements $EarnEventCopyWith<$Res> {
  factory _$UploadProgressChangedCopyWith(_UploadProgressChanged value, $Res Function(_UploadProgressChanged) _then) = __$UploadProgressChangedCopyWithImpl;
@useResult
$Res call({
 double progress, int bytesTransferred, int totalBytes
});




}
/// @nodoc
class __$UploadProgressChangedCopyWithImpl<$Res>
    implements _$UploadProgressChangedCopyWith<$Res> {
  __$UploadProgressChangedCopyWithImpl(this._self, this._then);

  final _UploadProgressChanged _self;
  final $Res Function(_UploadProgressChanged) _then;

/// Create a copy of EarnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? bytesTransferred = null,Object? totalBytes = null,}) {
  return _then(_UploadProgressChanged(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,bytesTransferred: null == bytesTransferred ? _self.bytesTransferred : bytesTransferred // ignore: cast_nullable_to_non_nullable
as int,totalBytes: null == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$EarnState {

 EarnStatus get status; List<EarnThread> get threads; EarnThread? get selectedThread; EarnStatus get opportunitiesStatus;/// Tracks which threadId the current [opportunities] list belongs to.
/// Used to detect pre-fetched opportunities and skip redundant CF calls.
 String? get opportunitiesThreadId; List<EarnOpportunity> get opportunities; EarnOpportunity? get selectedOpportunity; Engagement? get currentEngagement; EngagementPhase get engagementPhase; List<Engagement> get history; bool get isLoadingHistory; bool get hasMoreHistory; DateTime? get lastHistoryTimestamp; String? get errorMessage; int get totalAvailableOpportunities;// Daily completion limit
 int get dailyCompletions; int get dailyEarnCap; bool get dailyLimitReached;// AdMob state
 bool get isAdLoading; bool get isAdReady; String? get adTransactionId;/// AdMob response ID — uniquely identifies the ad impression for debugging
 String? get adResponseId;/// Current load attempt (1-based) shown during loading; 0 when idle
 int get adLoadAttempt;/// How many full retry rounds have been exhausted (0 = first attempt, 1 = user retried once)
 int get adRetryRound;/// Consecutive show failures — ad SDK said loaded but play failed.
/// Reset to 0 on successful completion or engagement reset.
 int get adShowFailureCount;// Upload progress
 double? get uploadProgress; int? get uploadBytesTransferred; int? get uploadTotalBytes;/// Whether the completed engagement is pending admin review
 bool get isPendingReview;// Reward allocation state (set after engagement completion)
 String? get rewardItemId; String? get rewardCampaignName; String? get rewardType;
/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnStateCopyWith<EarnState> get copyWith => _$EarnStateCopyWithImpl<EarnState>(this as EarnState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.threads, threads)&&(identical(other.selectedThread, selectedThread) || other.selectedThread == selectedThread)&&(identical(other.opportunitiesStatus, opportunitiesStatus) || other.opportunitiesStatus == opportunitiesStatus)&&(identical(other.opportunitiesThreadId, opportunitiesThreadId) || other.opportunitiesThreadId == opportunitiesThreadId)&&const DeepCollectionEquality().equals(other.opportunities, opportunities)&&(identical(other.selectedOpportunity, selectedOpportunity) || other.selectedOpportunity == selectedOpportunity)&&(identical(other.currentEngagement, currentEngagement) || other.currentEngagement == currentEngagement)&&(identical(other.engagementPhase, engagementPhase) || other.engagementPhase == engagementPhase)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.lastHistoryTimestamp, lastHistoryTimestamp) || other.lastHistoryTimestamp == lastHistoryTimestamp)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.totalAvailableOpportunities, totalAvailableOpportunities) || other.totalAvailableOpportunities == totalAvailableOpportunities)&&(identical(other.dailyCompletions, dailyCompletions) || other.dailyCompletions == dailyCompletions)&&(identical(other.dailyEarnCap, dailyEarnCap) || other.dailyEarnCap == dailyEarnCap)&&(identical(other.dailyLimitReached, dailyLimitReached) || other.dailyLimitReached == dailyLimitReached)&&(identical(other.isAdLoading, isAdLoading) || other.isAdLoading == isAdLoading)&&(identical(other.isAdReady, isAdReady) || other.isAdReady == isAdReady)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&(identical(other.adLoadAttempt, adLoadAttempt) || other.adLoadAttempt == adLoadAttempt)&&(identical(other.adRetryRound, adRetryRound) || other.adRetryRound == adRetryRound)&&(identical(other.adShowFailureCount, adShowFailureCount) || other.adShowFailureCount == adShowFailureCount)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.uploadBytesTransferred, uploadBytesTransferred) || other.uploadBytesTransferred == uploadBytesTransferred)&&(identical(other.uploadTotalBytes, uploadTotalBytes) || other.uploadTotalBytes == uploadTotalBytes)&&(identical(other.isPendingReview, isPendingReview) || other.isPendingReview == isPendingReview)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(threads),selectedThread,opportunitiesStatus,opportunitiesThreadId,const DeepCollectionEquality().hash(opportunities),selectedOpportunity,currentEngagement,engagementPhase,const DeepCollectionEquality().hash(history),isLoadingHistory,hasMoreHistory,lastHistoryTimestamp,errorMessage,totalAvailableOpportunities,dailyCompletions,dailyEarnCap,dailyLimitReached,isAdLoading,isAdReady,adTransactionId,adResponseId,adLoadAttempt,adRetryRound,adShowFailureCount,uploadProgress,uploadBytesTransferred,uploadTotalBytes,isPendingReview,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'EarnState(status: $status, threads: $threads, selectedThread: $selectedThread, opportunitiesStatus: $opportunitiesStatus, opportunitiesThreadId: $opportunitiesThreadId, opportunities: $opportunities, selectedOpportunity: $selectedOpportunity, currentEngagement: $currentEngagement, engagementPhase: $engagementPhase, history: $history, isLoadingHistory: $isLoadingHistory, hasMoreHistory: $hasMoreHistory, lastHistoryTimestamp: $lastHistoryTimestamp, errorMessage: $errorMessage, totalAvailableOpportunities: $totalAvailableOpportunities, dailyCompletions: $dailyCompletions, dailyEarnCap: $dailyEarnCap, dailyLimitReached: $dailyLimitReached, isAdLoading: $isAdLoading, isAdReady: $isAdReady, adTransactionId: $adTransactionId, adResponseId: $adResponseId, adLoadAttempt: $adLoadAttempt, adRetryRound: $adRetryRound, adShowFailureCount: $adShowFailureCount, uploadProgress: $uploadProgress, uploadBytesTransferred: $uploadBytesTransferred, uploadTotalBytes: $uploadTotalBytes, isPendingReview: $isPendingReview, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class $EarnStateCopyWith<$Res>  {
  factory $EarnStateCopyWith(EarnState value, $Res Function(EarnState) _then) = _$EarnStateCopyWithImpl;
@useResult
$Res call({
 EarnStatus status, List<EarnThread> threads, EarnThread? selectedThread, EarnStatus opportunitiesStatus, String? opportunitiesThreadId, List<EarnOpportunity> opportunities, EarnOpportunity? selectedOpportunity, Engagement? currentEngagement, EngagementPhase engagementPhase, List<Engagement> history, bool isLoadingHistory, bool hasMoreHistory, DateTime? lastHistoryTimestamp, String? errorMessage, int totalAvailableOpportunities, int dailyCompletions, int dailyEarnCap, bool dailyLimitReached, bool isAdLoading, bool isAdReady, String? adTransactionId, String? adResponseId, int adLoadAttempt, int adRetryRound, int adShowFailureCount, double? uploadProgress, int? uploadBytesTransferred, int? uploadTotalBytes, bool isPendingReview, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


$EarnThreadCopyWith<$Res>? get selectedThread;$EarnOpportunityCopyWith<$Res>? get selectedOpportunity;$EngagementCopyWith<$Res>? get currentEngagement;

}
/// @nodoc
class _$EarnStateCopyWithImpl<$Res>
    implements $EarnStateCopyWith<$Res> {
  _$EarnStateCopyWithImpl(this._self, this._then);

  final EarnState _self;
  final $Res Function(EarnState) _then;

/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? threads = null,Object? selectedThread = freezed,Object? opportunitiesStatus = null,Object? opportunitiesThreadId = freezed,Object? opportunities = null,Object? selectedOpportunity = freezed,Object? currentEngagement = freezed,Object? engagementPhase = null,Object? history = null,Object? isLoadingHistory = null,Object? hasMoreHistory = null,Object? lastHistoryTimestamp = freezed,Object? errorMessage = freezed,Object? totalAvailableOpportunities = null,Object? dailyCompletions = null,Object? dailyEarnCap = null,Object? dailyLimitReached = null,Object? isAdLoading = null,Object? isAdReady = null,Object? adTransactionId = freezed,Object? adResponseId = freezed,Object? adLoadAttempt = null,Object? adRetryRound = null,Object? adShowFailureCount = null,Object? uploadProgress = freezed,Object? uploadBytesTransferred = freezed,Object? uploadTotalBytes = freezed,Object? isPendingReview = null,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnStatus,threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as List<EarnThread>,selectedThread: freezed == selectedThread ? _self.selectedThread : selectedThread // ignore: cast_nullable_to_non_nullable
as EarnThread?,opportunitiesStatus: null == opportunitiesStatus ? _self.opportunitiesStatus : opportunitiesStatus // ignore: cast_nullable_to_non_nullable
as EarnStatus,opportunitiesThreadId: freezed == opportunitiesThreadId ? _self.opportunitiesThreadId : opportunitiesThreadId // ignore: cast_nullable_to_non_nullable
as String?,opportunities: null == opportunities ? _self.opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<EarnOpportunity>,selectedOpportunity: freezed == selectedOpportunity ? _self.selectedOpportunity : selectedOpportunity // ignore: cast_nullable_to_non_nullable
as EarnOpportunity?,currentEngagement: freezed == currentEngagement ? _self.currentEngagement : currentEngagement // ignore: cast_nullable_to_non_nullable
as Engagement?,engagementPhase: null == engagementPhase ? _self.engagementPhase : engagementPhase // ignore: cast_nullable_to_non_nullable
as EngagementPhase,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Engagement>,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,lastHistoryTimestamp: freezed == lastHistoryTimestamp ? _self.lastHistoryTimestamp : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,totalAvailableOpportunities: null == totalAvailableOpportunities ? _self.totalAvailableOpportunities : totalAvailableOpportunities // ignore: cast_nullable_to_non_nullable
as int,dailyCompletions: null == dailyCompletions ? _self.dailyCompletions : dailyCompletions // ignore: cast_nullable_to_non_nullable
as int,dailyEarnCap: null == dailyEarnCap ? _self.dailyEarnCap : dailyEarnCap // ignore: cast_nullable_to_non_nullable
as int,dailyLimitReached: null == dailyLimitReached ? _self.dailyLimitReached : dailyLimitReached // ignore: cast_nullable_to_non_nullable
as bool,isAdLoading: null == isAdLoading ? _self.isAdLoading : isAdLoading // ignore: cast_nullable_to_non_nullable
as bool,isAdReady: null == isAdReady ? _self.isAdReady : isAdReady // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adResponseId: freezed == adResponseId ? _self.adResponseId : adResponseId // ignore: cast_nullable_to_non_nullable
as String?,adLoadAttempt: null == adLoadAttempt ? _self.adLoadAttempt : adLoadAttempt // ignore: cast_nullable_to_non_nullable
as int,adRetryRound: null == adRetryRound ? _self.adRetryRound : adRetryRound // ignore: cast_nullable_to_non_nullable
as int,adShowFailureCount: null == adShowFailureCount ? _self.adShowFailureCount : adShowFailureCount // ignore: cast_nullable_to_non_nullable
as int,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,uploadBytesTransferred: freezed == uploadBytesTransferred ? _self.uploadBytesTransferred : uploadBytesTransferred // ignore: cast_nullable_to_non_nullable
as int?,uploadTotalBytes: freezed == uploadTotalBytes ? _self.uploadTotalBytes : uploadTotalBytes // ignore: cast_nullable_to_non_nullable
as int?,isPendingReview: null == isPendingReview ? _self.isPendingReview : isPendingReview // ignore: cast_nullable_to_non_nullable
as bool,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarnThreadCopyWith<$Res>? get selectedThread {
    if (_self.selectedThread == null) {
    return null;
  }

  return $EarnThreadCopyWith<$Res>(_self.selectedThread!, (value) {
    return _then(_self.copyWith(selectedThread: value));
  });
}/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarnOpportunityCopyWith<$Res>? get selectedOpportunity {
    if (_self.selectedOpportunity == null) {
    return null;
  }

  return $EarnOpportunityCopyWith<$Res>(_self.selectedOpportunity!, (value) {
    return _then(_self.copyWith(selectedOpportunity: value));
  });
}/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementCopyWith<$Res>? get currentEngagement {
    if (_self.currentEngagement == null) {
    return null;
  }

  return $EngagementCopyWith<$Res>(_self.currentEngagement!, (value) {
    return _then(_self.copyWith(currentEngagement: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarnState].
extension EarnStatePatterns on EarnState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnState value)  $default,){
final _that = this;
switch (_that) {
case _EarnState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnState value)?  $default,){
final _that = this;
switch (_that) {
case _EarnState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarnStatus status,  List<EarnThread> threads,  EarnThread? selectedThread,  EarnStatus opportunitiesStatus,  String? opportunitiesThreadId,  List<EarnOpportunity> opportunities,  EarnOpportunity? selectedOpportunity,  Engagement? currentEngagement,  EngagementPhase engagementPhase,  List<Engagement> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  String? errorMessage,  int totalAvailableOpportunities,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  bool isAdLoading,  bool isAdReady,  String? adTransactionId,  String? adResponseId,  int adLoadAttempt,  int adRetryRound,  int adShowFailureCount,  double? uploadProgress,  int? uploadBytesTransferred,  int? uploadTotalBytes,  bool isPendingReview,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnState() when $default != null:
return $default(_that.status,_that.threads,_that.selectedThread,_that.opportunitiesStatus,_that.opportunitiesThreadId,_that.opportunities,_that.selectedOpportunity,_that.currentEngagement,_that.engagementPhase,_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.errorMessage,_that.totalAvailableOpportunities,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.isAdLoading,_that.isAdReady,_that.adTransactionId,_that.adResponseId,_that.adLoadAttempt,_that.adRetryRound,_that.adShowFailureCount,_that.uploadProgress,_that.uploadBytesTransferred,_that.uploadTotalBytes,_that.isPendingReview,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarnStatus status,  List<EarnThread> threads,  EarnThread? selectedThread,  EarnStatus opportunitiesStatus,  String? opportunitiesThreadId,  List<EarnOpportunity> opportunities,  EarnOpportunity? selectedOpportunity,  Engagement? currentEngagement,  EngagementPhase engagementPhase,  List<Engagement> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  String? errorMessage,  int totalAvailableOpportunities,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  bool isAdLoading,  bool isAdReady,  String? adTransactionId,  String? adResponseId,  int adLoadAttempt,  int adRetryRound,  int adShowFailureCount,  double? uploadProgress,  int? uploadBytesTransferred,  int? uploadTotalBytes,  bool isPendingReview,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)  $default,) {final _that = this;
switch (_that) {
case _EarnState():
return $default(_that.status,_that.threads,_that.selectedThread,_that.opportunitiesStatus,_that.opportunitiesThreadId,_that.opportunities,_that.selectedOpportunity,_that.currentEngagement,_that.engagementPhase,_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.errorMessage,_that.totalAvailableOpportunities,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.isAdLoading,_that.isAdReady,_that.adTransactionId,_that.adResponseId,_that.adLoadAttempt,_that.adRetryRound,_that.adShowFailureCount,_that.uploadProgress,_that.uploadBytesTransferred,_that.uploadTotalBytes,_that.isPendingReview,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarnStatus status,  List<EarnThread> threads,  EarnThread? selectedThread,  EarnStatus opportunitiesStatus,  String? opportunitiesThreadId,  List<EarnOpportunity> opportunities,  EarnOpportunity? selectedOpportunity,  Engagement? currentEngagement,  EngagementPhase engagementPhase,  List<Engagement> history,  bool isLoadingHistory,  bool hasMoreHistory,  DateTime? lastHistoryTimestamp,  String? errorMessage,  int totalAvailableOpportunities,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  bool isAdLoading,  bool isAdReady,  String? adTransactionId,  String? adResponseId,  int adLoadAttempt,  int adRetryRound,  int adShowFailureCount,  double? uploadProgress,  int? uploadBytesTransferred,  int? uploadTotalBytes,  bool isPendingReview,  String? rewardItemId,  String? rewardCampaignName,  String? rewardType)?  $default,) {final _that = this;
switch (_that) {
case _EarnState() when $default != null:
return $default(_that.status,_that.threads,_that.selectedThread,_that.opportunitiesStatus,_that.opportunitiesThreadId,_that.opportunities,_that.selectedOpportunity,_that.currentEngagement,_that.engagementPhase,_that.history,_that.isLoadingHistory,_that.hasMoreHistory,_that.lastHistoryTimestamp,_that.errorMessage,_that.totalAvailableOpportunities,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.isAdLoading,_that.isAdReady,_that.adTransactionId,_that.adResponseId,_that.adLoadAttempt,_that.adRetryRound,_that.adShowFailureCount,_that.uploadProgress,_that.uploadBytesTransferred,_that.uploadTotalBytes,_that.isPendingReview,_that.rewardItemId,_that.rewardCampaignName,_that.rewardType);case _:
  return null;

}
}

}

/// @nodoc


class _EarnState extends EarnState {
  const _EarnState({this.status = EarnStatus.initial, final  List<EarnThread> threads = const [], this.selectedThread, this.opportunitiesStatus = EarnStatus.initial, this.opportunitiesThreadId, final  List<EarnOpportunity> opportunities = const [], this.selectedOpportunity, this.currentEngagement, this.engagementPhase = EngagementPhase.idle, final  List<Engagement> history = const [], this.isLoadingHistory = false, this.hasMoreHistory = false, this.lastHistoryTimestamp, this.errorMessage, this.totalAvailableOpportunities = 0, this.dailyCompletions = 0, this.dailyEarnCap = 30, this.dailyLimitReached = false, this.isAdLoading = false, this.isAdReady = false, this.adTransactionId, this.adResponseId, this.adLoadAttempt = 0, this.adRetryRound = 0, this.adShowFailureCount = 0, this.uploadProgress, this.uploadBytesTransferred, this.uploadTotalBytes, this.isPendingReview = false, this.rewardItemId, this.rewardCampaignName, this.rewardType}): _threads = threads,_opportunities = opportunities,_history = history,super._();
  

@override@JsonKey() final  EarnStatus status;
 final  List<EarnThread> _threads;
@override@JsonKey() List<EarnThread> get threads {
  if (_threads is EqualUnmodifiableListView) return _threads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_threads);
}

@override final  EarnThread? selectedThread;
@override@JsonKey() final  EarnStatus opportunitiesStatus;
/// Tracks which threadId the current [opportunities] list belongs to.
/// Used to detect pre-fetched opportunities and skip redundant CF calls.
@override final  String? opportunitiesThreadId;
 final  List<EarnOpportunity> _opportunities;
@override@JsonKey() List<EarnOpportunity> get opportunities {
  if (_opportunities is EqualUnmodifiableListView) return _opportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunities);
}

@override final  EarnOpportunity? selectedOpportunity;
@override final  Engagement? currentEngagement;
@override@JsonKey() final  EngagementPhase engagementPhase;
 final  List<Engagement> _history;
@override@JsonKey() List<Engagement> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool hasMoreHistory;
@override final  DateTime? lastHistoryTimestamp;
@override final  String? errorMessage;
@override@JsonKey() final  int totalAvailableOpportunities;
// Daily completion limit
@override@JsonKey() final  int dailyCompletions;
@override@JsonKey() final  int dailyEarnCap;
@override@JsonKey() final  bool dailyLimitReached;
// AdMob state
@override@JsonKey() final  bool isAdLoading;
@override@JsonKey() final  bool isAdReady;
@override final  String? adTransactionId;
/// AdMob response ID — uniquely identifies the ad impression for debugging
@override final  String? adResponseId;
/// Current load attempt (1-based) shown during loading; 0 when idle
@override@JsonKey() final  int adLoadAttempt;
/// How many full retry rounds have been exhausted (0 = first attempt, 1 = user retried once)
@override@JsonKey() final  int adRetryRound;
/// Consecutive show failures — ad SDK said loaded but play failed.
/// Reset to 0 on successful completion or engagement reset.
@override@JsonKey() final  int adShowFailureCount;
// Upload progress
@override final  double? uploadProgress;
@override final  int? uploadBytesTransferred;
@override final  int? uploadTotalBytes;
/// Whether the completed engagement is pending admin review
@override@JsonKey() final  bool isPendingReview;
// Reward allocation state (set after engagement completion)
@override final  String? rewardItemId;
@override final  String? rewardCampaignName;
@override final  String? rewardType;

/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnStateCopyWith<_EarnState> get copyWith => __$EarnStateCopyWithImpl<_EarnState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._threads, _threads)&&(identical(other.selectedThread, selectedThread) || other.selectedThread == selectedThread)&&(identical(other.opportunitiesStatus, opportunitiesStatus) || other.opportunitiesStatus == opportunitiesStatus)&&(identical(other.opportunitiesThreadId, opportunitiesThreadId) || other.opportunitiesThreadId == opportunitiesThreadId)&&const DeepCollectionEquality().equals(other._opportunities, _opportunities)&&(identical(other.selectedOpportunity, selectedOpportunity) || other.selectedOpportunity == selectedOpportunity)&&(identical(other.currentEngagement, currentEngagement) || other.currentEngagement == currentEngagement)&&(identical(other.engagementPhase, engagementPhase) || other.engagementPhase == engagementPhase)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasMoreHistory, hasMoreHistory) || other.hasMoreHistory == hasMoreHistory)&&(identical(other.lastHistoryTimestamp, lastHistoryTimestamp) || other.lastHistoryTimestamp == lastHistoryTimestamp)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.totalAvailableOpportunities, totalAvailableOpportunities) || other.totalAvailableOpportunities == totalAvailableOpportunities)&&(identical(other.dailyCompletions, dailyCompletions) || other.dailyCompletions == dailyCompletions)&&(identical(other.dailyEarnCap, dailyEarnCap) || other.dailyEarnCap == dailyEarnCap)&&(identical(other.dailyLimitReached, dailyLimitReached) || other.dailyLimitReached == dailyLimitReached)&&(identical(other.isAdLoading, isAdLoading) || other.isAdLoading == isAdLoading)&&(identical(other.isAdReady, isAdReady) || other.isAdReady == isAdReady)&&(identical(other.adTransactionId, adTransactionId) || other.adTransactionId == adTransactionId)&&(identical(other.adResponseId, adResponseId) || other.adResponseId == adResponseId)&&(identical(other.adLoadAttempt, adLoadAttempt) || other.adLoadAttempt == adLoadAttempt)&&(identical(other.adRetryRound, adRetryRound) || other.adRetryRound == adRetryRound)&&(identical(other.adShowFailureCount, adShowFailureCount) || other.adShowFailureCount == adShowFailureCount)&&(identical(other.uploadProgress, uploadProgress) || other.uploadProgress == uploadProgress)&&(identical(other.uploadBytesTransferred, uploadBytesTransferred) || other.uploadBytesTransferred == uploadBytesTransferred)&&(identical(other.uploadTotalBytes, uploadTotalBytes) || other.uploadTotalBytes == uploadTotalBytes)&&(identical(other.isPendingReview, isPendingReview) || other.isPendingReview == isPendingReview)&&(identical(other.rewardItemId, rewardItemId) || other.rewardItemId == rewardItemId)&&(identical(other.rewardCampaignName, rewardCampaignName) || other.rewardCampaignName == rewardCampaignName)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(_threads),selectedThread,opportunitiesStatus,opportunitiesThreadId,const DeepCollectionEquality().hash(_opportunities),selectedOpportunity,currentEngagement,engagementPhase,const DeepCollectionEquality().hash(_history),isLoadingHistory,hasMoreHistory,lastHistoryTimestamp,errorMessage,totalAvailableOpportunities,dailyCompletions,dailyEarnCap,dailyLimitReached,isAdLoading,isAdReady,adTransactionId,adResponseId,adLoadAttempt,adRetryRound,adShowFailureCount,uploadProgress,uploadBytesTransferred,uploadTotalBytes,isPendingReview,rewardItemId,rewardCampaignName,rewardType]);

@override
String toString() {
  return 'EarnState(status: $status, threads: $threads, selectedThread: $selectedThread, opportunitiesStatus: $opportunitiesStatus, opportunitiesThreadId: $opportunitiesThreadId, opportunities: $opportunities, selectedOpportunity: $selectedOpportunity, currentEngagement: $currentEngagement, engagementPhase: $engagementPhase, history: $history, isLoadingHistory: $isLoadingHistory, hasMoreHistory: $hasMoreHistory, lastHistoryTimestamp: $lastHistoryTimestamp, errorMessage: $errorMessage, totalAvailableOpportunities: $totalAvailableOpportunities, dailyCompletions: $dailyCompletions, dailyEarnCap: $dailyEarnCap, dailyLimitReached: $dailyLimitReached, isAdLoading: $isAdLoading, isAdReady: $isAdReady, adTransactionId: $adTransactionId, adResponseId: $adResponseId, adLoadAttempt: $adLoadAttempt, adRetryRound: $adRetryRound, adShowFailureCount: $adShowFailureCount, uploadProgress: $uploadProgress, uploadBytesTransferred: $uploadBytesTransferred, uploadTotalBytes: $uploadTotalBytes, isPendingReview: $isPendingReview, rewardItemId: $rewardItemId, rewardCampaignName: $rewardCampaignName, rewardType: $rewardType)';
}


}

/// @nodoc
abstract mixin class _$EarnStateCopyWith<$Res> implements $EarnStateCopyWith<$Res> {
  factory _$EarnStateCopyWith(_EarnState value, $Res Function(_EarnState) _then) = __$EarnStateCopyWithImpl;
@override @useResult
$Res call({
 EarnStatus status, List<EarnThread> threads, EarnThread? selectedThread, EarnStatus opportunitiesStatus, String? opportunitiesThreadId, List<EarnOpportunity> opportunities, EarnOpportunity? selectedOpportunity, Engagement? currentEngagement, EngagementPhase engagementPhase, List<Engagement> history, bool isLoadingHistory, bool hasMoreHistory, DateTime? lastHistoryTimestamp, String? errorMessage, int totalAvailableOpportunities, int dailyCompletions, int dailyEarnCap, bool dailyLimitReached, bool isAdLoading, bool isAdReady, String? adTransactionId, String? adResponseId, int adLoadAttempt, int adRetryRound, int adShowFailureCount, double? uploadProgress, int? uploadBytesTransferred, int? uploadTotalBytes, bool isPendingReview, String? rewardItemId, String? rewardCampaignName, String? rewardType
});


@override $EarnThreadCopyWith<$Res>? get selectedThread;@override $EarnOpportunityCopyWith<$Res>? get selectedOpportunity;@override $EngagementCopyWith<$Res>? get currentEngagement;

}
/// @nodoc
class __$EarnStateCopyWithImpl<$Res>
    implements _$EarnStateCopyWith<$Res> {
  __$EarnStateCopyWithImpl(this._self, this._then);

  final _EarnState _self;
  final $Res Function(_EarnState) _then;

/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? threads = null,Object? selectedThread = freezed,Object? opportunitiesStatus = null,Object? opportunitiesThreadId = freezed,Object? opportunities = null,Object? selectedOpportunity = freezed,Object? currentEngagement = freezed,Object? engagementPhase = null,Object? history = null,Object? isLoadingHistory = null,Object? hasMoreHistory = null,Object? lastHistoryTimestamp = freezed,Object? errorMessage = freezed,Object? totalAvailableOpportunities = null,Object? dailyCompletions = null,Object? dailyEarnCap = null,Object? dailyLimitReached = null,Object? isAdLoading = null,Object? isAdReady = null,Object? adTransactionId = freezed,Object? adResponseId = freezed,Object? adLoadAttempt = null,Object? adRetryRound = null,Object? adShowFailureCount = null,Object? uploadProgress = freezed,Object? uploadBytesTransferred = freezed,Object? uploadTotalBytes = freezed,Object? isPendingReview = null,Object? rewardItemId = freezed,Object? rewardCampaignName = freezed,Object? rewardType = freezed,}) {
  return _then(_EarnState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnStatus,threads: null == threads ? _self._threads : threads // ignore: cast_nullable_to_non_nullable
as List<EarnThread>,selectedThread: freezed == selectedThread ? _self.selectedThread : selectedThread // ignore: cast_nullable_to_non_nullable
as EarnThread?,opportunitiesStatus: null == opportunitiesStatus ? _self.opportunitiesStatus : opportunitiesStatus // ignore: cast_nullable_to_non_nullable
as EarnStatus,opportunitiesThreadId: freezed == opportunitiesThreadId ? _self.opportunitiesThreadId : opportunitiesThreadId // ignore: cast_nullable_to_non_nullable
as String?,opportunities: null == opportunities ? _self._opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<EarnOpportunity>,selectedOpportunity: freezed == selectedOpportunity ? _self.selectedOpportunity : selectedOpportunity // ignore: cast_nullable_to_non_nullable
as EarnOpportunity?,currentEngagement: freezed == currentEngagement ? _self.currentEngagement : currentEngagement // ignore: cast_nullable_to_non_nullable
as Engagement?,engagementPhase: null == engagementPhase ? _self.engagementPhase : engagementPhase // ignore: cast_nullable_to_non_nullable
as EngagementPhase,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Engagement>,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasMoreHistory: null == hasMoreHistory ? _self.hasMoreHistory : hasMoreHistory // ignore: cast_nullable_to_non_nullable
as bool,lastHistoryTimestamp: freezed == lastHistoryTimestamp ? _self.lastHistoryTimestamp : lastHistoryTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,totalAvailableOpportunities: null == totalAvailableOpportunities ? _self.totalAvailableOpportunities : totalAvailableOpportunities // ignore: cast_nullable_to_non_nullable
as int,dailyCompletions: null == dailyCompletions ? _self.dailyCompletions : dailyCompletions // ignore: cast_nullable_to_non_nullable
as int,dailyEarnCap: null == dailyEarnCap ? _self.dailyEarnCap : dailyEarnCap // ignore: cast_nullable_to_non_nullable
as int,dailyLimitReached: null == dailyLimitReached ? _self.dailyLimitReached : dailyLimitReached // ignore: cast_nullable_to_non_nullable
as bool,isAdLoading: null == isAdLoading ? _self.isAdLoading : isAdLoading // ignore: cast_nullable_to_non_nullable
as bool,isAdReady: null == isAdReady ? _self.isAdReady : isAdReady // ignore: cast_nullable_to_non_nullable
as bool,adTransactionId: freezed == adTransactionId ? _self.adTransactionId : adTransactionId // ignore: cast_nullable_to_non_nullable
as String?,adResponseId: freezed == adResponseId ? _self.adResponseId : adResponseId // ignore: cast_nullable_to_non_nullable
as String?,adLoadAttempt: null == adLoadAttempt ? _self.adLoadAttempt : adLoadAttempt // ignore: cast_nullable_to_non_nullable
as int,adRetryRound: null == adRetryRound ? _self.adRetryRound : adRetryRound // ignore: cast_nullable_to_non_nullable
as int,adShowFailureCount: null == adShowFailureCount ? _self.adShowFailureCount : adShowFailureCount // ignore: cast_nullable_to_non_nullable
as int,uploadProgress: freezed == uploadProgress ? _self.uploadProgress : uploadProgress // ignore: cast_nullable_to_non_nullable
as double?,uploadBytesTransferred: freezed == uploadBytesTransferred ? _self.uploadBytesTransferred : uploadBytesTransferred // ignore: cast_nullable_to_non_nullable
as int?,uploadTotalBytes: freezed == uploadTotalBytes ? _self.uploadTotalBytes : uploadTotalBytes // ignore: cast_nullable_to_non_nullable
as int?,isPendingReview: null == isPendingReview ? _self.isPendingReview : isPendingReview // ignore: cast_nullable_to_non_nullable
as bool,rewardItemId: freezed == rewardItemId ? _self.rewardItemId : rewardItemId // ignore: cast_nullable_to_non_nullable
as String?,rewardCampaignName: freezed == rewardCampaignName ? _self.rewardCampaignName : rewardCampaignName // ignore: cast_nullable_to_non_nullable
as String?,rewardType: freezed == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarnThreadCopyWith<$Res>? get selectedThread {
    if (_self.selectedThread == null) {
    return null;
  }

  return $EarnThreadCopyWith<$Res>(_self.selectedThread!, (value) {
    return _then(_self.copyWith(selectedThread: value));
  });
}/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarnOpportunityCopyWith<$Res>? get selectedOpportunity {
    if (_self.selectedOpportunity == null) {
    return null;
  }

  return $EarnOpportunityCopyWith<$Res>(_self.selectedOpportunity!, (value) {
    return _then(_self.copyWith(selectedOpportunity: value));
  });
}/// Create a copy of EarnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EngagementCopyWith<$Res>? get currentEngagement {
    if (_self.currentEngagement == null) {
    return null;
  }

  return $EngagementCopyWith<$Res>(_self.currentEngagement!, (value) {
    return _then(_self.copyWith(currentEngagement: value));
  });
}
}

// dart format on
