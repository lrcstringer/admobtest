part of 'contact_bloc.dart';

enum ContactLoadingStatus { initial, loading, loaded, error }

@freezed
abstract class ContactState with _$ContactState {
  const factory ContactState({
    @Default(ContactLoadingStatus.initial) ContactLoadingStatus status,
    @Default([]) List<Contact> contacts,
    @Default([]) List<Contact> contactRequests,
    @Default(0) int pendingRequestCount,
    @Default([]) List<Contact> searchResults,
    @Default(false) bool isSearching,
    String? actionError,
    // Phone import state
    @Default(false) bool isImporting,
    @Default([]) List<Map<String, dynamic>> matchedPhoneContacts,
    @Default([]) List<String> unmatchedPhoneNumbers,
    // Brand accounts state
    @Default([]) List<BrandAccount> followedBrands,
    @Default([]) List<BrandAccount> availableBrands,
    @Default(false) bool isLoadingBrands,
    // Unified search state
    @Default([]) List<UserSearchResult> globalSearchResults,
    @Default([]) List<BrandAccount> brandSearchResults,
    // People You May Know suggestions
    @Default([]) List<ContactSuggestion> suggestions,
    @Default(false) bool isLoadingSuggestions,
    // Track sent contact request user IDs for UI feedback
    @Default({}) Set<String> sentContactRequestIds,
    // Success message for actions (e.g. contact request sent)
    String? actionSuccess,
  }) = _ContactState;
}
