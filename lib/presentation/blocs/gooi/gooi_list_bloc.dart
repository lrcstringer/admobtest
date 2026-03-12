import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../../domain/enums/gooi_group_status.dart';
import '../../../domain/repositories/gooi_repository.dart';

part 'gooi_list_event.dart';
part 'gooi_list_state.dart';
part 'gooi_list_bloc.freezed.dart';

@injectable
class GooiListBloc extends Bloc<GooiListEvent, GooiListState> {
  final GooiRepository _repository;
  bool _isProcessing = false;

  GooiListBloc(this._repository) : super(const GooiListState()) {
    on<_LoadGroups>(_onLoadGroups);
    on<_RefreshGroups>(_onRefreshGroups);
    on<_FilterByStatus>(_onFilterByStatus);
  }

  Future<void> _onLoadGroups(
    _LoadGroups event,
    Emitter<GooiListState> emit,
  ) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final result = await _repository.getMyGroups();
      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.displayMessage,
        )),
        (groups) {
          final filtered = _applyFilter(groups, state.statusFilter);
          emit(state.copyWith(
            isLoading: false,
            groups: groups,
            filteredGroups: filtered,
          ));
        },
      );
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _onRefreshGroups(
    _RefreshGroups event,
    Emitter<GooiListState> emit,
  ) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      emit(state.copyWith(isRefreshing: true));

      final result = await _repository.getMyGroups();
      result.fold(
        (failure) => emit(state.copyWith(
          isRefreshing: false,
          errorMessage: failure.displayMessage,
        )),
        (groups) {
          final filtered = _applyFilter(groups, state.statusFilter);
          emit(state.copyWith(
            isRefreshing: false,
            groups: groups,
            filteredGroups: filtered,
            errorMessage: null,
          ));
        },
      );
    } finally {
      _isProcessing = false;
    }
  }

  void _onFilterByStatus(
    _FilterByStatus event,
    Emitter<GooiListState> emit,
  ) {
    final filtered = _applyFilter(state.groups, event.status);
    emit(state.copyWith(
      statusFilter: event.status,
      filteredGroups: filtered,
    ));
  }

  List<GooiGroup> _applyFilter(List<GooiGroup> groups, GooiGroupStatus? filter) {
    if (filter == null) return groups;
    return groups.where((g) => g.status == filter).toList();
  }
}
