part of 'user_search_bloc.dart';

@freezed
abstract class UserSearchEvent with _$UserSearchEvent {
  /// Search users by display name or username.
  /// When [accountTypeId] is provided, only returns users with a matching
  /// brand sub-account (for P2P restriction filtering).
  const factory UserSearchEvent.searchUsers(
    String query, {
    String? accountTypeId,
  }) = _SearchUsers;

  /// Clear search results
  const factory UserSearchEvent.clearSearch() = _ClearSearch;
}
