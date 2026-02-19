part of 'token_spray_bloc.dart';

@freezed
class TokenSprayState with _$TokenSprayState {
  const factory TokenSprayState({
    required String communityId,
    TokenSpray? activeSpray,
    @Default([]) List<TokenSpray> history,
    @Default(false) bool isLoading,
    @Default(false) bool isContributing,
    String? errorMessage,
  }) = _TokenSprayState;
}
