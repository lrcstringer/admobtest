part of 'gooi_dashboard_bloc.dart';

@freezed
abstract class GooiDashboardEvent with _$GooiDashboardEvent {
  const factory GooiDashboardEvent.loadGroup(String groupId) = _LoadGroup;
  const factory GooiDashboardEvent.refreshGroup() = _RefreshGroup;
  const factory GooiDashboardEvent.contribute({String? subAccountId}) = _Contribute;
  const factory GooiDashboardEvent.triggerPayout() = _TriggerPayout;
  const factory GooiDashboardEvent.toggleAutoContribute({
    required bool enabled,
    String? walletSubAccountId,
  }) = _ToggleAutoContribute;
  const factory GooiDashboardEvent.delegateTrigger({
    required String delegateUserId,
    @Default(7) int durationDays,
  }) = _DelegateTrigger;
  const factory GooiDashboardEvent.revokeDelegation() = _RevokeDelegation;
  const factory GooiDashboardEvent.extendGracePeriod({
    required int extensionHours,
  }) = _ExtendGracePeriod;
  const factory GooiDashboardEvent.applyLateFee({
    required String contributionId,
  }) = _ApplyLateFee;
  const factory GooiDashboardEvent.waiveLateFee({
    required String contributionId,
  }) = _WaiveLateFee;

  // Phase 2 events
  const factory GooiDashboardEvent.applyPenalty({
    required String targetUserId,
    required String action,
  }) = _ApplyPenalty;
  const factory GooiDashboardEvent.requestWithdrawal({String? reason}) =
      _RequestWithdrawal;
  const factory GooiDashboardEvent.voteWithdrawal({
    required String withdrawalId,
    required bool approve,
  }) = _VoteWithdrawal;
  const factory GooiDashboardEvent.voteGraceExtension({
    required String voteId,
    required bool approve,
  }) = _VoteGraceExtension;
  const factory GooiDashboardEvent.dissolveGroup() = _DissolveGroup;
  const factory GooiDashboardEvent.writeOffBadDebt() = _WriteOffBadDebt;
}
