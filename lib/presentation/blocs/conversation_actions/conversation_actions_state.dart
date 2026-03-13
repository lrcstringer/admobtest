part of 'conversation_actions_bloc.dart';

@freezed
abstract class ConversationActionsState with _$ConversationActionsState {
  const factory ConversationActionsState({
    String? errorMessage,
  }) = _ConversationActionsState;
}
