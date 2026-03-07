part of 'token_pool_bloc.dart';

@freezed
class TokenPoolState with _$TokenPoolState {
  const factory TokenPoolState({
    @Default([]) List<TokenPool> myPools,
    TokenPool? activePool,
    @Default(false) bool isLoading,
    @Default(false) bool isCreating,
    @Default(false) bool isContributing,
    @Default(false) bool isSending,
    @Default(false) bool isDistributing,
    @Default(false) bool isCancelling,
    @Default(false) bool isClaiming,
    @Default(false) bool isWithdrawing,
    String? errorMessage,
    String? successMessage,
  }) = _TokenPoolState;
}
