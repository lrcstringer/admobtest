import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/value_objects/user_search_result.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';
part 'user_search_bloc.freezed.dart';

/// Handles user search for starting new conversations.
///
/// Extracted from ConversationBloc to isolate search concerns from
/// conversation list/detail management.
@injectable
class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final ConversationRepository _conversationRepository;

  UserSearchBloc(this._conversationRepository)
      : super(const UserSearchState()) {
    on<_SearchUsers>(_onSearchUsers);
    on<_ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchUsers(
    _SearchUsers event,
    Emitter<UserSearchState> emit,
  ) async {
    if (event.query.length < 2) {
      emit(state.copyWith(searchResults: [], isSearching: false));
      return;
    }

    emit(state.copyWith(isSearching: true));

    final result = await _conversationRepository.searchUsers(
      event.query,
      accountTypeId: event.accountTypeId,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isSearching: false,
        searchResults: [],
      )),
      (users) => emit(state.copyWith(
        isSearching: false,
        searchResults: users,
      )),
    );
  }

  void _onClearSearch(
    _ClearSearch event,
    Emitter<UserSearchState> emit,
  ) {
    emit(state.copyWith(searchResults: [], isSearching: false));
  }
}
