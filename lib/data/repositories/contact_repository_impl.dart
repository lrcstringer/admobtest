import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';

/// Implementation of ContactRepository using Firebase Firestore
class ContactRepositoryImpl implements ContactRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ContactRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get _contactsCollection =>
      _firestore.collection('contacts');

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final snapshot = await _contactsCollection
          .where('userId', isEqualTo: userId)
          .where('status', isNotEqualTo: ContactStatus.blocked.name)
          .orderBy('status')
          .orderBy('displayName')
          .get();

      final contacts = snapshot.docs
          .map((doc) => _mapDocToContact(doc))
          .toList();

      return Right(contacts);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Contact>>> watchContacts() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.value(const Left(Failure.unauthenticated()));
    }

    return _contactsCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: ContactStatus.accepted.name)
        .orderBy('displayName')
        .snapshots()
        .map((snapshot) {
      try {
        final contacts = snapshot.docs
            .map((doc) => _mapDocToContact(doc))
            .toList();
        return Right(contacts);
      } catch (e) {
        return Left(Failure.serverError(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Contact>> getContactById(String contactId) async {
    try {
      final doc = await _contactsCollection.doc(contactId).get();

      if (!doc.exists) {
        return const Left(Failure.serverError(message: 'Contact not found'));
      }

      return Right(_mapDocToContact(doc));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact?>> getContactByUserId(String userId) async {
    try {
      final currentUserId = _currentUserId;
      if (currentUserId == null) {
        return const Left(Failure.unauthenticated());
      }

      final snapshot = await _contactsCollection
          .where('userId', isEqualTo: currentUserId)
          .where('contactUserId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return const Right(null);
      }

      return Right(_mapDocToContact(snapshot.docs.first));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact>> addContact({
    required String contactUserId,
    String? nickname,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      // Check if contact already exists
      final existing = await getContactByUserId(contactUserId);
      if (existing.isRight() && existing.getOrElse(() => null) != null) {
        return const Left(Failure.serverError(message: 'Contact already exists'));
      }

      // Get the user being added as contact
      final contactUserDoc = await _firestore
          .collection('users')
          .doc(contactUserId)
          .get();

      if (!contactUserDoc.exists) {
        return const Left(Failure.serverError(message: 'User not found'));
      }

      final contactUserData = contactUserDoc.data()!;

      // Create the contact
      final contactRef = _contactsCollection.doc();
      final now = DateTime.now();

      final contact = Contact(
        id: contactRef.id,
        userId: userId,
        contactUserId: contactUserId,
        displayName: contactUserData['displayName'] ?? 'User',
        username: contactUserData['username'],
        avatarUrl: contactUserData['profile']?['avatarUrl'],
        avatarColor: contactUserData['profile']?['avatarColor'],
        phoneNumber: contactUserData['phoneNumber'],
        status: ContactStatus.accepted,
        isFavorite: false,
        nickname: nickname,
        createdAt: now,
      );

      await contactRef.set(_contactToMap(contact));

      return Right(contact);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact>> updateContact({
    required String contactId,
    String? nickname,
    String? notes,
    bool? isFavorite,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final doc = await _contactsCollection.doc(contactId).get();

      if (!doc.exists) {
        return const Left(Failure.serverError(message: 'Contact not found'));
      }

      final existingContact = _mapDocToContact(doc);

      // Verify ownership
      if (existingContact.userId != userId) {
        return const Left(Failure.serverError(message: 'Not authorized'));
      }

      final updates = <String, dynamic>{};

      if (nickname != null) updates['nickname'] = nickname;
      if (notes != null) updates['notes'] = notes;
      if (isFavorite != null) updates['isFavorite'] = isFavorite;

      if (updates.isNotEmpty) {
        await _contactsCollection.doc(contactId).update(updates);
      }

      // Return updated contact
      final updatedDoc = await _contactsCollection.doc(contactId).get();
      return Right(_mapDocToContact(updatedDoc));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeContact(String contactId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final doc = await _contactsCollection.doc(contactId).get();

      if (!doc.exists) {
        return const Left(Failure.serverError(message: 'Contact not found'));
      }

      // Verify ownership
      final data = doc.data()!;
      if (data['userId'] != userId) {
        return const Left(Failure.serverError(message: 'Not authorized'));
      }

      await _contactsCollection.doc(contactId).delete();

      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> blockContact(String contactId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _contactsCollection.doc(contactId).update({
        'status': ContactStatus.blocked.name,
      });

      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unblockContact(String contactId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _contactsCollection.doc(contactId).update({
        'status': ContactStatus.accepted.name,
      });

      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> searchContacts(String query) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      if (query.isEmpty) {
        return getContacts();
      }

      final queryLower = query.toLowerCase();

      // Get all contacts and filter locally
      // Firestore doesn't support case-insensitive search
      final result = await getContacts();

      return result.fold(
        (failure) => Left(failure),
        (contacts) {
          final filtered = contacts.where((c) {
            final name = c.displayName.toLowerCase();
            final nickname = c.nickname?.toLowerCase() ?? '';
            final username = c.username?.toLowerCase() ?? '';

            return name.contains(queryLower) ||
                nickname.contains(queryLower) ||
                username.contains(queryLower);
          }).toList();

          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getFavoriteContacts() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final snapshot = await _contactsCollection
          .where('userId', isEqualTo: userId)
          .where('isFavorite', isEqualTo: true)
          .where('status', isEqualTo: ContactStatus.accepted.name)
          .orderBy('displayName')
          .get();

      final contacts = snapshot.docs
          .map((doc) => _mapDocToContact(doc))
          .toList();

      return Right(contacts);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> syncPhoneContacts(
    List<String> phoneNumbers,
  ) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      // Normalize phone numbers
      final normalizedNumbers = phoneNumbers
          .map(_normalizePhoneNumber)
          .where((p) => p.isNotEmpty)
          .toList();

      if (normalizedNumbers.isEmpty) {
        return const Right([]);
      }

      // Find registered users with these phone numbers
      // Firestore limits 'whereIn' to 30 items, so batch if needed
      final registeredContacts = <Contact>[];
      const batchSize = 30;

      for (var i = 0; i < normalizedNumbers.length; i += batchSize) {
        final batch = normalizedNumbers.skip(i).take(batchSize).toList();

        final snapshot = await _firestore
            .collection('users')
            .where('phoneNumber', whereIn: batch)
            .get();

        for (final doc in snapshot.docs) {
          // Don't add self as contact
          if (doc.id == userId) continue;

          // Check if already a contact
          final existingResult = await getContactByUserId(doc.id);
          if (existingResult.isRight() &&
              existingResult.getOrElse(() => null) != null) {
            continue;
          }

          // Add as contact
          final addResult = await addContact(contactUserId: doc.id);
          addResult.fold(
            (failure) => null,
            (contact) => registeredContacts.add(contact),
          );
        }
      }

      return Right(registeredContacts);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  String _normalizePhoneNumber(String phone) {
    // Remove all non-digit characters
    String digits = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Handle South African numbers
    if (digits.startsWith('0') && digits.length == 10) {
      digits = '27${digits.substring(1)}';
    }

    if (digits.isEmpty) return '';

    return '+$digits';
  }

  Contact _mapDocToContact(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Contact(
      id: doc.id,
      userId: data['userId'] ?? '',
      contactUserId: data['contactUserId'] ?? '',
      displayName: data['displayName'] ?? 'User',
      username: data['username'],
      avatarUrl: data['avatarUrl'],
      avatarColor: data['avatarColor'],
      phoneNumber: data['phoneNumber'],
      status: ContactStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => ContactStatus.pending,
      ),
      isFavorite: data['isFavorite'] ?? false,
      nickname: data['nickname'],
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastInteractionAt: (data['lastInteractionAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> _contactToMap(Contact contact) {
    return {
      'id': contact.id,
      'userId': contact.userId,
      'contactUserId': contact.contactUserId,
      'displayName': contact.displayName,
      'username': contact.username,
      'avatarUrl': contact.avatarUrl,
      'avatarColor': contact.avatarColor,
      'phoneNumber': contact.phoneNumber,
      'status': contact.status.name,
      'isFavorite': contact.isFavorite,
      'nickname': contact.nickname,
      'notes': contact.notes,
      'createdAt': Timestamp.fromDate(contact.createdAt),
      'lastInteractionAt': contact.lastInteractionAt != null
          ? Timestamp.fromDate(contact.lastInteractionAt!)
          : null,
    };
  }
}
