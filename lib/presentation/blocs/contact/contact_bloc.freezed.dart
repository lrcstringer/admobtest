// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ContactEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactEventCopyWith<$Res> {
  factory $ContactEventCopyWith(
    ContactEvent value,
    $Res Function(ContactEvent) then,
  ) = _$ContactEventCopyWithImpl<$Res, ContactEvent>;
}

/// @nodoc
class _$ContactEventCopyWithImpl<$Res, $Val extends ContactEvent>
    implements $ContactEventCopyWith<$Res> {
  _$ContactEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WatchContactsImplCopyWith<$Res> {
  factory _$$WatchContactsImplCopyWith(
    _$WatchContactsImpl value,
    $Res Function(_$WatchContactsImpl) then,
  ) = __$$WatchContactsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchContactsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$WatchContactsImpl>
    implements _$$WatchContactsImplCopyWith<$Res> {
  __$$WatchContactsImplCopyWithImpl(
    _$WatchContactsImpl _value,
    $Res Function(_$WatchContactsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchContactsImpl implements _WatchContacts {
  const _$WatchContactsImpl();

  @override
  String toString() {
    return 'ContactEvent.watchContacts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchContactsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return watchContacts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return watchContacts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (watchContacts != null) {
      return watchContacts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return watchContacts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return watchContacts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (watchContacts != null) {
      return watchContacts(this);
    }
    return orElse();
  }
}

abstract class _WatchContacts implements ContactEvent {
  const factory _WatchContacts() = _$WatchContactsImpl;
}

/// @nodoc
abstract class _$$ContactsUpdatedImplCopyWith<$Res> {
  factory _$$ContactsUpdatedImplCopyWith(
    _$ContactsUpdatedImpl value,
    $Res Function(_$ContactsUpdatedImpl) then,
  ) = __$$ContactsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Contact> contacts});
}

/// @nodoc
class __$$ContactsUpdatedImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$ContactsUpdatedImpl>
    implements _$$ContactsUpdatedImplCopyWith<$Res> {
  __$$ContactsUpdatedImplCopyWithImpl(
    _$ContactsUpdatedImpl _value,
    $Res Function(_$ContactsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contacts = null}) {
    return _then(
      _$ContactsUpdatedImpl(
        null == contacts
            ? _value._contacts
            : contacts // ignore: cast_nullable_to_non_nullable
                  as List<Contact>,
      ),
    );
  }
}

/// @nodoc

class _$ContactsUpdatedImpl implements _ContactsUpdated {
  const _$ContactsUpdatedImpl(final List<Contact> contacts)
    : _contacts = contacts;

  final List<Contact> _contacts;
  @override
  List<Contact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'ContactEvent.contactsUpdated(contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_contacts));

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactsUpdatedImplCopyWith<_$ContactsUpdatedImpl> get copyWith =>
      __$$ContactsUpdatedImplCopyWithImpl<_$ContactsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return contactsUpdated(contacts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return contactsUpdated?.call(contacts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (contactsUpdated != null) {
      return contactsUpdated(contacts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return contactsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return contactsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (contactsUpdated != null) {
      return contactsUpdated(this);
    }
    return orElse();
  }
}

abstract class _ContactsUpdated implements ContactEvent {
  const factory _ContactsUpdated(final List<Contact> contacts) =
      _$ContactsUpdatedImpl;

  List<Contact> get contacts;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactsUpdatedImplCopyWith<_$ContactsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchContactRequestsImplCopyWith<$Res> {
  factory _$$WatchContactRequestsImplCopyWith(
    _$WatchContactRequestsImpl value,
    $Res Function(_$WatchContactRequestsImpl) then,
  ) = __$$WatchContactRequestsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchContactRequestsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$WatchContactRequestsImpl>
    implements _$$WatchContactRequestsImplCopyWith<$Res> {
  __$$WatchContactRequestsImplCopyWithImpl(
    _$WatchContactRequestsImpl _value,
    $Res Function(_$WatchContactRequestsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchContactRequestsImpl implements _WatchContactRequests {
  const _$WatchContactRequestsImpl();

  @override
  String toString() {
    return 'ContactEvent.watchContactRequests()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchContactRequestsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return watchContactRequests();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return watchContactRequests?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (watchContactRequests != null) {
      return watchContactRequests();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return watchContactRequests(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return watchContactRequests?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (watchContactRequests != null) {
      return watchContactRequests(this);
    }
    return orElse();
  }
}

abstract class _WatchContactRequests implements ContactEvent {
  const factory _WatchContactRequests() = _$WatchContactRequestsImpl;
}

/// @nodoc
abstract class _$$RequestsUpdatedImplCopyWith<$Res> {
  factory _$$RequestsUpdatedImplCopyWith(
    _$RequestsUpdatedImpl value,
    $Res Function(_$RequestsUpdatedImpl) then,
  ) = __$$RequestsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Contact> requests});
}

/// @nodoc
class __$$RequestsUpdatedImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$RequestsUpdatedImpl>
    implements _$$RequestsUpdatedImplCopyWith<$Res> {
  __$$RequestsUpdatedImplCopyWithImpl(
    _$RequestsUpdatedImpl _value,
    $Res Function(_$RequestsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requests = null}) {
    return _then(
      _$RequestsUpdatedImpl(
        null == requests
            ? _value._requests
            : requests // ignore: cast_nullable_to_non_nullable
                  as List<Contact>,
      ),
    );
  }
}

/// @nodoc

class _$RequestsUpdatedImpl implements _RequestsUpdated {
  const _$RequestsUpdatedImpl(final List<Contact> requests)
    : _requests = requests;

  final List<Contact> _requests;
  @override
  List<Contact> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'ContactEvent.requestsUpdated(requests: $requests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_requests));

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestsUpdatedImplCopyWith<_$RequestsUpdatedImpl> get copyWith =>
      __$$RequestsUpdatedImplCopyWithImpl<_$RequestsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return requestsUpdated(requests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return requestsUpdated?.call(requests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (requestsUpdated != null) {
      return requestsUpdated(requests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return requestsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return requestsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (requestsUpdated != null) {
      return requestsUpdated(this);
    }
    return orElse();
  }
}

abstract class _RequestsUpdated implements ContactEvent {
  const factory _RequestsUpdated(final List<Contact> requests) =
      _$RequestsUpdatedImpl;

  List<Contact> get requests;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestsUpdatedImplCopyWith<_$RequestsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendContactRequestImplCopyWith<$Res> {
  factory _$$SendContactRequestImplCopyWith(
    _$SendContactRequestImpl value,
    $Res Function(_$SendContactRequestImpl) then,
  ) = __$$SendContactRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactUserId, String? source});
}

/// @nodoc
class __$$SendContactRequestImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$SendContactRequestImpl>
    implements _$$SendContactRequestImplCopyWith<$Res> {
  __$$SendContactRequestImplCopyWithImpl(
    _$SendContactRequestImpl _value,
    $Res Function(_$SendContactRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactUserId = null, Object? source = freezed}) {
    return _then(
      _$SendContactRequestImpl(
        null == contactUserId
            ? _value.contactUserId
            : contactUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendContactRequestImpl implements _SendContactRequest {
  const _$SendContactRequestImpl(this.contactUserId, {this.source});

  @override
  final String contactUserId;
  @override
  final String? source;

  @override
  String toString() {
    return 'ContactEvent.sendContactRequest(contactUserId: $contactUserId, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendContactRequestImpl &&
            (identical(other.contactUserId, contactUserId) ||
                other.contactUserId == contactUserId) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactUserId, source);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendContactRequestImplCopyWith<_$SendContactRequestImpl> get copyWith =>
      __$$SendContactRequestImplCopyWithImpl<_$SendContactRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return sendContactRequest(contactUserId, source);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return sendContactRequest?.call(contactUserId, source);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (sendContactRequest != null) {
      return sendContactRequest(contactUserId, source);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return sendContactRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return sendContactRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (sendContactRequest != null) {
      return sendContactRequest(this);
    }
    return orElse();
  }
}

abstract class _SendContactRequest implements ContactEvent {
  const factory _SendContactRequest(
    final String contactUserId, {
    final String? source,
  }) = _$SendContactRequestImpl;

  String get contactUserId;
  String? get source;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendContactRequestImplCopyWith<_$SendContactRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptContactRequestImplCopyWith<$Res> {
  factory _$$AcceptContactRequestImplCopyWith(
    _$AcceptContactRequestImpl value,
    $Res Function(_$AcceptContactRequestImpl) then,
  ) = __$$AcceptContactRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$AcceptContactRequestImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$AcceptContactRequestImpl>
    implements _$$AcceptContactRequestImplCopyWith<$Res> {
  __$$AcceptContactRequestImplCopyWithImpl(
    _$AcceptContactRequestImpl _value,
    $Res Function(_$AcceptContactRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null}) {
    return _then(
      _$AcceptContactRequestImpl(
        null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptContactRequestImpl implements _AcceptContactRequest {
  const _$AcceptContactRequestImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactEvent.acceptContactRequest(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptContactRequestImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptContactRequestImplCopyWith<_$AcceptContactRequestImpl>
  get copyWith =>
      __$$AcceptContactRequestImplCopyWithImpl<_$AcceptContactRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return acceptContactRequest(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return acceptContactRequest?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (acceptContactRequest != null) {
      return acceptContactRequest(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return acceptContactRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return acceptContactRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (acceptContactRequest != null) {
      return acceptContactRequest(this);
    }
    return orElse();
  }
}

abstract class _AcceptContactRequest implements ContactEvent {
  const factory _AcceptContactRequest(final String contactId) =
      _$AcceptContactRequestImpl;

  String get contactId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptContactRequestImplCopyWith<_$AcceptContactRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeclineContactRequestImplCopyWith<$Res> {
  factory _$$DeclineContactRequestImplCopyWith(
    _$DeclineContactRequestImpl value,
    $Res Function(_$DeclineContactRequestImpl) then,
  ) = __$$DeclineContactRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$DeclineContactRequestImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$DeclineContactRequestImpl>
    implements _$$DeclineContactRequestImplCopyWith<$Res> {
  __$$DeclineContactRequestImplCopyWithImpl(
    _$DeclineContactRequestImpl _value,
    $Res Function(_$DeclineContactRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null}) {
    return _then(
      _$DeclineContactRequestImpl(
        null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeclineContactRequestImpl implements _DeclineContactRequest {
  const _$DeclineContactRequestImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactEvent.declineContactRequest(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineContactRequestImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeclineContactRequestImplCopyWith<_$DeclineContactRequestImpl>
  get copyWith =>
      __$$DeclineContactRequestImplCopyWithImpl<_$DeclineContactRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return declineContactRequest(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return declineContactRequest?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (declineContactRequest != null) {
      return declineContactRequest(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return declineContactRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return declineContactRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (declineContactRequest != null) {
      return declineContactRequest(this);
    }
    return orElse();
  }
}

abstract class _DeclineContactRequest implements ContactEvent {
  const factory _DeclineContactRequest(final String contactId) =
      _$DeclineContactRequestImpl;

  String get contactId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeclineContactRequestImplCopyWith<_$DeclineContactRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveContactImplCopyWith<$Res> {
  factory _$$RemoveContactImplCopyWith(
    _$RemoveContactImpl value,
    $Res Function(_$RemoveContactImpl) then,
  ) = __$$RemoveContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$RemoveContactImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$RemoveContactImpl>
    implements _$$RemoveContactImplCopyWith<$Res> {
  __$$RemoveContactImplCopyWithImpl(
    _$RemoveContactImpl _value,
    $Res Function(_$RemoveContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null}) {
    return _then(
      _$RemoveContactImpl(
        null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveContactImpl implements _RemoveContact {
  const _$RemoveContactImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactEvent.removeContact(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveContactImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveContactImplCopyWith<_$RemoveContactImpl> get copyWith =>
      __$$RemoveContactImplCopyWithImpl<_$RemoveContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return removeContact(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return removeContact?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (removeContact != null) {
      return removeContact(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return removeContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return removeContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (removeContact != null) {
      return removeContact(this);
    }
    return orElse();
  }
}

abstract class _RemoveContact implements ContactEvent {
  const factory _RemoveContact(final String contactId) = _$RemoveContactImpl;

  String get contactId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveContactImplCopyWith<_$RemoveContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockContactImplCopyWith<$Res> {
  factory _$$BlockContactImplCopyWith(
    _$BlockContactImpl value,
    $Res Function(_$BlockContactImpl) then,
  ) = __$$BlockContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$BlockContactImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$BlockContactImpl>
    implements _$$BlockContactImplCopyWith<$Res> {
  __$$BlockContactImplCopyWithImpl(
    _$BlockContactImpl _value,
    $Res Function(_$BlockContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null}) {
    return _then(
      _$BlockContactImpl(
        null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BlockContactImpl implements _BlockContact {
  const _$BlockContactImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactEvent.blockContact(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockContactImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockContactImplCopyWith<_$BlockContactImpl> get copyWith =>
      __$$BlockContactImplCopyWithImpl<_$BlockContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return blockContact(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return blockContact?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (blockContact != null) {
      return blockContact(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return blockContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return blockContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (blockContact != null) {
      return blockContact(this);
    }
    return orElse();
  }
}

abstract class _BlockContact implements ContactEvent {
  const factory _BlockContact(final String contactId) = _$BlockContactImpl;

  String get contactId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockContactImplCopyWith<_$BlockContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnblockContactImplCopyWith<$Res> {
  factory _$$UnblockContactImplCopyWith(
    _$UnblockContactImpl value,
    $Res Function(_$UnblockContactImpl) then,
  ) = __$$UnblockContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$UnblockContactImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$UnblockContactImpl>
    implements _$$UnblockContactImplCopyWith<$Res> {
  __$$UnblockContactImplCopyWithImpl(
    _$UnblockContactImpl _value,
    $Res Function(_$UnblockContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null}) {
    return _then(
      _$UnblockContactImpl(
        null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnblockContactImpl implements _UnblockContact {
  const _$UnblockContactImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactEvent.unblockContact(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnblockContactImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnblockContactImplCopyWith<_$UnblockContactImpl> get copyWith =>
      __$$UnblockContactImplCopyWithImpl<_$UnblockContactImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return unblockContact(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return unblockContact?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unblockContact != null) {
      return unblockContact(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return unblockContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return unblockContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unblockContact != null) {
      return unblockContact(this);
    }
    return orElse();
  }
}

abstract class _UnblockContact implements ContactEvent {
  const factory _UnblockContact(final String contactId) = _$UnblockContactImpl;

  String get contactId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnblockContactImplCopyWith<_$UnblockContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleFavoriteImplCopyWith<$Res> {
  factory _$$ToggleFavoriteImplCopyWith(
    _$ToggleFavoriteImpl value,
    $Res Function(_$ToggleFavoriteImpl) then,
  ) = __$$ToggleFavoriteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId, bool isFavorite});
}

/// @nodoc
class __$$ToggleFavoriteImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$ToggleFavoriteImpl>
    implements _$$ToggleFavoriteImplCopyWith<$Res> {
  __$$ToggleFavoriteImplCopyWithImpl(
    _$ToggleFavoriteImpl _value,
    $Res Function(_$ToggleFavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contactId = null, Object? isFavorite = null}) {
    return _then(
      _$ToggleFavoriteImpl(
        contactId: null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ToggleFavoriteImpl implements _ToggleFavorite {
  const _$ToggleFavoriteImpl({
    required this.contactId,
    required this.isFavorite,
  });

  @override
  final String contactId;
  @override
  final bool isFavorite;

  @override
  String toString() {
    return 'ContactEvent.toggleFavorite(contactId: $contactId, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleFavoriteImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId, isFavorite);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      __$$ToggleFavoriteImplCopyWithImpl<_$ToggleFavoriteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return toggleFavorite(contactId, isFavorite);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return toggleFavorite?.call(contactId, isFavorite);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(contactId, isFavorite);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return toggleFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return toggleFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(this);
    }
    return orElse();
  }
}

abstract class _ToggleFavorite implements ContactEvent {
  const factory _ToggleFavorite({
    required final String contactId,
    required final bool isFavorite,
  }) = _$ToggleFavoriteImpl;

  String get contactId;
  bool get isFavorite;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchContactsImplCopyWith<$Res> {
  factory _$$SearchContactsImplCopyWith(
    _$SearchContactsImpl value,
    $Res Function(_$SearchContactsImpl) then,
  ) = __$$SearchContactsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchContactsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$SearchContactsImpl>
    implements _$$SearchContactsImplCopyWith<$Res> {
  __$$SearchContactsImplCopyWithImpl(
    _$SearchContactsImpl _value,
    $Res Function(_$SearchContactsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchContactsImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchContactsImpl implements _SearchContacts {
  const _$SearchContactsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ContactEvent.searchContacts(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchContactsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchContactsImplCopyWith<_$SearchContactsImpl> get copyWith =>
      __$$SearchContactsImplCopyWithImpl<_$SearchContactsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return searchContacts(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return searchContacts?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (searchContacts != null) {
      return searchContacts(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return searchContacts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return searchContacts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (searchContacts != null) {
      return searchContacts(this);
    }
    return orElse();
  }
}

abstract class _SearchContacts implements ContactEvent {
  const factory _SearchContacts(final String query) = _$SearchContactsImpl;

  String get query;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchContactsImplCopyWith<_$SearchContactsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchImplCopyWith<$Res> {
  factory _$$ClearSearchImplCopyWith(
    _$ClearSearchImpl value,
    $Res Function(_$ClearSearchImpl) then,
  ) = __$$ClearSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$ClearSearchImpl>
    implements _$$ClearSearchImplCopyWith<$Res> {
  __$$ClearSearchImplCopyWithImpl(
    _$ClearSearchImpl _value,
    $Res Function(_$ClearSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchImpl implements _ClearSearch {
  const _$ClearSearchImpl();

  @override
  String toString() {
    return 'ContactEvent.clearSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class _ClearSearch implements ContactEvent {
  const factory _ClearSearch() = _$ClearSearchImpl;
}

/// @nodoc
abstract class _$$ImportPhoneContactsImplCopyWith<$Res> {
  factory _$$ImportPhoneContactsImplCopyWith(
    _$ImportPhoneContactsImpl value,
    $Res Function(_$ImportPhoneContactsImpl) then,
  ) = __$$ImportPhoneContactsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> phoneNumbers});
}

/// @nodoc
class __$$ImportPhoneContactsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$ImportPhoneContactsImpl>
    implements _$$ImportPhoneContactsImplCopyWith<$Res> {
  __$$ImportPhoneContactsImplCopyWithImpl(
    _$ImportPhoneContactsImpl _value,
    $Res Function(_$ImportPhoneContactsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumbers = null}) {
    return _then(
      _$ImportPhoneContactsImpl(
        null == phoneNumbers
            ? _value._phoneNumbers
            : phoneNumbers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$ImportPhoneContactsImpl implements _ImportPhoneContacts {
  const _$ImportPhoneContactsImpl(final List<String> phoneNumbers)
    : _phoneNumbers = phoneNumbers;

  final List<String> _phoneNumbers;
  @override
  List<String> get phoneNumbers {
    if (_phoneNumbers is EqualUnmodifiableListView) return _phoneNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phoneNumbers);
  }

  @override
  String toString() {
    return 'ContactEvent.importPhoneContacts(phoneNumbers: $phoneNumbers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImportPhoneContactsImpl &&
            const DeepCollectionEquality().equals(
              other._phoneNumbers,
              _phoneNumbers,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_phoneNumbers),
  );

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportPhoneContactsImplCopyWith<_$ImportPhoneContactsImpl> get copyWith =>
      __$$ImportPhoneContactsImplCopyWithImpl<_$ImportPhoneContactsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return importPhoneContacts(phoneNumbers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return importPhoneContacts?.call(phoneNumbers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (importPhoneContacts != null) {
      return importPhoneContacts(phoneNumbers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return importPhoneContacts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return importPhoneContacts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (importPhoneContacts != null) {
      return importPhoneContacts(this);
    }
    return orElse();
  }
}

abstract class _ImportPhoneContacts implements ContactEvent {
  const factory _ImportPhoneContacts(final List<String> phoneNumbers) =
      _$ImportPhoneContactsImpl;

  List<String> get phoneNumbers;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportPhoneContactsImplCopyWith<_$ImportPhoneContactsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearImportResultsImplCopyWith<$Res> {
  factory _$$ClearImportResultsImplCopyWith(
    _$ClearImportResultsImpl value,
    $Res Function(_$ClearImportResultsImpl) then,
  ) = __$$ClearImportResultsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearImportResultsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$ClearImportResultsImpl>
    implements _$$ClearImportResultsImplCopyWith<$Res> {
  __$$ClearImportResultsImplCopyWithImpl(
    _$ClearImportResultsImpl _value,
    $Res Function(_$ClearImportResultsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearImportResultsImpl implements _ClearImportResults {
  const _$ClearImportResultsImpl();

  @override
  String toString() {
    return 'ContactEvent.clearImportResults()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearImportResultsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return clearImportResults();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return clearImportResults?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (clearImportResults != null) {
      return clearImportResults();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return clearImportResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return clearImportResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (clearImportResults != null) {
      return clearImportResults(this);
    }
    return orElse();
  }
}

abstract class _ClearImportResults implements ContactEvent {
  const factory _ClearImportResults() = _$ClearImportResultsImpl;
}

/// @nodoc
abstract class _$$LoadFollowedBrandsImplCopyWith<$Res> {
  factory _$$LoadFollowedBrandsImplCopyWith(
    _$LoadFollowedBrandsImpl value,
    $Res Function(_$LoadFollowedBrandsImpl) then,
  ) = __$$LoadFollowedBrandsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFollowedBrandsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$LoadFollowedBrandsImpl>
    implements _$$LoadFollowedBrandsImplCopyWith<$Res> {
  __$$LoadFollowedBrandsImplCopyWithImpl(
    _$LoadFollowedBrandsImpl _value,
    $Res Function(_$LoadFollowedBrandsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadFollowedBrandsImpl implements _LoadFollowedBrands {
  const _$LoadFollowedBrandsImpl();

  @override
  String toString() {
    return 'ContactEvent.loadFollowedBrands()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFollowedBrandsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return loadFollowedBrands();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return loadFollowedBrands?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadFollowedBrands != null) {
      return loadFollowedBrands();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return loadFollowedBrands(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return loadFollowedBrands?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadFollowedBrands != null) {
      return loadFollowedBrands(this);
    }
    return orElse();
  }
}

abstract class _LoadFollowedBrands implements ContactEvent {
  const factory _LoadFollowedBrands() = _$LoadFollowedBrandsImpl;
}

/// @nodoc
abstract class _$$LoadAvailableBrandsImplCopyWith<$Res> {
  factory _$$LoadAvailableBrandsImplCopyWith(
    _$LoadAvailableBrandsImpl value,
    $Res Function(_$LoadAvailableBrandsImpl) then,
  ) = __$$LoadAvailableBrandsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadAvailableBrandsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$LoadAvailableBrandsImpl>
    implements _$$LoadAvailableBrandsImplCopyWith<$Res> {
  __$$LoadAvailableBrandsImplCopyWithImpl(
    _$LoadAvailableBrandsImpl _value,
    $Res Function(_$LoadAvailableBrandsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadAvailableBrandsImpl implements _LoadAvailableBrands {
  const _$LoadAvailableBrandsImpl();

  @override
  String toString() {
    return 'ContactEvent.loadAvailableBrands()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadAvailableBrandsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return loadAvailableBrands();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return loadAvailableBrands?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadAvailableBrands != null) {
      return loadAvailableBrands();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return loadAvailableBrands(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return loadAvailableBrands?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadAvailableBrands != null) {
      return loadAvailableBrands(this);
    }
    return orElse();
  }
}

abstract class _LoadAvailableBrands implements ContactEvent {
  const factory _LoadAvailableBrands() = _$LoadAvailableBrandsImpl;
}

/// @nodoc
abstract class _$$FollowBrandImplCopyWith<$Res> {
  factory _$$FollowBrandImplCopyWith(
    _$FollowBrandImpl value,
    $Res Function(_$FollowBrandImpl) then,
  ) = __$$FollowBrandImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$FollowBrandImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$FollowBrandImpl>
    implements _$$FollowBrandImplCopyWith<$Res> {
  __$$FollowBrandImplCopyWithImpl(
    _$FollowBrandImpl _value,
    $Res Function(_$FollowBrandImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$FollowBrandImpl(
        null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FollowBrandImpl implements _FollowBrand {
  const _$FollowBrandImpl(this.clientId);

  @override
  final String clientId;

  @override
  String toString() {
    return 'ContactEvent.followBrand(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowBrandImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowBrandImplCopyWith<_$FollowBrandImpl> get copyWith =>
      __$$FollowBrandImplCopyWithImpl<_$FollowBrandImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return followBrand(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return followBrand?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (followBrand != null) {
      return followBrand(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return followBrand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return followBrand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (followBrand != null) {
      return followBrand(this);
    }
    return orElse();
  }
}

abstract class _FollowBrand implements ContactEvent {
  const factory _FollowBrand(final String clientId) = _$FollowBrandImpl;

  String get clientId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowBrandImplCopyWith<_$FollowBrandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnfollowBrandImplCopyWith<$Res> {
  factory _$$UnfollowBrandImplCopyWith(
    _$UnfollowBrandImpl value,
    $Res Function(_$UnfollowBrandImpl) then,
  ) = __$$UnfollowBrandImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$UnfollowBrandImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$UnfollowBrandImpl>
    implements _$$UnfollowBrandImplCopyWith<$Res> {
  __$$UnfollowBrandImplCopyWithImpl(
    _$UnfollowBrandImpl _value,
    $Res Function(_$UnfollowBrandImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$UnfollowBrandImpl(
        null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnfollowBrandImpl implements _UnfollowBrand {
  const _$UnfollowBrandImpl(this.clientId);

  @override
  final String clientId;

  @override
  String toString() {
    return 'ContactEvent.unfollowBrand(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnfollowBrandImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnfollowBrandImplCopyWith<_$UnfollowBrandImpl> get copyWith =>
      __$$UnfollowBrandImplCopyWithImpl<_$UnfollowBrandImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return unfollowBrand(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return unfollowBrand?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unfollowBrand != null) {
      return unfollowBrand(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return unfollowBrand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return unfollowBrand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unfollowBrand != null) {
      return unfollowBrand(this);
    }
    return orElse();
  }
}

abstract class _UnfollowBrand implements ContactEvent {
  const factory _UnfollowBrand(final String clientId) = _$UnfollowBrandImpl;

  String get clientId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnfollowBrandImplCopyWith<_$UnfollowBrandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnifiedSearchImplCopyWith<$Res> {
  factory _$$UnifiedSearchImplCopyWith(
    _$UnifiedSearchImpl value,
    $Res Function(_$UnifiedSearchImpl) then,
  ) = __$$UnifiedSearchImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$UnifiedSearchImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$UnifiedSearchImpl>
    implements _$$UnifiedSearchImplCopyWith<$Res> {
  __$$UnifiedSearchImplCopyWithImpl(
    _$UnifiedSearchImpl _value,
    $Res Function(_$UnifiedSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$UnifiedSearchImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnifiedSearchImpl implements _UnifiedSearch {
  const _$UnifiedSearchImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ContactEvent.unifiedSearch(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnifiedSearchImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnifiedSearchImplCopyWith<_$UnifiedSearchImpl> get copyWith =>
      __$$UnifiedSearchImplCopyWithImpl<_$UnifiedSearchImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return unifiedSearch(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return unifiedSearch?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unifiedSearch != null) {
      return unifiedSearch(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return unifiedSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return unifiedSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (unifiedSearch != null) {
      return unifiedSearch(this);
    }
    return orElse();
  }
}

abstract class _UnifiedSearch implements ContactEvent {
  const factory _UnifiedSearch(final String query) = _$UnifiedSearchImpl;

  String get query;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnifiedSearchImplCopyWith<_$UnifiedSearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSuggestionsImplCopyWith<$Res> {
  factory _$$LoadSuggestionsImplCopyWith(
    _$LoadSuggestionsImpl value,
    $Res Function(_$LoadSuggestionsImpl) then,
  ) = __$$LoadSuggestionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSuggestionsImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$LoadSuggestionsImpl>
    implements _$$LoadSuggestionsImplCopyWith<$Res> {
  __$$LoadSuggestionsImplCopyWithImpl(
    _$LoadSuggestionsImpl _value,
    $Res Function(_$LoadSuggestionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSuggestionsImpl implements _LoadSuggestions {
  const _$LoadSuggestionsImpl();

  @override
  String toString() {
    return 'ContactEvent.loadSuggestions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSuggestionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return loadSuggestions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return loadSuggestions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadSuggestions != null) {
      return loadSuggestions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return loadSuggestions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return loadSuggestions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (loadSuggestions != null) {
      return loadSuggestions(this);
    }
    return orElse();
  }
}

abstract class _LoadSuggestions implements ContactEvent {
  const factory _LoadSuggestions() = _$LoadSuggestionsImpl;
}

/// @nodoc
abstract class _$$DismissSuggestionImplCopyWith<$Res> {
  factory _$$DismissSuggestionImplCopyWith(
    _$DismissSuggestionImpl value,
    $Res Function(_$DismissSuggestionImpl) then,
  ) = __$$DismissSuggestionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$DismissSuggestionImplCopyWithImpl<$Res>
    extends _$ContactEventCopyWithImpl<$Res, _$DismissSuggestionImpl>
    implements _$$DismissSuggestionImplCopyWith<$Res> {
  __$$DismissSuggestionImplCopyWithImpl(
    _$DismissSuggestionImpl _value,
    $Res Function(_$DismissSuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$DismissSuggestionImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DismissSuggestionImpl implements _DismissSuggestion {
  const _$DismissSuggestionImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ContactEvent.dismissSuggestion(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DismissSuggestionImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DismissSuggestionImplCopyWith<_$DismissSuggestionImpl> get copyWith =>
      __$$DismissSuggestionImplCopyWithImpl<_$DismissSuggestionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchContacts,
    required TResult Function(List<Contact> contacts) contactsUpdated,
    required TResult Function() watchContactRequests,
    required TResult Function(List<Contact> requests) requestsUpdated,
    required TResult Function(String contactUserId, String? source)
    sendContactRequest,
    required TResult Function(String contactId) acceptContactRequest,
    required TResult Function(String contactId) declineContactRequest,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
    required TResult Function(String contactId) unblockContact,
    required TResult Function(String contactId, bool isFavorite) toggleFavorite,
    required TResult Function(String query) searchContacts,
    required TResult Function() clearSearch,
    required TResult Function(List<String> phoneNumbers) importPhoneContacts,
    required TResult Function() clearImportResults,
    required TResult Function() loadFollowedBrands,
    required TResult Function() loadAvailableBrands,
    required TResult Function(String clientId) followBrand,
    required TResult Function(String clientId) unfollowBrand,
    required TResult Function(String query) unifiedSearch,
    required TResult Function() loadSuggestions,
    required TResult Function(String userId) dismissSuggestion,
  }) {
    return dismissSuggestion(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchContacts,
    TResult? Function(List<Contact> contacts)? contactsUpdated,
    TResult? Function()? watchContactRequests,
    TResult? Function(List<Contact> requests)? requestsUpdated,
    TResult? Function(String contactUserId, String? source)? sendContactRequest,
    TResult? Function(String contactId)? acceptContactRequest,
    TResult? Function(String contactId)? declineContactRequest,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
    TResult? Function(String contactId)? unblockContact,
    TResult? Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult? Function(String query)? searchContacts,
    TResult? Function()? clearSearch,
    TResult? Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult? Function()? clearImportResults,
    TResult? Function()? loadFollowedBrands,
    TResult? Function()? loadAvailableBrands,
    TResult? Function(String clientId)? followBrand,
    TResult? Function(String clientId)? unfollowBrand,
    TResult? Function(String query)? unifiedSearch,
    TResult? Function()? loadSuggestions,
    TResult? Function(String userId)? dismissSuggestion,
  }) {
    return dismissSuggestion?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchContacts,
    TResult Function(List<Contact> contacts)? contactsUpdated,
    TResult Function()? watchContactRequests,
    TResult Function(List<Contact> requests)? requestsUpdated,
    TResult Function(String contactUserId, String? source)? sendContactRequest,
    TResult Function(String contactId)? acceptContactRequest,
    TResult Function(String contactId)? declineContactRequest,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    TResult Function(String contactId)? unblockContact,
    TResult Function(String contactId, bool isFavorite)? toggleFavorite,
    TResult Function(String query)? searchContacts,
    TResult Function()? clearSearch,
    TResult Function(List<String> phoneNumbers)? importPhoneContacts,
    TResult Function()? clearImportResults,
    TResult Function()? loadFollowedBrands,
    TResult Function()? loadAvailableBrands,
    TResult Function(String clientId)? followBrand,
    TResult Function(String clientId)? unfollowBrand,
    TResult Function(String query)? unifiedSearch,
    TResult Function()? loadSuggestions,
    TResult Function(String userId)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (dismissSuggestion != null) {
      return dismissSuggestion(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchContacts value) watchContacts,
    required TResult Function(_ContactsUpdated value) contactsUpdated,
    required TResult Function(_WatchContactRequests value) watchContactRequests,
    required TResult Function(_RequestsUpdated value) requestsUpdated,
    required TResult Function(_SendContactRequest value) sendContactRequest,
    required TResult Function(_AcceptContactRequest value) acceptContactRequest,
    required TResult Function(_DeclineContactRequest value)
    declineContactRequest,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
    required TResult Function(_UnblockContact value) unblockContact,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
    required TResult Function(_SearchContacts value) searchContacts,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ImportPhoneContacts value) importPhoneContacts,
    required TResult Function(_ClearImportResults value) clearImportResults,
    required TResult Function(_LoadFollowedBrands value) loadFollowedBrands,
    required TResult Function(_LoadAvailableBrands value) loadAvailableBrands,
    required TResult Function(_FollowBrand value) followBrand,
    required TResult Function(_UnfollowBrand value) unfollowBrand,
    required TResult Function(_UnifiedSearch value) unifiedSearch,
    required TResult Function(_LoadSuggestions value) loadSuggestions,
    required TResult Function(_DismissSuggestion value) dismissSuggestion,
  }) {
    return dismissSuggestion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchContacts value)? watchContacts,
    TResult? Function(_ContactsUpdated value)? contactsUpdated,
    TResult? Function(_WatchContactRequests value)? watchContactRequests,
    TResult? Function(_RequestsUpdated value)? requestsUpdated,
    TResult? Function(_SendContactRequest value)? sendContactRequest,
    TResult? Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult? Function(_DeclineContactRequest value)? declineContactRequest,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
    TResult? Function(_UnblockContact value)? unblockContact,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
    TResult? Function(_SearchContacts value)? searchContacts,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult? Function(_ClearImportResults value)? clearImportResults,
    TResult? Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult? Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult? Function(_FollowBrand value)? followBrand,
    TResult? Function(_UnfollowBrand value)? unfollowBrand,
    TResult? Function(_UnifiedSearch value)? unifiedSearch,
    TResult? Function(_LoadSuggestions value)? loadSuggestions,
    TResult? Function(_DismissSuggestion value)? dismissSuggestion,
  }) {
    return dismissSuggestion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchContacts value)? watchContacts,
    TResult Function(_ContactsUpdated value)? contactsUpdated,
    TResult Function(_WatchContactRequests value)? watchContactRequests,
    TResult Function(_RequestsUpdated value)? requestsUpdated,
    TResult Function(_SendContactRequest value)? sendContactRequest,
    TResult Function(_AcceptContactRequest value)? acceptContactRequest,
    TResult Function(_DeclineContactRequest value)? declineContactRequest,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    TResult Function(_UnblockContact value)? unblockContact,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    TResult Function(_SearchContacts value)? searchContacts,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ImportPhoneContacts value)? importPhoneContacts,
    TResult Function(_ClearImportResults value)? clearImportResults,
    TResult Function(_LoadFollowedBrands value)? loadFollowedBrands,
    TResult Function(_LoadAvailableBrands value)? loadAvailableBrands,
    TResult Function(_FollowBrand value)? followBrand,
    TResult Function(_UnfollowBrand value)? unfollowBrand,
    TResult Function(_UnifiedSearch value)? unifiedSearch,
    TResult Function(_LoadSuggestions value)? loadSuggestions,
    TResult Function(_DismissSuggestion value)? dismissSuggestion,
    required TResult orElse(),
  }) {
    if (dismissSuggestion != null) {
      return dismissSuggestion(this);
    }
    return orElse();
  }
}

abstract class _DismissSuggestion implements ContactEvent {
  const factory _DismissSuggestion(final String userId) =
      _$DismissSuggestionImpl;

  String get userId;

  /// Create a copy of ContactEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DismissSuggestionImplCopyWith<_$DismissSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContactState {
  ContactLoadingStatus get status => throw _privateConstructorUsedError;
  List<Contact> get contacts => throw _privateConstructorUsedError;
  List<Contact> get contactRequests => throw _privateConstructorUsedError;
  int get pendingRequestCount => throw _privateConstructorUsedError;
  List<Contact> get searchResults => throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  String? get actionError =>
      throw _privateConstructorUsedError; // Phone import state
  bool get isImporting => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get matchedPhoneContacts =>
      throw _privateConstructorUsedError;
  List<String> get unmatchedPhoneNumbers =>
      throw _privateConstructorUsedError; // Brand accounts state
  List<BrandAccount> get followedBrands => throw _privateConstructorUsedError;
  List<BrandAccount> get availableBrands => throw _privateConstructorUsedError;
  bool get isLoadingBrands =>
      throw _privateConstructorUsedError; // Unified search state
  List<UserSearchResult> get globalSearchResults =>
      throw _privateConstructorUsedError;
  List<BrandAccount> get brandSearchResults =>
      throw _privateConstructorUsedError; // People You May Know suggestions
  List<ContactSuggestion> get suggestions => throw _privateConstructorUsedError;
  bool get isLoadingSuggestions =>
      throw _privateConstructorUsedError; // Track sent contact request user IDs for UI feedback
  Set<String> get sentContactRequestIds =>
      throw _privateConstructorUsedError; // Success message for actions (e.g. contact request sent)
  String? get actionSuccess => throw _privateConstructorUsedError;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactStateCopyWith<ContactState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStateCopyWith<$Res> {
  factory $ContactStateCopyWith(
    ContactState value,
    $Res Function(ContactState) then,
  ) = _$ContactStateCopyWithImpl<$Res, ContactState>;
  @useResult
  $Res call({
    ContactLoadingStatus status,
    List<Contact> contacts,
    List<Contact> contactRequests,
    int pendingRequestCount,
    List<Contact> searchResults,
    bool isSearching,
    String? actionError,
    bool isImporting,
    List<Map<String, dynamic>> matchedPhoneContacts,
    List<String> unmatchedPhoneNumbers,
    List<BrandAccount> followedBrands,
    List<BrandAccount> availableBrands,
    bool isLoadingBrands,
    List<UserSearchResult> globalSearchResults,
    List<BrandAccount> brandSearchResults,
    List<ContactSuggestion> suggestions,
    bool isLoadingSuggestions,
    Set<String> sentContactRequestIds,
    String? actionSuccess,
  });
}

/// @nodoc
class _$ContactStateCopyWithImpl<$Res, $Val extends ContactState>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? contacts = null,
    Object? contactRequests = null,
    Object? pendingRequestCount = null,
    Object? searchResults = null,
    Object? isSearching = null,
    Object? actionError = freezed,
    Object? isImporting = null,
    Object? matchedPhoneContacts = null,
    Object? unmatchedPhoneNumbers = null,
    Object? followedBrands = null,
    Object? availableBrands = null,
    Object? isLoadingBrands = null,
    Object? globalSearchResults = null,
    Object? brandSearchResults = null,
    Object? suggestions = null,
    Object? isLoadingSuggestions = null,
    Object? sentContactRequestIds = null,
    Object? actionSuccess = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ContactLoadingStatus,
            contacts: null == contacts
                ? _value.contacts
                : contacts // ignore: cast_nullable_to_non_nullable
                      as List<Contact>,
            contactRequests: null == contactRequests
                ? _value.contactRequests
                : contactRequests // ignore: cast_nullable_to_non_nullable
                      as List<Contact>,
            pendingRequestCount: null == pendingRequestCount
                ? _value.pendingRequestCount
                : pendingRequestCount // ignore: cast_nullable_to_non_nullable
                      as int,
            searchResults: null == searchResults
                ? _value.searchResults
                : searchResults // ignore: cast_nullable_to_non_nullable
                      as List<Contact>,
            isSearching: null == isSearching
                ? _value.isSearching
                : isSearching // ignore: cast_nullable_to_non_nullable
                      as bool,
            actionError: freezed == actionError
                ? _value.actionError
                : actionError // ignore: cast_nullable_to_non_nullable
                      as String?,
            isImporting: null == isImporting
                ? _value.isImporting
                : isImporting // ignore: cast_nullable_to_non_nullable
                      as bool,
            matchedPhoneContacts: null == matchedPhoneContacts
                ? _value.matchedPhoneContacts
                : matchedPhoneContacts // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            unmatchedPhoneNumbers: null == unmatchedPhoneNumbers
                ? _value.unmatchedPhoneNumbers
                : unmatchedPhoneNumbers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            followedBrands: null == followedBrands
                ? _value.followedBrands
                : followedBrands // ignore: cast_nullable_to_non_nullable
                      as List<BrandAccount>,
            availableBrands: null == availableBrands
                ? _value.availableBrands
                : availableBrands // ignore: cast_nullable_to_non_nullable
                      as List<BrandAccount>,
            isLoadingBrands: null == isLoadingBrands
                ? _value.isLoadingBrands
                : isLoadingBrands // ignore: cast_nullable_to_non_nullable
                      as bool,
            globalSearchResults: null == globalSearchResults
                ? _value.globalSearchResults
                : globalSearchResults // ignore: cast_nullable_to_non_nullable
                      as List<UserSearchResult>,
            brandSearchResults: null == brandSearchResults
                ? _value.brandSearchResults
                : brandSearchResults // ignore: cast_nullable_to_non_nullable
                      as List<BrandAccount>,
            suggestions: null == suggestions
                ? _value.suggestions
                : suggestions // ignore: cast_nullable_to_non_nullable
                      as List<ContactSuggestion>,
            isLoadingSuggestions: null == isLoadingSuggestions
                ? _value.isLoadingSuggestions
                : isLoadingSuggestions // ignore: cast_nullable_to_non_nullable
                      as bool,
            sentContactRequestIds: null == sentContactRequestIds
                ? _value.sentContactRequestIds
                : sentContactRequestIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            actionSuccess: freezed == actionSuccess
                ? _value.actionSuccess
                : actionSuccess // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactStateImplCopyWith<$Res>
    implements $ContactStateCopyWith<$Res> {
  factory _$$ContactStateImplCopyWith(
    _$ContactStateImpl value,
    $Res Function(_$ContactStateImpl) then,
  ) = __$$ContactStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ContactLoadingStatus status,
    List<Contact> contacts,
    List<Contact> contactRequests,
    int pendingRequestCount,
    List<Contact> searchResults,
    bool isSearching,
    String? actionError,
    bool isImporting,
    List<Map<String, dynamic>> matchedPhoneContacts,
    List<String> unmatchedPhoneNumbers,
    List<BrandAccount> followedBrands,
    List<BrandAccount> availableBrands,
    bool isLoadingBrands,
    List<UserSearchResult> globalSearchResults,
    List<BrandAccount> brandSearchResults,
    List<ContactSuggestion> suggestions,
    bool isLoadingSuggestions,
    Set<String> sentContactRequestIds,
    String? actionSuccess,
  });
}

/// @nodoc
class __$$ContactStateImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateImpl>
    implements _$$ContactStateImplCopyWith<$Res> {
  __$$ContactStateImplCopyWithImpl(
    _$ContactStateImpl _value,
    $Res Function(_$ContactStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? contacts = null,
    Object? contactRequests = null,
    Object? pendingRequestCount = null,
    Object? searchResults = null,
    Object? isSearching = null,
    Object? actionError = freezed,
    Object? isImporting = null,
    Object? matchedPhoneContacts = null,
    Object? unmatchedPhoneNumbers = null,
    Object? followedBrands = null,
    Object? availableBrands = null,
    Object? isLoadingBrands = null,
    Object? globalSearchResults = null,
    Object? brandSearchResults = null,
    Object? suggestions = null,
    Object? isLoadingSuggestions = null,
    Object? sentContactRequestIds = null,
    Object? actionSuccess = freezed,
  }) {
    return _then(
      _$ContactStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ContactLoadingStatus,
        contacts: null == contacts
            ? _value._contacts
            : contacts // ignore: cast_nullable_to_non_nullable
                  as List<Contact>,
        contactRequests: null == contactRequests
            ? _value._contactRequests
            : contactRequests // ignore: cast_nullable_to_non_nullable
                  as List<Contact>,
        pendingRequestCount: null == pendingRequestCount
            ? _value.pendingRequestCount
            : pendingRequestCount // ignore: cast_nullable_to_non_nullable
                  as int,
        searchResults: null == searchResults
            ? _value._searchResults
            : searchResults // ignore: cast_nullable_to_non_nullable
                  as List<Contact>,
        isSearching: null == isSearching
            ? _value.isSearching
            : isSearching // ignore: cast_nullable_to_non_nullable
                  as bool,
        actionError: freezed == actionError
            ? _value.actionError
            : actionError // ignore: cast_nullable_to_non_nullable
                  as String?,
        isImporting: null == isImporting
            ? _value.isImporting
            : isImporting // ignore: cast_nullable_to_non_nullable
                  as bool,
        matchedPhoneContacts: null == matchedPhoneContacts
            ? _value._matchedPhoneContacts
            : matchedPhoneContacts // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        unmatchedPhoneNumbers: null == unmatchedPhoneNumbers
            ? _value._unmatchedPhoneNumbers
            : unmatchedPhoneNumbers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        followedBrands: null == followedBrands
            ? _value._followedBrands
            : followedBrands // ignore: cast_nullable_to_non_nullable
                  as List<BrandAccount>,
        availableBrands: null == availableBrands
            ? _value._availableBrands
            : availableBrands // ignore: cast_nullable_to_non_nullable
                  as List<BrandAccount>,
        isLoadingBrands: null == isLoadingBrands
            ? _value.isLoadingBrands
            : isLoadingBrands // ignore: cast_nullable_to_non_nullable
                  as bool,
        globalSearchResults: null == globalSearchResults
            ? _value._globalSearchResults
            : globalSearchResults // ignore: cast_nullable_to_non_nullable
                  as List<UserSearchResult>,
        brandSearchResults: null == brandSearchResults
            ? _value._brandSearchResults
            : brandSearchResults // ignore: cast_nullable_to_non_nullable
                  as List<BrandAccount>,
        suggestions: null == suggestions
            ? _value._suggestions
            : suggestions // ignore: cast_nullable_to_non_nullable
                  as List<ContactSuggestion>,
        isLoadingSuggestions: null == isLoadingSuggestions
            ? _value.isLoadingSuggestions
            : isLoadingSuggestions // ignore: cast_nullable_to_non_nullable
                  as bool,
        sentContactRequestIds: null == sentContactRequestIds
            ? _value._sentContactRequestIds
            : sentContactRequestIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        actionSuccess: freezed == actionSuccess
            ? _value.actionSuccess
            : actionSuccess // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ContactStateImpl implements _ContactState {
  const _$ContactStateImpl({
    this.status = ContactLoadingStatus.initial,
    final List<Contact> contacts = const [],
    final List<Contact> contactRequests = const [],
    this.pendingRequestCount = 0,
    final List<Contact> searchResults = const [],
    this.isSearching = false,
    this.actionError,
    this.isImporting = false,
    final List<Map<String, dynamic>> matchedPhoneContacts = const [],
    final List<String> unmatchedPhoneNumbers = const [],
    final List<BrandAccount> followedBrands = const [],
    final List<BrandAccount> availableBrands = const [],
    this.isLoadingBrands = false,
    final List<UserSearchResult> globalSearchResults = const [],
    final List<BrandAccount> brandSearchResults = const [],
    final List<ContactSuggestion> suggestions = const [],
    this.isLoadingSuggestions = false,
    final Set<String> sentContactRequestIds = const {},
    this.actionSuccess,
  }) : _contacts = contacts,
       _contactRequests = contactRequests,
       _searchResults = searchResults,
       _matchedPhoneContacts = matchedPhoneContacts,
       _unmatchedPhoneNumbers = unmatchedPhoneNumbers,
       _followedBrands = followedBrands,
       _availableBrands = availableBrands,
       _globalSearchResults = globalSearchResults,
       _brandSearchResults = brandSearchResults,
       _suggestions = suggestions,
       _sentContactRequestIds = sentContactRequestIds;

  @override
  @JsonKey()
  final ContactLoadingStatus status;
  final List<Contact> _contacts;
  @override
  @JsonKey()
  List<Contact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  final List<Contact> _contactRequests;
  @override
  @JsonKey()
  List<Contact> get contactRequests {
    if (_contactRequests is EqualUnmodifiableListView) return _contactRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contactRequests);
  }

  @override
  @JsonKey()
  final int pendingRequestCount;
  final List<Contact> _searchResults;
  @override
  @JsonKey()
  List<Contact> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  @JsonKey()
  final bool isSearching;
  @override
  final String? actionError;
  // Phone import state
  @override
  @JsonKey()
  final bool isImporting;
  final List<Map<String, dynamic>> _matchedPhoneContacts;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get matchedPhoneContacts {
    if (_matchedPhoneContacts is EqualUnmodifiableListView)
      return _matchedPhoneContacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchedPhoneContacts);
  }

  final List<String> _unmatchedPhoneNumbers;
  @override
  @JsonKey()
  List<String> get unmatchedPhoneNumbers {
    if (_unmatchedPhoneNumbers is EqualUnmodifiableListView)
      return _unmatchedPhoneNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unmatchedPhoneNumbers);
  }

  // Brand accounts state
  final List<BrandAccount> _followedBrands;
  // Brand accounts state
  @override
  @JsonKey()
  List<BrandAccount> get followedBrands {
    if (_followedBrands is EqualUnmodifiableListView) return _followedBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followedBrands);
  }

  final List<BrandAccount> _availableBrands;
  @override
  @JsonKey()
  List<BrandAccount> get availableBrands {
    if (_availableBrands is EqualUnmodifiableListView) return _availableBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBrands);
  }

  @override
  @JsonKey()
  final bool isLoadingBrands;
  // Unified search state
  final List<UserSearchResult> _globalSearchResults;
  // Unified search state
  @override
  @JsonKey()
  List<UserSearchResult> get globalSearchResults {
    if (_globalSearchResults is EqualUnmodifiableListView)
      return _globalSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_globalSearchResults);
  }

  final List<BrandAccount> _brandSearchResults;
  @override
  @JsonKey()
  List<BrandAccount> get brandSearchResults {
    if (_brandSearchResults is EqualUnmodifiableListView)
      return _brandSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brandSearchResults);
  }

  // People You May Know suggestions
  final List<ContactSuggestion> _suggestions;
  // People You May Know suggestions
  @override
  @JsonKey()
  List<ContactSuggestion> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  @JsonKey()
  final bool isLoadingSuggestions;
  // Track sent contact request user IDs for UI feedback
  final Set<String> _sentContactRequestIds;
  // Track sent contact request user IDs for UI feedback
  @override
  @JsonKey()
  Set<String> get sentContactRequestIds {
    if (_sentContactRequestIds is EqualUnmodifiableSetView)
      return _sentContactRequestIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sentContactRequestIds);
  }

  // Success message for actions (e.g. contact request sent)
  @override
  final String? actionSuccess;

  @override
  String toString() {
    return 'ContactState(status: $status, contacts: $contacts, contactRequests: $contactRequests, pendingRequestCount: $pendingRequestCount, searchResults: $searchResults, isSearching: $isSearching, actionError: $actionError, isImporting: $isImporting, matchedPhoneContacts: $matchedPhoneContacts, unmatchedPhoneNumbers: $unmatchedPhoneNumbers, followedBrands: $followedBrands, availableBrands: $availableBrands, isLoadingBrands: $isLoadingBrands, globalSearchResults: $globalSearchResults, brandSearchResults: $brandSearchResults, suggestions: $suggestions, isLoadingSuggestions: $isLoadingSuggestions, sentContactRequestIds: $sentContactRequestIds, actionSuccess: $actionSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            const DeepCollectionEquality().equals(
              other._contactRequests,
              _contactRequests,
            ) &&
            (identical(other.pendingRequestCount, pendingRequestCount) ||
                other.pendingRequestCount == pendingRequestCount) &&
            const DeepCollectionEquality().equals(
              other._searchResults,
              _searchResults,
            ) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.actionError, actionError) ||
                other.actionError == actionError) &&
            (identical(other.isImporting, isImporting) ||
                other.isImporting == isImporting) &&
            const DeepCollectionEquality().equals(
              other._matchedPhoneContacts,
              _matchedPhoneContacts,
            ) &&
            const DeepCollectionEquality().equals(
              other._unmatchedPhoneNumbers,
              _unmatchedPhoneNumbers,
            ) &&
            const DeepCollectionEquality().equals(
              other._followedBrands,
              _followedBrands,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableBrands,
              _availableBrands,
            ) &&
            (identical(other.isLoadingBrands, isLoadingBrands) ||
                other.isLoadingBrands == isLoadingBrands) &&
            const DeepCollectionEquality().equals(
              other._globalSearchResults,
              _globalSearchResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._brandSearchResults,
              _brandSearchResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._suggestions,
              _suggestions,
            ) &&
            (identical(other.isLoadingSuggestions, isLoadingSuggestions) ||
                other.isLoadingSuggestions == isLoadingSuggestions) &&
            const DeepCollectionEquality().equals(
              other._sentContactRequestIds,
              _sentContactRequestIds,
            ) &&
            (identical(other.actionSuccess, actionSuccess) ||
                other.actionSuccess == actionSuccess));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_contacts),
    const DeepCollectionEquality().hash(_contactRequests),
    pendingRequestCount,
    const DeepCollectionEquality().hash(_searchResults),
    isSearching,
    actionError,
    isImporting,
    const DeepCollectionEquality().hash(_matchedPhoneContacts),
    const DeepCollectionEquality().hash(_unmatchedPhoneNumbers),
    const DeepCollectionEquality().hash(_followedBrands),
    const DeepCollectionEquality().hash(_availableBrands),
    isLoadingBrands,
    const DeepCollectionEquality().hash(_globalSearchResults),
    const DeepCollectionEquality().hash(_brandSearchResults),
    const DeepCollectionEquality().hash(_suggestions),
    isLoadingSuggestions,
    const DeepCollectionEquality().hash(_sentContactRequestIds),
    actionSuccess,
  ]);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateImplCopyWith<_$ContactStateImpl> get copyWith =>
      __$$ContactStateImplCopyWithImpl<_$ContactStateImpl>(this, _$identity);
}

abstract class _ContactState implements ContactState {
  const factory _ContactState({
    final ContactLoadingStatus status,
    final List<Contact> contacts,
    final List<Contact> contactRequests,
    final int pendingRequestCount,
    final List<Contact> searchResults,
    final bool isSearching,
    final String? actionError,
    final bool isImporting,
    final List<Map<String, dynamic>> matchedPhoneContacts,
    final List<String> unmatchedPhoneNumbers,
    final List<BrandAccount> followedBrands,
    final List<BrandAccount> availableBrands,
    final bool isLoadingBrands,
    final List<UserSearchResult> globalSearchResults,
    final List<BrandAccount> brandSearchResults,
    final List<ContactSuggestion> suggestions,
    final bool isLoadingSuggestions,
    final Set<String> sentContactRequestIds,
    final String? actionSuccess,
  }) = _$ContactStateImpl;

  @override
  ContactLoadingStatus get status;
  @override
  List<Contact> get contacts;
  @override
  List<Contact> get contactRequests;
  @override
  int get pendingRequestCount;
  @override
  List<Contact> get searchResults;
  @override
  bool get isSearching;
  @override
  String? get actionError; // Phone import state
  @override
  bool get isImporting;
  @override
  List<Map<String, dynamic>> get matchedPhoneContacts;
  @override
  List<String> get unmatchedPhoneNumbers; // Brand accounts state
  @override
  List<BrandAccount> get followedBrands;
  @override
  List<BrandAccount> get availableBrands;
  @override
  bool get isLoadingBrands; // Unified search state
  @override
  List<UserSearchResult> get globalSearchResults;
  @override
  List<BrandAccount> get brandSearchResults; // People You May Know suggestions
  @override
  List<ContactSuggestion> get suggestions;
  @override
  bool get isLoadingSuggestions; // Track sent contact request user IDs for UI feedback
  @override
  Set<String> get sentContactRequestIds; // Success message for actions (e.g. contact request sent)
  @override
  String? get actionSuccess;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactStateImplCopyWith<_$ContactStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
