part of 'gooi_formation_bloc.dart';

@freezed
class GooiFormationState with _$GooiFormationState {
  const factory GooiFormationState({
    @Default(false) bool isLoading,
    @Default(false) bool isActionInProgress,
    GooiGroup? group,
    @Default([]) List<GooiMember> members,
    @Default([]) List<String> rosterOrder,
    String? createdGroupId,
    String? errorMessage,
    String? actionError,
    String? actionSuccess,
  }) = _GooiFormationState;
}
