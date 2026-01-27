import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/contact.dart';

/// Contact repository interface
abstract class ContactRepository {
  /// Get all contacts
  Future<Either<Failure, List<Contact>>> getContacts();

  /// Stream contacts
  Stream<Either<Failure, List<Contact>>> watchContacts();

  /// Get contact by ID
  Future<Either<Failure, Contact>> getContactById(String contactId);

  /// Get contact by user ID
  Future<Either<Failure, Contact?>> getContactByUserId(String userId);

  /// Add contact
  Future<Either<Failure, Contact>> addContact({
    required String contactUserId,
    String? nickname,
  });

  /// Update contact
  Future<Either<Failure, Contact>> updateContact({
    required String contactId,
    String? nickname,
    String? notes,
    bool? isFavorite,
  });

  /// Remove contact
  Future<Either<Failure, void>> removeContact(String contactId);

  /// Block contact
  Future<Either<Failure, void>> blockContact(String contactId);

  /// Unblock contact
  Future<Either<Failure, void>> unblockContact(String contactId);

  /// Search contacts
  Future<Either<Failure, List<Contact>>> searchContacts(String query);

  /// Get favorite contacts
  Future<Either<Failure, List<Contact>>> getFavoriteContacts();

  /// Sync phone contacts (import)
  Future<Either<Failure, List<Contact>>> syncPhoneContacts(
    List<String> phoneNumbers,
  );
}
