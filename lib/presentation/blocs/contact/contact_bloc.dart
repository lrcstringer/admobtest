import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/brand_account.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/contact_suggestion.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/value_objects/user_search_result.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

@injectable
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;
  final ConversationRepository _conversationRepository;

  StreamSubscription? _contactsSubscription;
  StreamSubscription? _requestsSubscription;

  ContactBloc(this._contactRepository, this._conversationRepository)
      : super(const ContactState()) {
    on<_WatchContacts>(_onWatchContacts);
    on<_ContactsUpdated>(_onContactsUpdated);
    on<_WatchContactRequests>(_onWatchContactRequests);
    on<_RequestsUpdated>(_onRequestsUpdated);
    on<_SendContactRequest>(_onSendContactRequest);
    on<_AcceptContactRequest>(_onAcceptContactRequest);
    on<_DeclineContactRequest>(_onDeclineContactRequest);
    on<_RemoveContact>(_onRemoveContact);
    on<_BlockContact>(_onBlockContact);
    on<_UnblockContact>(_onUnblockContact);
    on<_ToggleFavorite>(_onToggleFavorite);
    on<_SearchContacts>(_onSearchContacts);
    on<_ClearSearch>(_onClearSearch);
    on<_ImportPhoneContacts>(_onImportPhoneContacts);
    on<_ClearImportResults>(_onClearImportResults);
    on<_UnifiedSearch>(_onUnifiedSearch);
    on<_LoadFollowedBrands>(_onLoadFollowedBrands);
    on<_LoadAvailableBrands>(_onLoadAvailableBrands);
    on<_FollowBrand>(_onFollowBrand);
    on<_UnfollowBrand>(_onUnfollowBrand);
    on<_LoadSuggestions>(_onLoadSuggestions);
    on<_DismissSuggestion>(_onDismissSuggestion);
  }

  void _onWatchContacts(
    _WatchContacts event,
    Emitter<ContactState> emit,
  ) {
    _contactsSubscription?.cancel();
    emit(state.copyWith(status: ContactLoadingStatus.loading));

    _contactsSubscription = _contactRepository.watchContacts().listen(
      (result) {
        result.fold(
          (failure) => add(const ContactEvent.contactsUpdated([])),
          (contacts) => add(ContactEvent.contactsUpdated(contacts)),
        );
      },
      onError: (_) => add(const ContactEvent.contactsUpdated([])),
    );
  }

  void _onContactsUpdated(
    _ContactsUpdated event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      status: ContactLoadingStatus.loaded,
      contacts: event.contacts,
    ));
  }

  void _onWatchContactRequests(
    _WatchContactRequests event,
    Emitter<ContactState> emit,
  ) {
    _requestsSubscription?.cancel();

    _requestsSubscription = _contactRepository.watchContactRequests().listen(
      (result) {
        result.fold(
          (failure) => add(const ContactEvent.requestsUpdated([])),
          (requests) => add(ContactEvent.requestsUpdated(requests)),
        );
      },
      onError: (_) => add(const ContactEvent.requestsUpdated([])),
    );
  }

  void _onRequestsUpdated(
    _RequestsUpdated event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      contactRequests: event.requests,
      pendingRequestCount: event.requests.length,
    ));
  }

  Future<void> _onSendContactRequest(
    _SendContactRequest event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null, actionSuccess: null));

    final result = await _contactRepository.sendContactRequest(
      event.contactUserId,
      source: event.source,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {
        final message = event.source == 'phone_import'
            ? 'Contact added!'
            : 'Contact request sent!';
        emit(state.copyWith(
          sentContactRequestIds: {
            ...state.sentContactRequestIds,
            event.contactUserId,
          },
          actionSuccess: message,
        ));
      },
    );
  }

  Future<void> _onAcceptContactRequest(
    _AcceptContactRequest event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    final result =
        await _contactRepository.acceptContactRequest(event.contactId);

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {
        // Real-time streams will update both contacts and requests
      },
    );
  }

  Future<void> _onDeclineContactRequest(
    _DeclineContactRequest event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    final result =
        await _contactRepository.declineContactRequest(event.contactId);

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {
        // Real-time stream will remove declined request
      },
    );
  }

  Future<void> _onRemoveContact(
    _RemoveContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    final result = await _contactRepository.removeContact(event.contactId);

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {
        // Real-time stream will remove the contact
      },
    );
  }

  Future<void> _onBlockContact(
    _BlockContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    final result = await _contactRepository.blockContact(event.contactId);

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {},
    );
  }

  Future<void> _onUnblockContact(
    _UnblockContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    final result = await _contactRepository.unblockContact(event.contactId);

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {},
    );
  }

  Future<void> _onToggleFavorite(
    _ToggleFavorite event,
    Emitter<ContactState> emit,
  ) async {
    final result = await _contactRepository.updateContact(
      contactId: event.contactId,
      isFavorite: event.isFavorite,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(actionError: failure.displayMessage));
      },
      (_) {},
    );
  }

  Future<void> _onSearchContacts(
    _SearchContacts event,
    Emitter<ContactState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        isSearching: false,
        searchResults: [],
      ));
      return;
    }

    emit(state.copyWith(isSearching: true));

    final result = await _contactRepository.searchContacts(event.query);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isSearching: false,
          searchResults: [],
        ));
      },
      (contacts) {
        emit(state.copyWith(
          isSearching: false,
          searchResults: contacts,
        ));
      },
    );
  }

  void _onClearSearch(
    _ClearSearch event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      isSearching: false,
      searchResults: [],
    ));
  }

  Future<void> _onImportPhoneContacts(
    _ImportPhoneContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(
      isImporting: true,
      matchedPhoneContacts: [],
      unmatchedPhoneNumbers: [],
      actionError: null,
    ));

    final result =
        await _contactRepository.matchPhoneContacts(event.phoneNumbers);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isImporting: false,
          actionError: failure.displayMessage,
        ));
      },
      (matches) {
        // Separate matched phone numbers from input to find unmatched
        final matchedPhones = matches
            .map((m) => m['phoneNumber'] as String? ?? '')
            .where((p) => p.isNotEmpty)
            .toSet();
        final unmatched = event.phoneNumbers
            .where((p) => !matchedPhones.contains(p))
            .toList();

        emit(state.copyWith(
          isImporting: false,
          matchedPhoneContacts: matches,
          unmatchedPhoneNumbers: unmatched,
        ));
      },
    );
  }

  void _onClearImportResults(
    _ClearImportResults event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      matchedPhoneContacts: [],
      unmatchedPhoneNumbers: [],
    ));
  }

  Future<void> _onUnifiedSearch(
    _UnifiedSearch event,
    Emitter<ContactState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(state.copyWith(
        isSearching: false,
        searchResults: [],
        globalSearchResults: [],
        brandSearchResults: [],
      ));
      return;
    }

    emit(state.copyWith(isSearching: true));

    final queryLower = query.toLowerCase();

    // 1. Local contact search (filter from loaded contacts)
    final contactMatches = state.contacts.where((c) {
      final name = c.effectiveDisplayName.toLowerCase();
      final username = c.username?.toLowerCase() ?? '';
      return name.contains(queryLower) || username.contains(queryLower);
    }).toList();

    // 2. Brand search (filter from followed + available brands)
    final allBrands = <BrandAccount>{
      ...state.followedBrands,
      ...state.availableBrands,
    };
    final brandMatches = allBrands
        .where((b) => b.name.toLowerCase().contains(queryLower))
        .toList();

    // 3. Global user search (remote) — only if query is 2+ chars
    List<UserSearchResult> globalMatches = [];
    if (query.length >= 2) {
      final globalResult =
          await _conversationRepository.searchUsers(query);
      globalResult.fold(
        (failure) => null,
        (results) {
          // Exclude users who are already contacts
          final contactUserIds =
              state.contacts.map((c) => c.contactUserId).toSet();
          globalMatches = results
              .where((r) => !contactUserIds.contains(r.userId))
              .toList();
        },
      );
    }

    emit(state.copyWith(
      isSearching: false,
      searchResults: contactMatches,
      globalSearchResults: globalMatches,
      brandSearchResults: brandMatches,
    ));
  }

  Future<void> _onLoadFollowedBrands(
    _LoadFollowedBrands event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoadingBrands: true));

    final result = await _contactRepository.getFollowedBrands();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingBrands: false,
          actionError: failure.displayMessage,
        ));
      },
      (brands) {
        emit(state.copyWith(
          isLoadingBrands: false,
          followedBrands: brands,
        ));
      },
    );
  }

  Future<void> _onLoadAvailableBrands(
    _LoadAvailableBrands event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoadingBrands: true));

    final result = await _contactRepository.getAvailableBrands();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingBrands: false,
          actionError: failure.displayMessage,
        ));
      },
      (brands) {
        emit(state.copyWith(
          isLoadingBrands: false,
          availableBrands: brands,
        ));
      },
    );
  }

  Future<void> _onFollowBrand(
    _FollowBrand event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    // Optimistic update
    final brand = state.availableBrands.firstWhere(
      (b) => b.id == event.clientId,
      orElse: () => BrandAccount(
        id: event.clientId,
        name: 'Brand',
        isFollowed: true,
      ),
    );
    final updatedBrand = BrandAccount(
      id: brand.id,
      name: brand.name,
      logoUrl: brand.logoUrl,
      avatarColor: brand.avatarColor,
      description: brand.description,
      isFollowed: true,
      followerCount: brand.followerCount + 1,
    );

    emit(state.copyWith(
      followedBrands: [...state.followedBrands, updatedBrand],
      availableBrands: state.availableBrands
          .map((b) => b.id == event.clientId ? updatedBrand : b)
          .toList(),
    ));

    final result = await _contactRepository.followBrand(event.clientId);

    result.fold(
      (failure) {
        // Revert optimistic update
        emit(state.copyWith(
          followedBrands:
              state.followedBrands.where((b) => b.id != event.clientId).toList(),
          availableBrands: state.availableBrands
              .map((b) => b.id == event.clientId ? brand : b)
              .toList(),
          actionError: failure.displayMessage,
        ));
      },
      (_) {},
    );
  }

  Future<void> _onUnfollowBrand(
    _UnfollowBrand event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(actionError: null));

    // Save for potential revert
    final removedBrand = state.followedBrands.firstWhere(
      (b) => b.id == event.clientId,
      orElse: () => BrandAccount(
        id: event.clientId,
        name: 'Brand',
        isFollowed: false,
      ),
    );

    // Optimistic update
    emit(state.copyWith(
      followedBrands:
          state.followedBrands.where((b) => b.id != event.clientId).toList(),
      availableBrands: state.availableBrands
          .map((b) => b.id == event.clientId
              ? BrandAccount(
                  id: b.id,
                  name: b.name,
                  logoUrl: b.logoUrl,
                  avatarColor: b.avatarColor,
                  description: b.description,
                  isFollowed: false,
                  followerCount: (b.followerCount - 1).clamp(0, 999999),
                )
              : b)
          .toList(),
    ));

    final result = await _contactRepository.unfollowBrand(event.clientId);

    result.fold(
      (failure) {
        // Revert optimistic update
        emit(state.copyWith(
          followedBrands: [...state.followedBrands, removedBrand],
          availableBrands: state.availableBrands
              .map((b) => b.id == event.clientId ? removedBrand : b)
              .toList(),
          actionError: failure.displayMessage,
        ));
      },
      (_) {},
    );
  }

  Future<void> _onLoadSuggestions(
    _LoadSuggestions event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoadingSuggestions: true));

    final result = await _contactRepository.getSuggestions();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingSuggestions: false));
      },
      (suggestions) {
        emit(state.copyWith(
          isLoadingSuggestions: false,
          suggestions: suggestions,
        ));
      },
    );
  }

  void _onDismissSuggestion(
    _DismissSuggestion event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      suggestions:
          state.suggestions.where((s) => s.userId != event.userId).toList(),
    ));
  }

  @override
  Future<void> close() {
    _contactsSubscription?.cancel();
    _requestsSubscription?.cancel();
    return super.close();
  }
}
