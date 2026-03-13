part of 'user_search_bloc.dart';

@freezed
abstract class UserSearchState with _$UserSearchState {
  const factory UserSearchState({
    @Default([]) List<UserSearchResult> searchResults,
    @Default(false) bool isSearching,
  }) = _UserSearchState;
}
