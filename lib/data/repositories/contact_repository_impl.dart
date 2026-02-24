import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/brand_account.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/contact_suggestion.dart';
import '../../domain/repositories/contact_repository.dart';

@LazySingleton(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseFunctions _functions;

  ContactRepositoryImpl(
    this._firestore,
    this._auth,
    this._functions,
  );

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
  Stream<Either<Failure, List<Contact>>> watchContactRequests() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.value(const Left(Failure.unauthenticated()));
    }

    return _contactsCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: ContactStatus.pending.name)
        .orderBy('createdAt', descending: true)
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
  Future<Either<Failure, void>> sendContactRequest(
    String contactUserId, {
    String? source,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _functions.httpsCallable('sendContactRequest').call({
        'contactUserId': contactUserId,
        if (source != null) 'source': source,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to send contact request',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptContactRequest(
    String contactId,
  ) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _functions.httpsCallable('acceptContactRequest').call({
        'contactId': contactId,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to accept contact request',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> declineContactRequest(
    String contactId,
  ) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _functions.httpsCallable('declineContactRequest').call({
        'contactId': contactId,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to decline contact request',
      ));
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

      await _functions.httpsCallable('removeContact').call({
        'contactId': contactId,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to remove contact',
      ));
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

          // Send contact request
          final addResult = await sendContactRequest(doc.id);
          addResult.fold(
            (failure) => null,
            (_) {
              // We don't get the Contact back from CF, but the
              // real-time stream will pick it up
              final userData = doc.data();
              registeredContacts.add(Contact(
                id: '',
                userId: userId,
                contactUserId: doc.id,
                displayName: userData['displayName'] ?? 'User',
                username: userData['username'],
                avatarUrl: userData['avatarUrl'],
                phoneNumber: userData['phoneNumber'],
                status: ContactStatus.accepted,
                isFavorite: false,
                createdAt: DateTime.now(),
              ));
            },
          );
        }
      }

      return Right(registeredContacts);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> matchPhoneContacts(
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

      final result =
          await _functions.httpsCallable('matchPhoneContacts').call({
        'phoneNumbers': normalizedNumbers,
      });

      final data = result.data as Map<String, dynamic>;
      final matches = (data['matches'] as List<dynamic>?)
              ?.map((m) => Map<String, dynamic>.from(m as Map))
              .toList() ??
          [];

      return Right(matches);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to match phone contacts',
      ));
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

  @override
  Future<Either<Failure, void>> followBrand(String clientId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _functions.httpsCallable('followBrand').call({
        'clientId': clientId,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to follow brand',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollowBrand(String clientId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      await _functions.httpsCallable('unfollowBrand').call({
        'clientId': clientId,
      });

      return const Right(null);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to unfollow brand',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BrandAccount>>> getFollowedBrands() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final result =
          await _functions.httpsCallable('getFollowedBrands').call({});

      final data = result.data as Map<String, dynamic>;
      final brands = _parseBrandList(data['brands']);
      return Right(brands);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to get followed brands',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BrandAccount>>> getAvailableBrands() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final result =
          await _functions.httpsCallable('getAvailableBrands').call({});

      final data = result.data as Map<String, dynamic>;
      final brands = _parseBrandList(data['brands']);
      return Right(brands);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to get available brands',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  List<BrandAccount> _parseBrandList(dynamic brandsData) {
    if (brandsData is! List) return [];
    return brandsData.map((b) {
      final m = Map<String, dynamic>.from(b as Map);
      return BrandAccount(
        id: m['id'] as String? ?? '',
        name: m['name'] as String? ?? 'Brand',
        logoUrl: m['logoUrl'] as String?,
        avatarColor: m['avatarColor'] as String?,
        description: m['description'] as String?,
        isFollowed: m['isFollowed'] as bool? ?? false,
        followerCount: m['followerCount'] as int? ?? 0,
      );
    }).toList();
  }

  @override
  Future<Either<Failure, List<ContactSuggestion>>> getSuggestions() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left(Failure.unauthenticated());
      }

      final result =
          await _functions.httpsCallable('getPeopleYouMayKnow').call({});

      final data = result.data as Map<String, dynamic>;
      final suggestions = (data['suggestions'] as List<dynamic>?)
              ?.map((s) {
                final m = Map<String, dynamic>.from(s as Map);
                return ContactSuggestion(
                  userId: m['userId'] as String? ?? '',
                  displayName: m['displayName'] as String? ?? 'User',
                  username: m['username'] as String?,
                  avatarUrl: m['avatarUrl'] as String?,
                  avatarColor: m['avatarColor'] as String?,
                  reason: m['reason'] as String? ?? '',
                  source: _parseSuggestionSource(m['source'] as String?),
                );
              })
              .where((s) => s.userId.isNotEmpty)
              .toList() ??
          [];

      return Right(suggestions);
    } on FirebaseFunctionsException catch (e) {
      return Left(Failure.serverError(
        message: e.message ?? 'Failed to get suggestions',
      ));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  SuggestionSource _parseSuggestionSource(String? source) {
    switch (source) {
      case 'phoneContact':
        return SuggestionSource.phoneContact;
      case 'mutualFriend':
        return SuggestionSource.mutualFriend;
      case 'communityMember':
        return SuggestionSource.communityMember;
      default:
        return SuggestionSource.mutualFriend;
    }
  }

  @override
  Future<Either<Failure, void>> recordPendingInvite(
    String phoneNumber, {
    String? referralCode,
  }) async {
    try {
      await _functions.httpsCallable('recordPendingInvite').call({
        'phoneNumber': phoneNumber,
        if (referralCode != null) 'referralCode': referralCode,
      });
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
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

}
