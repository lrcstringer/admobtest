part of 'user_search_bloc.dart';

@freezed
class UserSearchEvent with _$UserSearchEvent {
  /// Search users by display name or username
  const factory UserSearchEvent.searchUsers(String query) = _SearchUsers;

  /// Clear search results
  const factory UserSearchEvent.clearSearch() = _ClearSearch;
}
