part of 'community_messaging_bloc.dart';

@freezed
abstract class CommunityMessagingState with _$CommunityMessagingState {
  const factory CommunityMessagingState({
    required String communityId,
    @Default([]) List<Message> messages,
    @Default(false) bool isLoading,
    @Default(false) bool isSending,
    @Default(false) bool hasMore,
    String? errorMessage,
  }) = _CommunityMessagingState;
}
