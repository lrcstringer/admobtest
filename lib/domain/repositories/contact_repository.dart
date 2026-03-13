import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/brand_account.dart';
import '../entities/contact.dart';
import '../entities/contact_suggestion.dart';

/// Contact repository interface
abstract class ContactRepository {
  /// Get all accepted contacts
  Future<Either<Failure, List<Contact>>> getContacts();

  /// Stream accepted contacts
  Stream<Either<Failure, List<Contact>>> watchContacts();

  /// Stream incoming pending contact requests
  Stream<Either<Failure, List<Contact>>> watchContactRequests();

  /// Get contact by ID
  Future<Either<Failure, Contact>> getContactById(String contactId);

  /// Get contact by user ID
  Future<Either<Failure, Contact?>> getContactByUserId(String userId);

  /// Send a contact request via Cloud Function.
  /// Pass [source] as `"phone_import"` to auto-accept both sides.
  Future<Either<Failure, void>> sendContactRequest(
    String contactUserId, {
    String? source,
  });

  /// Accept an incoming contact request
  Future<Either<Failure, void>> acceptContactRequest(String contactId);

  /// Decline an incoming contact request
  Future<Either<Failure, void>> declineContactRequest(String contactId);

  /// Update contact (nickname, notes, favorite)
  Future<Either<Failure, Contact>> updateContact({
    required String contactId,
    String? nickname,
    String? notes,
    bool? isFavorite,
  });

  /// Remove contact (unilateral)
  Future<Either<Failure, void>> removeContact(String contactId);

  /// Block contact
  Future<Either<Failure, void>> blockContact(String contactId);

  /// Unblock contact
  Future<Either<Failure, void>> unblockContact(String contactId);

  /// Search contacts locally
  Future<Either<Failure, List<Contact>>> searchContacts(String query);

  /// Get favorite contacts
  Future<Either<Failure, List<Contact>>> getFavoriteContacts();

  /// Sync phone contacts (import)
  Future<Either<Failure, List<Contact>>> syncPhoneContacts(
    List<String> phoneNumbers,
  );

  /// Match phone numbers against registered users via Cloud Function
  /// Returns matched user profiles with isExistingContact flag
  Future<Either<Failure, List<Map<String, dynamic>>>> matchPhoneContacts(
    List<String> phoneNumbers,
  );

  /// Follow a brand
  @Deprecated('Use BuyRepository.toggleBrandFollow instead')
  Future<Either<Failure, void>> followBrand(String clientId);

  /// Unfollow a brand
  @Deprecated('Use BuyRepository.toggleBrandFollow instead')
  Future<Either<Failure, void>> unfollowBrand(String clientId);

  /// Get user's followed brands
  Future<Either<Failure, List<BrandAccount>>> getFollowedBrands();

  /// Get all available/discoverable brands
  Future<Either<Failure, List<BrandAccount>>> getAvailableBrands();

  /// Get "People You May Know" suggestions
  Future<Either<Failure, List<ContactSuggestion>>> getSuggestions();

  /// Record a pending invite for a phone number (fire-and-forget tracking)
  Future<Either<Failure, void>> recordPendingInvite(
    String phoneNumber, {
    String? referralCode,
  });
}
