part of 'gooi_list_bloc.dart';

@freezed
class GooiListEvent with _$GooiListEvent {
  const factory GooiListEvent.loadGroups() = _LoadGroups;
  const factory GooiListEvent.refreshGroups() = _RefreshGroups;
  const factory GooiListEvent.filterByStatus(GooiGroupStatus? status) = _FilterByStatus;
}
