part of 'gooi_formation_bloc.dart';

@freezed
abstract class GooiFormationEvent with _$GooiFormationEvent {
  const factory GooiFormationEvent.createGroup({
    required String name,
    required int contributionAmount,
    required GooiCycleFrequency cycleFrequency,
    required int totalCycles,
    required GooiRosterMethod rosterMethod,
    @Default(48) int gracePeriodHours,
    @Default(5) int lateFeePercent,
    @Default(true) bool recipientContributes,
  }) = _CreateGroup;

  const factory GooiFormationEvent.loadGroup(String groupId) = _LoadFormationGroup;

  const factory GooiFormationEvent.inviteMember({
    required String inviteeUserId,
  }) = _InviteMember;

  const factory GooiFormationEvent.respondInvitation({
    required String groupId,
    required bool accept,
  }) = _RespondInvitation;

  const factory GooiFormationEvent.lockRoster({
    List<String>? proposedOrder,
  }) = _LockRoster;

  const factory GooiFormationEvent.submitBid({
    required int targetPosition,
    required int bidPercent,
  }) = _SubmitBid;

  const factory GooiFormationEvent.confirmActivation() = _ConfirmActivation;

  const factory GooiFormationEvent.dissolveGroup() = _DissolveGroup;
}
