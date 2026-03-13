part of 'token_pool_bloc.dart';

@freezed
abstract class TokenPoolEvent with _$TokenPoolEvent {
  // Pool lifecycle
  const factory TokenPoolEvent.createPool({
    required PoolMode mode,
    required String title,
    String? purpose,
    required String message,
    required GiftStyle style,
    String? recipientId,
    required List<String> inviteeIds,
    String? communityId,
  }) = _CreatePool;

  const factory TokenPoolEvent.contribute({
    required String poolId,
    required int amount,
    required bool anonymous,
  }) = _Contribute;

  const factory TokenPoolEvent.sendGroupGift(String poolId) = _SendGroupGift;

  const factory TokenPoolEvent.distributePool({
    required String poolId,
    required List<Map<String, dynamic>> payouts,
    @Default(false) bool keepOpen,
  }) = _DistributePool;

  const factory TokenPoolEvent.cancelPool(String poolId) = _CancelPool;

  const factory TokenPoolEvent.requestWithdrawal({
    required String poolId,
    required int amount,
  }) = _RequestWithdrawal;

  // Recipient actions
  const factory TokenPoolEvent.openGroupGift(String poolId) = _OpenGroupGift;
  const factory TokenPoolEvent.claimGroupGift(String poolId) = _ClaimGroupGift;

  // Query
  const factory TokenPoolEvent.watchPool(String poolId) = _WatchPool;
  const factory TokenPoolEvent.poolUpdated(TokenPool pool) = _PoolUpdated;
  const factory TokenPoolEvent.loadMyPools() = _LoadMyPools;

  // Utility
  const factory TokenPoolEvent.clearError() = _ClearError;
  const factory TokenPoolEvent.reset() = _Reset;
}
