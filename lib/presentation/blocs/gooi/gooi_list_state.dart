part of 'gooi_list_bloc.dart';

@freezed
abstract class GooiListState with _$GooiListState {
  const factory GooiListState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default([]) List<GooiGroup> groups,
    @Default([]) List<GooiGroup> filteredGroups,
    GooiGroupStatus? statusFilter,
    String? errorMessage,
  }) = _GooiListState;
}
