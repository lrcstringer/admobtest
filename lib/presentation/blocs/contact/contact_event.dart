part of 'contact_bloc.dart';

@freezed
class ContactEvent with _$ContactEvent {
  /// Start watching accepted contacts
  const factory ContactEvent.watchContacts() = _WatchContacts;

  /// Contacts stream updated
  const factory ContactEvent.contactsUpdated(List<Contact> contacts) =
      _ContactsUpdated;

  /// Start watching incoming contact requests
  const factory ContactEvent.watchContactRequests() = _WatchContactRequests;

  /// Requests stream updated
  const factory ContactEvent.requestsUpdated(List<Contact> requests) =
      _RequestsUpdated;

  /// Send a contact request to a user.
  /// Pass [source] as `"phone_import"` to auto-accept both sides.
  const factory ContactEvent.sendContactRequest(
    String contactUserId, {
    String? source,
  }) = _SendContactRequest;

  /// Accept an incoming contact request
  const factory ContactEvent.acceptContactRequest(String contactId) =
      _AcceptContactRequest;

  /// Decline an incoming contact request
  const factory ContactEvent.declineContactRequest(String contactId) =
      _DeclineContactRequest;

  /// Remove a contact
  const factory ContactEvent.removeContact(String contactId) = _RemoveContact;

  /// Block a contact
  const factory ContactEvent.blockContact(String contactId) = _BlockContact;

  /// Unblock a contact
  const factory ContactEvent.unblockContact(String contactId) = _UnblockContact;

  /// Toggle favorite status
  const factory ContactEvent.toggleFavorite({
    required String contactId,
    required bool isFavorite,
  }) = _ToggleFavorite;

  /// Search contacts locally
  const factory ContactEvent.searchContacts(String query) = _SearchContacts;

  /// Clear search
  const factory ContactEvent.clearSearch() = _ClearSearch;

  /// Import phone contacts — triggers device contact reading + server matching
  const factory ContactEvent.importPhoneContacts(
    List<String> phoneNumbers,
  ) = _ImportPhoneContacts;

  /// Clear import results
  const factory ContactEvent.clearImportResults() = _ClearImportResults;

  /// Load followed brands
  const factory ContactEvent.loadFollowedBrands() = _LoadFollowedBrands;

  /// Load all available brands
  const factory ContactEvent.loadAvailableBrands() = _LoadAvailableBrands;

  /// Follow a brand
  const factory ContactEvent.followBrand(String clientId) = _FollowBrand;

  /// Unfollow a brand
  const factory ContactEvent.unfollowBrand(String clientId) = _UnfollowBrand;

  /// Unified search across contacts, communities, brands, and global users
  const factory ContactEvent.unifiedSearch(String query) = _UnifiedSearch;

  /// Load "People You May Know" suggestions
  const factory ContactEvent.loadSuggestions() = _LoadSuggestions;

  /// Dismiss a suggestion (hide locally)
  const factory ContactEvent.dismissSuggestion(String userId) =
      _DismissSuggestion;
}
