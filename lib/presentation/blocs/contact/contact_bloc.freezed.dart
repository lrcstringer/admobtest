// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent()';
}


}

/// @nodoc
class $ContactEventCopyWith<$Res>  {
$ContactEventCopyWith(ContactEvent _, $Res Function(ContactEvent) __);
}


/// Adds pattern-matching-related methods to [ContactEvent].
extension ContactEventPatterns on ContactEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _WatchContacts value)?  watchContacts,TResult Function( _ContactsUpdated value)?  contactsUpdated,TResult Function( _WatchContactRequests value)?  watchContactRequests,TResult Function( _RequestsUpdated value)?  requestsUpdated,TResult Function( _SendContactRequest value)?  sendContactRequest,TResult Function( _AcceptContactRequest value)?  acceptContactRequest,TResult Function( _DeclineContactRequest value)?  declineContactRequest,TResult Function( _RemoveContact value)?  removeContact,TResult Function( _BlockContact value)?  blockContact,TResult Function( _UnblockContact value)?  unblockContact,TResult Function( _ToggleFavorite value)?  toggleFavorite,TResult Function( _SearchContacts value)?  searchContacts,TResult Function( _ClearSearch value)?  clearSearch,TResult Function( _ImportPhoneContacts value)?  importPhoneContacts,TResult Function( _ClearImportResults value)?  clearImportResults,TResult Function( _LoadFollowedBrands value)?  loadFollowedBrands,TResult Function( _LoadAvailableBrands value)?  loadAvailableBrands,TResult Function( _FollowBrand value)?  followBrand,TResult Function( _UnfollowBrand value)?  unfollowBrand,TResult Function( _UnifiedSearch value)?  unifiedSearch,TResult Function( _LoadSuggestions value)?  loadSuggestions,TResult Function( _DismissSuggestion value)?  dismissSuggestion,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchContacts() when watchContacts != null:
return watchContacts(_that);case _ContactsUpdated() when contactsUpdated != null:
return contactsUpdated(_that);case _WatchContactRequests() when watchContactRequests != null:
return watchContactRequests(_that);case _RequestsUpdated() when requestsUpdated != null:
return requestsUpdated(_that);case _SendContactRequest() when sendContactRequest != null:
return sendContactRequest(_that);case _AcceptContactRequest() when acceptContactRequest != null:
return acceptContactRequest(_that);case _DeclineContactRequest() when declineContactRequest != null:
return declineContactRequest(_that);case _RemoveContact() when removeContact != null:
return removeContact(_that);case _BlockContact() when blockContact != null:
return blockContact(_that);case _UnblockContact() when unblockContact != null:
return unblockContact(_that);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _SearchContacts() when searchContacts != null:
return searchContacts(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _ImportPhoneContacts() when importPhoneContacts != null:
return importPhoneContacts(_that);case _ClearImportResults() when clearImportResults != null:
return clearImportResults(_that);case _LoadFollowedBrands() when loadFollowedBrands != null:
return loadFollowedBrands(_that);case _LoadAvailableBrands() when loadAvailableBrands != null:
return loadAvailableBrands(_that);case _FollowBrand() when followBrand != null:
return followBrand(_that);case _UnfollowBrand() when unfollowBrand != null:
return unfollowBrand(_that);case _UnifiedSearch() when unifiedSearch != null:
return unifiedSearch(_that);case _LoadSuggestions() when loadSuggestions != null:
return loadSuggestions(_that);case _DismissSuggestion() when dismissSuggestion != null:
return dismissSuggestion(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _WatchContacts value)  watchContacts,required TResult Function( _ContactsUpdated value)  contactsUpdated,required TResult Function( _WatchContactRequests value)  watchContactRequests,required TResult Function( _RequestsUpdated value)  requestsUpdated,required TResult Function( _SendContactRequest value)  sendContactRequest,required TResult Function( _AcceptContactRequest value)  acceptContactRequest,required TResult Function( _DeclineContactRequest value)  declineContactRequest,required TResult Function( _RemoveContact value)  removeContact,required TResult Function( _BlockContact value)  blockContact,required TResult Function( _UnblockContact value)  unblockContact,required TResult Function( _ToggleFavorite value)  toggleFavorite,required TResult Function( _SearchContacts value)  searchContacts,required TResult Function( _ClearSearch value)  clearSearch,required TResult Function( _ImportPhoneContacts value)  importPhoneContacts,required TResult Function( _ClearImportResults value)  clearImportResults,required TResult Function( _LoadFollowedBrands value)  loadFollowedBrands,required TResult Function( _LoadAvailableBrands value)  loadAvailableBrands,required TResult Function( _FollowBrand value)  followBrand,required TResult Function( _UnfollowBrand value)  unfollowBrand,required TResult Function( _UnifiedSearch value)  unifiedSearch,required TResult Function( _LoadSuggestions value)  loadSuggestions,required TResult Function( _DismissSuggestion value)  dismissSuggestion,}){
final _that = this;
switch (_that) {
case _WatchContacts():
return watchContacts(_that);case _ContactsUpdated():
return contactsUpdated(_that);case _WatchContactRequests():
return watchContactRequests(_that);case _RequestsUpdated():
return requestsUpdated(_that);case _SendContactRequest():
return sendContactRequest(_that);case _AcceptContactRequest():
return acceptContactRequest(_that);case _DeclineContactRequest():
return declineContactRequest(_that);case _RemoveContact():
return removeContact(_that);case _BlockContact():
return blockContact(_that);case _UnblockContact():
return unblockContact(_that);case _ToggleFavorite():
return toggleFavorite(_that);case _SearchContacts():
return searchContacts(_that);case _ClearSearch():
return clearSearch(_that);case _ImportPhoneContacts():
return importPhoneContacts(_that);case _ClearImportResults():
return clearImportResults(_that);case _LoadFollowedBrands():
return loadFollowedBrands(_that);case _LoadAvailableBrands():
return loadAvailableBrands(_that);case _FollowBrand():
return followBrand(_that);case _UnfollowBrand():
return unfollowBrand(_that);case _UnifiedSearch():
return unifiedSearch(_that);case _LoadSuggestions():
return loadSuggestions(_that);case _DismissSuggestion():
return dismissSuggestion(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _WatchContacts value)?  watchContacts,TResult? Function( _ContactsUpdated value)?  contactsUpdated,TResult? Function( _WatchContactRequests value)?  watchContactRequests,TResult? Function( _RequestsUpdated value)?  requestsUpdated,TResult? Function( _SendContactRequest value)?  sendContactRequest,TResult? Function( _AcceptContactRequest value)?  acceptContactRequest,TResult? Function( _DeclineContactRequest value)?  declineContactRequest,TResult? Function( _RemoveContact value)?  removeContact,TResult? Function( _BlockContact value)?  blockContact,TResult? Function( _UnblockContact value)?  unblockContact,TResult? Function( _ToggleFavorite value)?  toggleFavorite,TResult? Function( _SearchContacts value)?  searchContacts,TResult? Function( _ClearSearch value)?  clearSearch,TResult? Function( _ImportPhoneContacts value)?  importPhoneContacts,TResult? Function( _ClearImportResults value)?  clearImportResults,TResult? Function( _LoadFollowedBrands value)?  loadFollowedBrands,TResult? Function( _LoadAvailableBrands value)?  loadAvailableBrands,TResult? Function( _FollowBrand value)?  followBrand,TResult? Function( _UnfollowBrand value)?  unfollowBrand,TResult? Function( _UnifiedSearch value)?  unifiedSearch,TResult? Function( _LoadSuggestions value)?  loadSuggestions,TResult? Function( _DismissSuggestion value)?  dismissSuggestion,}){
final _that = this;
switch (_that) {
case _WatchContacts() when watchContacts != null:
return watchContacts(_that);case _ContactsUpdated() when contactsUpdated != null:
return contactsUpdated(_that);case _WatchContactRequests() when watchContactRequests != null:
return watchContactRequests(_that);case _RequestsUpdated() when requestsUpdated != null:
return requestsUpdated(_that);case _SendContactRequest() when sendContactRequest != null:
return sendContactRequest(_that);case _AcceptContactRequest() when acceptContactRequest != null:
return acceptContactRequest(_that);case _DeclineContactRequest() when declineContactRequest != null:
return declineContactRequest(_that);case _RemoveContact() when removeContact != null:
return removeContact(_that);case _BlockContact() when blockContact != null:
return blockContact(_that);case _UnblockContact() when unblockContact != null:
return unblockContact(_that);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _SearchContacts() when searchContacts != null:
return searchContacts(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _ImportPhoneContacts() when importPhoneContacts != null:
return importPhoneContacts(_that);case _ClearImportResults() when clearImportResults != null:
return clearImportResults(_that);case _LoadFollowedBrands() when loadFollowedBrands != null:
return loadFollowedBrands(_that);case _LoadAvailableBrands() when loadAvailableBrands != null:
return loadAvailableBrands(_that);case _FollowBrand() when followBrand != null:
return followBrand(_that);case _UnfollowBrand() when unfollowBrand != null:
return unfollowBrand(_that);case _UnifiedSearch() when unifiedSearch != null:
return unifiedSearch(_that);case _LoadSuggestions() when loadSuggestions != null:
return loadSuggestions(_that);case _DismissSuggestion() when dismissSuggestion != null:
return dismissSuggestion(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  watchContacts,TResult Function( List<Contact> contacts)?  contactsUpdated,TResult Function()?  watchContactRequests,TResult Function( List<Contact> requests)?  requestsUpdated,TResult Function( String contactUserId,  String? source)?  sendContactRequest,TResult Function( String contactId)?  acceptContactRequest,TResult Function( String contactId)?  declineContactRequest,TResult Function( String contactId)?  removeContact,TResult Function( String contactId)?  blockContact,TResult Function( String contactId)?  unblockContact,TResult Function( String contactId,  bool isFavorite)?  toggleFavorite,TResult Function( String query)?  searchContacts,TResult Function()?  clearSearch,TResult Function( List<String> phoneNumbers)?  importPhoneContacts,TResult Function()?  clearImportResults,TResult Function()?  loadFollowedBrands,TResult Function()?  loadAvailableBrands,TResult Function( String clientId)?  followBrand,TResult Function( String clientId)?  unfollowBrand,TResult Function( String query)?  unifiedSearch,TResult Function()?  loadSuggestions,TResult Function( String userId)?  dismissSuggestion,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchContacts() when watchContacts != null:
return watchContacts();case _ContactsUpdated() when contactsUpdated != null:
return contactsUpdated(_that.contacts);case _WatchContactRequests() when watchContactRequests != null:
return watchContactRequests();case _RequestsUpdated() when requestsUpdated != null:
return requestsUpdated(_that.requests);case _SendContactRequest() when sendContactRequest != null:
return sendContactRequest(_that.contactUserId,_that.source);case _AcceptContactRequest() when acceptContactRequest != null:
return acceptContactRequest(_that.contactId);case _DeclineContactRequest() when declineContactRequest != null:
return declineContactRequest(_that.contactId);case _RemoveContact() when removeContact != null:
return removeContact(_that.contactId);case _BlockContact() when blockContact != null:
return blockContact(_that.contactId);case _UnblockContact() when unblockContact != null:
return unblockContact(_that.contactId);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.contactId,_that.isFavorite);case _SearchContacts() when searchContacts != null:
return searchContacts(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _ImportPhoneContacts() when importPhoneContacts != null:
return importPhoneContacts(_that.phoneNumbers);case _ClearImportResults() when clearImportResults != null:
return clearImportResults();case _LoadFollowedBrands() when loadFollowedBrands != null:
return loadFollowedBrands();case _LoadAvailableBrands() when loadAvailableBrands != null:
return loadAvailableBrands();case _FollowBrand() when followBrand != null:
return followBrand(_that.clientId);case _UnfollowBrand() when unfollowBrand != null:
return unfollowBrand(_that.clientId);case _UnifiedSearch() when unifiedSearch != null:
return unifiedSearch(_that.query);case _LoadSuggestions() when loadSuggestions != null:
return loadSuggestions();case _DismissSuggestion() when dismissSuggestion != null:
return dismissSuggestion(_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  watchContacts,required TResult Function( List<Contact> contacts)  contactsUpdated,required TResult Function()  watchContactRequests,required TResult Function( List<Contact> requests)  requestsUpdated,required TResult Function( String contactUserId,  String? source)  sendContactRequest,required TResult Function( String contactId)  acceptContactRequest,required TResult Function( String contactId)  declineContactRequest,required TResult Function( String contactId)  removeContact,required TResult Function( String contactId)  blockContact,required TResult Function( String contactId)  unblockContact,required TResult Function( String contactId,  bool isFavorite)  toggleFavorite,required TResult Function( String query)  searchContacts,required TResult Function()  clearSearch,required TResult Function( List<String> phoneNumbers)  importPhoneContacts,required TResult Function()  clearImportResults,required TResult Function()  loadFollowedBrands,required TResult Function()  loadAvailableBrands,required TResult Function( String clientId)  followBrand,required TResult Function( String clientId)  unfollowBrand,required TResult Function( String query)  unifiedSearch,required TResult Function()  loadSuggestions,required TResult Function( String userId)  dismissSuggestion,}) {final _that = this;
switch (_that) {
case _WatchContacts():
return watchContacts();case _ContactsUpdated():
return contactsUpdated(_that.contacts);case _WatchContactRequests():
return watchContactRequests();case _RequestsUpdated():
return requestsUpdated(_that.requests);case _SendContactRequest():
return sendContactRequest(_that.contactUserId,_that.source);case _AcceptContactRequest():
return acceptContactRequest(_that.contactId);case _DeclineContactRequest():
return declineContactRequest(_that.contactId);case _RemoveContact():
return removeContact(_that.contactId);case _BlockContact():
return blockContact(_that.contactId);case _UnblockContact():
return unblockContact(_that.contactId);case _ToggleFavorite():
return toggleFavorite(_that.contactId,_that.isFavorite);case _SearchContacts():
return searchContacts(_that.query);case _ClearSearch():
return clearSearch();case _ImportPhoneContacts():
return importPhoneContacts(_that.phoneNumbers);case _ClearImportResults():
return clearImportResults();case _LoadFollowedBrands():
return loadFollowedBrands();case _LoadAvailableBrands():
return loadAvailableBrands();case _FollowBrand():
return followBrand(_that.clientId);case _UnfollowBrand():
return unfollowBrand(_that.clientId);case _UnifiedSearch():
return unifiedSearch(_that.query);case _LoadSuggestions():
return loadSuggestions();case _DismissSuggestion():
return dismissSuggestion(_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  watchContacts,TResult? Function( List<Contact> contacts)?  contactsUpdated,TResult? Function()?  watchContactRequests,TResult? Function( List<Contact> requests)?  requestsUpdated,TResult? Function( String contactUserId,  String? source)?  sendContactRequest,TResult? Function( String contactId)?  acceptContactRequest,TResult? Function( String contactId)?  declineContactRequest,TResult? Function( String contactId)?  removeContact,TResult? Function( String contactId)?  blockContact,TResult? Function( String contactId)?  unblockContact,TResult? Function( String contactId,  bool isFavorite)?  toggleFavorite,TResult? Function( String query)?  searchContacts,TResult? Function()?  clearSearch,TResult? Function( List<String> phoneNumbers)?  importPhoneContacts,TResult? Function()?  clearImportResults,TResult? Function()?  loadFollowedBrands,TResult? Function()?  loadAvailableBrands,TResult? Function( String clientId)?  followBrand,TResult? Function( String clientId)?  unfollowBrand,TResult? Function( String query)?  unifiedSearch,TResult? Function()?  loadSuggestions,TResult? Function( String userId)?  dismissSuggestion,}) {final _that = this;
switch (_that) {
case _WatchContacts() when watchContacts != null:
return watchContacts();case _ContactsUpdated() when contactsUpdated != null:
return contactsUpdated(_that.contacts);case _WatchContactRequests() when watchContactRequests != null:
return watchContactRequests();case _RequestsUpdated() when requestsUpdated != null:
return requestsUpdated(_that.requests);case _SendContactRequest() when sendContactRequest != null:
return sendContactRequest(_that.contactUserId,_that.source);case _AcceptContactRequest() when acceptContactRequest != null:
return acceptContactRequest(_that.contactId);case _DeclineContactRequest() when declineContactRequest != null:
return declineContactRequest(_that.contactId);case _RemoveContact() when removeContact != null:
return removeContact(_that.contactId);case _BlockContact() when blockContact != null:
return blockContact(_that.contactId);case _UnblockContact() when unblockContact != null:
return unblockContact(_that.contactId);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.contactId,_that.isFavorite);case _SearchContacts() when searchContacts != null:
return searchContacts(_that.query);case _ClearSearch() when clearSearch != null:
return clearSearch();case _ImportPhoneContacts() when importPhoneContacts != null:
return importPhoneContacts(_that.phoneNumbers);case _ClearImportResults() when clearImportResults != null:
return clearImportResults();case _LoadFollowedBrands() when loadFollowedBrands != null:
return loadFollowedBrands();case _LoadAvailableBrands() when loadAvailableBrands != null:
return loadAvailableBrands();case _FollowBrand() when followBrand != null:
return followBrand(_that.clientId);case _UnfollowBrand() when unfollowBrand != null:
return unfollowBrand(_that.clientId);case _UnifiedSearch() when unifiedSearch != null:
return unifiedSearch(_that.query);case _LoadSuggestions() when loadSuggestions != null:
return loadSuggestions();case _DismissSuggestion() when dismissSuggestion != null:
return dismissSuggestion(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _WatchContacts implements ContactEvent {
  const _WatchContacts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchContacts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.watchContacts()';
}


}




/// @nodoc


class _ContactsUpdated implements ContactEvent {
  const _ContactsUpdated(final  List<Contact> contacts): _contacts = contacts;
  

 final  List<Contact> _contacts;
 List<Contact> get contacts {
  if (_contacts is EqualUnmodifiableListView) return _contacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contacts);
}


/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactsUpdatedCopyWith<_ContactsUpdated> get copyWith => __$ContactsUpdatedCopyWithImpl<_ContactsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactsUpdated&&const DeepCollectionEquality().equals(other._contacts, _contacts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contacts));

@override
String toString() {
  return 'ContactEvent.contactsUpdated(contacts: $contacts)';
}


}

/// @nodoc
abstract mixin class _$ContactsUpdatedCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$ContactsUpdatedCopyWith(_ContactsUpdated value, $Res Function(_ContactsUpdated) _then) = __$ContactsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Contact> contacts
});




}
/// @nodoc
class __$ContactsUpdatedCopyWithImpl<$Res>
    implements _$ContactsUpdatedCopyWith<$Res> {
  __$ContactsUpdatedCopyWithImpl(this._self, this._then);

  final _ContactsUpdated _self;
  final $Res Function(_ContactsUpdated) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contacts = null,}) {
  return _then(_ContactsUpdated(
null == contacts ? _self._contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<Contact>,
  ));
}


}

/// @nodoc


class _WatchContactRequests implements ContactEvent {
  const _WatchContactRequests();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchContactRequests);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.watchContactRequests()';
}


}




/// @nodoc


class _RequestsUpdated implements ContactEvent {
  const _RequestsUpdated(final  List<Contact> requests): _requests = requests;
  

 final  List<Contact> _requests;
 List<Contact> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}


/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestsUpdatedCopyWith<_RequestsUpdated> get copyWith => __$RequestsUpdatedCopyWithImpl<_RequestsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestsUpdated&&const DeepCollectionEquality().equals(other._requests, _requests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requests));

@override
String toString() {
  return 'ContactEvent.requestsUpdated(requests: $requests)';
}


}

/// @nodoc
abstract mixin class _$RequestsUpdatedCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$RequestsUpdatedCopyWith(_RequestsUpdated value, $Res Function(_RequestsUpdated) _then) = __$RequestsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Contact> requests
});




}
/// @nodoc
class __$RequestsUpdatedCopyWithImpl<$Res>
    implements _$RequestsUpdatedCopyWith<$Res> {
  __$RequestsUpdatedCopyWithImpl(this._self, this._then);

  final _RequestsUpdated _self;
  final $Res Function(_RequestsUpdated) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requests = null,}) {
  return _then(_RequestsUpdated(
null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<Contact>,
  ));
}


}

/// @nodoc


class _SendContactRequest implements ContactEvent {
  const _SendContactRequest(this.contactUserId, {this.source});
  

 final  String contactUserId;
 final  String? source;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendContactRequestCopyWith<_SendContactRequest> get copyWith => __$SendContactRequestCopyWithImpl<_SendContactRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendContactRequest&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,contactUserId,source);

@override
String toString() {
  return 'ContactEvent.sendContactRequest(contactUserId: $contactUserId, source: $source)';
}


}

/// @nodoc
abstract mixin class _$SendContactRequestCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$SendContactRequestCopyWith(_SendContactRequest value, $Res Function(_SendContactRequest) _then) = __$SendContactRequestCopyWithImpl;
@useResult
$Res call({
 String contactUserId, String? source
});




}
/// @nodoc
class __$SendContactRequestCopyWithImpl<$Res>
    implements _$SendContactRequestCopyWith<$Res> {
  __$SendContactRequestCopyWithImpl(this._self, this._then);

  final _SendContactRequest _self;
  final $Res Function(_SendContactRequest) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactUserId = null,Object? source = freezed,}) {
  return _then(_SendContactRequest(
null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AcceptContactRequest implements ContactEvent {
  const _AcceptContactRequest(this.contactId);
  

 final  String contactId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptContactRequestCopyWith<_AcceptContactRequest> get copyWith => __$AcceptContactRequestCopyWithImpl<_AcceptContactRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptContactRequest&&(identical(other.contactId, contactId) || other.contactId == contactId));
}


@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'ContactEvent.acceptContactRequest(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$AcceptContactRequestCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$AcceptContactRequestCopyWith(_AcceptContactRequest value, $Res Function(_AcceptContactRequest) _then) = __$AcceptContactRequestCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$AcceptContactRequestCopyWithImpl<$Res>
    implements _$AcceptContactRequestCopyWith<$Res> {
  __$AcceptContactRequestCopyWithImpl(this._self, this._then);

  final _AcceptContactRequest _self;
  final $Res Function(_AcceptContactRequest) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_AcceptContactRequest(
null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeclineContactRequest implements ContactEvent {
  const _DeclineContactRequest(this.contactId);
  

 final  String contactId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineContactRequestCopyWith<_DeclineContactRequest> get copyWith => __$DeclineContactRequestCopyWithImpl<_DeclineContactRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclineContactRequest&&(identical(other.contactId, contactId) || other.contactId == contactId));
}


@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'ContactEvent.declineContactRequest(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$DeclineContactRequestCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$DeclineContactRequestCopyWith(_DeclineContactRequest value, $Res Function(_DeclineContactRequest) _then) = __$DeclineContactRequestCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$DeclineContactRequestCopyWithImpl<$Res>
    implements _$DeclineContactRequestCopyWith<$Res> {
  __$DeclineContactRequestCopyWithImpl(this._self, this._then);

  final _DeclineContactRequest _self;
  final $Res Function(_DeclineContactRequest) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_DeclineContactRequest(
null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveContact implements ContactEvent {
  const _RemoveContact(this.contactId);
  

 final  String contactId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveContactCopyWith<_RemoveContact> get copyWith => __$RemoveContactCopyWithImpl<_RemoveContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveContact&&(identical(other.contactId, contactId) || other.contactId == contactId));
}


@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'ContactEvent.removeContact(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$RemoveContactCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$RemoveContactCopyWith(_RemoveContact value, $Res Function(_RemoveContact) _then) = __$RemoveContactCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$RemoveContactCopyWithImpl<$Res>
    implements _$RemoveContactCopyWith<$Res> {
  __$RemoveContactCopyWithImpl(this._self, this._then);

  final _RemoveContact _self;
  final $Res Function(_RemoveContact) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_RemoveContact(
null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BlockContact implements ContactEvent {
  const _BlockContact(this.contactId);
  

 final  String contactId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockContactCopyWith<_BlockContact> get copyWith => __$BlockContactCopyWithImpl<_BlockContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockContact&&(identical(other.contactId, contactId) || other.contactId == contactId));
}


@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'ContactEvent.blockContact(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$BlockContactCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$BlockContactCopyWith(_BlockContact value, $Res Function(_BlockContact) _then) = __$BlockContactCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$BlockContactCopyWithImpl<$Res>
    implements _$BlockContactCopyWith<$Res> {
  __$BlockContactCopyWithImpl(this._self, this._then);

  final _BlockContact _self;
  final $Res Function(_BlockContact) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_BlockContact(
null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnblockContact implements ContactEvent {
  const _UnblockContact(this.contactId);
  

 final  String contactId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnblockContactCopyWith<_UnblockContact> get copyWith => __$UnblockContactCopyWithImpl<_UnblockContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnblockContact&&(identical(other.contactId, contactId) || other.contactId == contactId));
}


@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'ContactEvent.unblockContact(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$UnblockContactCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$UnblockContactCopyWith(_UnblockContact value, $Res Function(_UnblockContact) _then) = __$UnblockContactCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$UnblockContactCopyWithImpl<$Res>
    implements _$UnblockContactCopyWith<$Res> {
  __$UnblockContactCopyWithImpl(this._self, this._then);

  final _UnblockContact _self;
  final $Res Function(_UnblockContact) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_UnblockContact(
null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleFavorite implements ContactEvent {
  const _ToggleFavorite({required this.contactId, required this.isFavorite});
  

 final  String contactId;
 final  bool isFavorite;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleFavoriteCopyWith<_ToggleFavorite> get copyWith => __$ToggleFavoriteCopyWithImpl<_ToggleFavorite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleFavorite&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,contactId,isFavorite);

@override
String toString() {
  return 'ContactEvent.toggleFavorite(contactId: $contactId, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$ToggleFavoriteCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$ToggleFavoriteCopyWith(_ToggleFavorite value, $Res Function(_ToggleFavorite) _then) = __$ToggleFavoriteCopyWithImpl;
@useResult
$Res call({
 String contactId, bool isFavorite
});




}
/// @nodoc
class __$ToggleFavoriteCopyWithImpl<$Res>
    implements _$ToggleFavoriteCopyWith<$Res> {
  __$ToggleFavoriteCopyWithImpl(this._self, this._then);

  final _ToggleFavorite _self;
  final $Res Function(_ToggleFavorite) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contactId = null,Object? isFavorite = null,}) {
  return _then(_ToggleFavorite(
contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SearchContacts implements ContactEvent {
  const _SearchContacts(this.query);
  

 final  String query;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchContactsCopyWith<_SearchContacts> get copyWith => __$SearchContactsCopyWithImpl<_SearchContacts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchContacts&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ContactEvent.searchContacts(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchContactsCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$SearchContactsCopyWith(_SearchContacts value, $Res Function(_SearchContacts) _then) = __$SearchContactsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchContactsCopyWithImpl<$Res>
    implements _$SearchContactsCopyWith<$Res> {
  __$SearchContactsCopyWithImpl(this._self, this._then);

  final _SearchContacts _self;
  final $Res Function(_SearchContacts) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchContacts(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearSearch implements ContactEvent {
  const _ClearSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.clearSearch()';
}


}




/// @nodoc


class _ImportPhoneContacts implements ContactEvent {
  const _ImportPhoneContacts(final  List<String> phoneNumbers): _phoneNumbers = phoneNumbers;
  

 final  List<String> _phoneNumbers;
 List<String> get phoneNumbers {
  if (_phoneNumbers is EqualUnmodifiableListView) return _phoneNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phoneNumbers);
}


/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportPhoneContactsCopyWith<_ImportPhoneContacts> get copyWith => __$ImportPhoneContactsCopyWithImpl<_ImportPhoneContacts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportPhoneContacts&&const DeepCollectionEquality().equals(other._phoneNumbers, _phoneNumbers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_phoneNumbers));

@override
String toString() {
  return 'ContactEvent.importPhoneContacts(phoneNumbers: $phoneNumbers)';
}


}

/// @nodoc
abstract mixin class _$ImportPhoneContactsCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$ImportPhoneContactsCopyWith(_ImportPhoneContacts value, $Res Function(_ImportPhoneContacts) _then) = __$ImportPhoneContactsCopyWithImpl;
@useResult
$Res call({
 List<String> phoneNumbers
});




}
/// @nodoc
class __$ImportPhoneContactsCopyWithImpl<$Res>
    implements _$ImportPhoneContactsCopyWith<$Res> {
  __$ImportPhoneContactsCopyWithImpl(this._self, this._then);

  final _ImportPhoneContacts _self;
  final $Res Function(_ImportPhoneContacts) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phoneNumbers = null,}) {
  return _then(_ImportPhoneContacts(
null == phoneNumbers ? _self._phoneNumbers : phoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _ClearImportResults implements ContactEvent {
  const _ClearImportResults();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearImportResults);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.clearImportResults()';
}


}




/// @nodoc


class _LoadFollowedBrands implements ContactEvent {
  const _LoadFollowedBrands();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFollowedBrands);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.loadFollowedBrands()';
}


}




/// @nodoc


class _LoadAvailableBrands implements ContactEvent {
  const _LoadAvailableBrands();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAvailableBrands);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.loadAvailableBrands()';
}


}




/// @nodoc


class _FollowBrand implements ContactEvent {
  const _FollowBrand(this.clientId);
  

 final  String clientId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowBrandCopyWith<_FollowBrand> get copyWith => __$FollowBrandCopyWithImpl<_FollowBrand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowBrand&&(identical(other.clientId, clientId) || other.clientId == clientId));
}


@override
int get hashCode => Object.hash(runtimeType,clientId);

@override
String toString() {
  return 'ContactEvent.followBrand(clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class _$FollowBrandCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$FollowBrandCopyWith(_FollowBrand value, $Res Function(_FollowBrand) _then) = __$FollowBrandCopyWithImpl;
@useResult
$Res call({
 String clientId
});




}
/// @nodoc
class __$FollowBrandCopyWithImpl<$Res>
    implements _$FollowBrandCopyWith<$Res> {
  __$FollowBrandCopyWithImpl(this._self, this._then);

  final _FollowBrand _self;
  final $Res Function(_FollowBrand) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clientId = null,}) {
  return _then(_FollowBrand(
null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnfollowBrand implements ContactEvent {
  const _UnfollowBrand(this.clientId);
  

 final  String clientId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnfollowBrandCopyWith<_UnfollowBrand> get copyWith => __$UnfollowBrandCopyWithImpl<_UnfollowBrand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnfollowBrand&&(identical(other.clientId, clientId) || other.clientId == clientId));
}


@override
int get hashCode => Object.hash(runtimeType,clientId);

@override
String toString() {
  return 'ContactEvent.unfollowBrand(clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class _$UnfollowBrandCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$UnfollowBrandCopyWith(_UnfollowBrand value, $Res Function(_UnfollowBrand) _then) = __$UnfollowBrandCopyWithImpl;
@useResult
$Res call({
 String clientId
});




}
/// @nodoc
class __$UnfollowBrandCopyWithImpl<$Res>
    implements _$UnfollowBrandCopyWith<$Res> {
  __$UnfollowBrandCopyWithImpl(this._self, this._then);

  final _UnfollowBrand _self;
  final $Res Function(_UnfollowBrand) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clientId = null,}) {
  return _then(_UnfollowBrand(
null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnifiedSearch implements ContactEvent {
  const _UnifiedSearch(this.query);
  

 final  String query;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedSearchCopyWith<_UnifiedSearch> get copyWith => __$UnifiedSearchCopyWithImpl<_UnifiedSearch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedSearch&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ContactEvent.unifiedSearch(query: $query)';
}


}

/// @nodoc
abstract mixin class _$UnifiedSearchCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$UnifiedSearchCopyWith(_UnifiedSearch value, $Res Function(_UnifiedSearch) _then) = __$UnifiedSearchCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$UnifiedSearchCopyWithImpl<$Res>
    implements _$UnifiedSearchCopyWith<$Res> {
  __$UnifiedSearchCopyWithImpl(this._self, this._then);

  final _UnifiedSearch _self;
  final $Res Function(_UnifiedSearch) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_UnifiedSearch(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadSuggestions implements ContactEvent {
  const _LoadSuggestions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSuggestions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.loadSuggestions()';
}


}




/// @nodoc


class _DismissSuggestion implements ContactEvent {
  const _DismissSuggestion(this.userId);
  

 final  String userId;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DismissSuggestionCopyWith<_DismissSuggestion> get copyWith => __$DismissSuggestionCopyWithImpl<_DismissSuggestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DismissSuggestion&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ContactEvent.dismissSuggestion(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$DismissSuggestionCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$DismissSuggestionCopyWith(_DismissSuggestion value, $Res Function(_DismissSuggestion) _then) = __$DismissSuggestionCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$DismissSuggestionCopyWithImpl<$Res>
    implements _$DismissSuggestionCopyWith<$Res> {
  __$DismissSuggestionCopyWithImpl(this._self, this._then);

  final _DismissSuggestion _self;
  final $Res Function(_DismissSuggestion) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_DismissSuggestion(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ContactState {

 ContactLoadingStatus get status; List<Contact> get contacts; List<Contact> get contactRequests; int get pendingRequestCount; List<Contact> get searchResults; bool get isSearching; String? get actionError;// Phone import state
 bool get isImporting; List<Map<String, dynamic>> get matchedPhoneContacts; List<String> get unmatchedPhoneNumbers;// Brand accounts state
 List<BrandAccount> get followedBrands; List<BrandAccount> get availableBrands; bool get isLoadingBrands;// Unified search state
 List<UserSearchResult> get globalSearchResults; List<BrandAccount> get brandSearchResults;// People You May Know suggestions
 List<ContactSuggestion> get suggestions; bool get isLoadingSuggestions;// Track sent contact request user IDs for UI feedback
 Set<String> get sentContactRequestIds;// Success message for actions (e.g. contact request sent)
 String? get actionSuccess;
/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactStateCopyWith<ContactState> get copyWith => _$ContactStateCopyWithImpl<ContactState>(this as ContactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.contacts, contacts)&&const DeepCollectionEquality().equals(other.contactRequests, contactRequests)&&(identical(other.pendingRequestCount, pendingRequestCount) || other.pendingRequestCount == pendingRequestCount)&&const DeepCollectionEquality().equals(other.searchResults, searchResults)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.isImporting, isImporting) || other.isImporting == isImporting)&&const DeepCollectionEquality().equals(other.matchedPhoneContacts, matchedPhoneContacts)&&const DeepCollectionEquality().equals(other.unmatchedPhoneNumbers, unmatchedPhoneNumbers)&&const DeepCollectionEquality().equals(other.followedBrands, followedBrands)&&const DeepCollectionEquality().equals(other.availableBrands, availableBrands)&&(identical(other.isLoadingBrands, isLoadingBrands) || other.isLoadingBrands == isLoadingBrands)&&const DeepCollectionEquality().equals(other.globalSearchResults, globalSearchResults)&&const DeepCollectionEquality().equals(other.brandSearchResults, brandSearchResults)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.isLoadingSuggestions, isLoadingSuggestions) || other.isLoadingSuggestions == isLoadingSuggestions)&&const DeepCollectionEquality().equals(other.sentContactRequestIds, sentContactRequestIds)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(contacts),const DeepCollectionEquality().hash(contactRequests),pendingRequestCount,const DeepCollectionEquality().hash(searchResults),isSearching,actionError,isImporting,const DeepCollectionEquality().hash(matchedPhoneContacts),const DeepCollectionEquality().hash(unmatchedPhoneNumbers),const DeepCollectionEquality().hash(followedBrands),const DeepCollectionEquality().hash(availableBrands),isLoadingBrands,const DeepCollectionEquality().hash(globalSearchResults),const DeepCollectionEquality().hash(brandSearchResults),const DeepCollectionEquality().hash(suggestions),isLoadingSuggestions,const DeepCollectionEquality().hash(sentContactRequestIds),actionSuccess]);

@override
String toString() {
  return 'ContactState(status: $status, contacts: $contacts, contactRequests: $contactRequests, pendingRequestCount: $pendingRequestCount, searchResults: $searchResults, isSearching: $isSearching, actionError: $actionError, isImporting: $isImporting, matchedPhoneContacts: $matchedPhoneContacts, unmatchedPhoneNumbers: $unmatchedPhoneNumbers, followedBrands: $followedBrands, availableBrands: $availableBrands, isLoadingBrands: $isLoadingBrands, globalSearchResults: $globalSearchResults, brandSearchResults: $brandSearchResults, suggestions: $suggestions, isLoadingSuggestions: $isLoadingSuggestions, sentContactRequestIds: $sentContactRequestIds, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class $ContactStateCopyWith<$Res>  {
  factory $ContactStateCopyWith(ContactState value, $Res Function(ContactState) _then) = _$ContactStateCopyWithImpl;
@useResult
$Res call({
 ContactLoadingStatus status, List<Contact> contacts, List<Contact> contactRequests, int pendingRequestCount, List<Contact> searchResults, bool isSearching, String? actionError, bool isImporting, List<Map<String, dynamic>> matchedPhoneContacts, List<String> unmatchedPhoneNumbers, List<BrandAccount> followedBrands, List<BrandAccount> availableBrands, bool isLoadingBrands, List<UserSearchResult> globalSearchResults, List<BrandAccount> brandSearchResults, List<ContactSuggestion> suggestions, bool isLoadingSuggestions, Set<String> sentContactRequestIds, String? actionSuccess
});




}
/// @nodoc
class _$ContactStateCopyWithImpl<$Res>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._self, this._then);

  final ContactState _self;
  final $Res Function(ContactState) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? contacts = null,Object? contactRequests = null,Object? pendingRequestCount = null,Object? searchResults = null,Object? isSearching = null,Object? actionError = freezed,Object? isImporting = null,Object? matchedPhoneContacts = null,Object? unmatchedPhoneNumbers = null,Object? followedBrands = null,Object? availableBrands = null,Object? isLoadingBrands = null,Object? globalSearchResults = null,Object? brandSearchResults = null,Object? suggestions = null,Object? isLoadingSuggestions = null,Object? sentContactRequestIds = null,Object? actionSuccess = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContactLoadingStatus,contacts: null == contacts ? _self.contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<Contact>,contactRequests: null == contactRequests ? _self.contactRequests : contactRequests // ignore: cast_nullable_to_non_nullable
as List<Contact>,pendingRequestCount: null == pendingRequestCount ? _self.pendingRequestCount : pendingRequestCount // ignore: cast_nullable_to_non_nullable
as int,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<Contact>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,isImporting: null == isImporting ? _self.isImporting : isImporting // ignore: cast_nullable_to_non_nullable
as bool,matchedPhoneContacts: null == matchedPhoneContacts ? _self.matchedPhoneContacts : matchedPhoneContacts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,unmatchedPhoneNumbers: null == unmatchedPhoneNumbers ? _self.unmatchedPhoneNumbers : unmatchedPhoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,followedBrands: null == followedBrands ? _self.followedBrands : followedBrands // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,availableBrands: null == availableBrands ? _self.availableBrands : availableBrands // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,isLoadingBrands: null == isLoadingBrands ? _self.isLoadingBrands : isLoadingBrands // ignore: cast_nullable_to_non_nullable
as bool,globalSearchResults: null == globalSearchResults ? _self.globalSearchResults : globalSearchResults // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,brandSearchResults: null == brandSearchResults ? _self.brandSearchResults : brandSearchResults // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ContactSuggestion>,isLoadingSuggestions: null == isLoadingSuggestions ? _self.isLoadingSuggestions : isLoadingSuggestions // ignore: cast_nullable_to_non_nullable
as bool,sentContactRequestIds: null == sentContactRequestIds ? _self.sentContactRequestIds : sentContactRequestIds // ignore: cast_nullable_to_non_nullable
as Set<String>,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactState value)  $default,){
final _that = this;
switch (_that) {
case _ContactState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactState value)?  $default,){
final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContactLoadingStatus status,  List<Contact> contacts,  List<Contact> contactRequests,  int pendingRequestCount,  List<Contact> searchResults,  bool isSearching,  String? actionError,  bool isImporting,  List<Map<String, dynamic>> matchedPhoneContacts,  List<String> unmatchedPhoneNumbers,  List<BrandAccount> followedBrands,  List<BrandAccount> availableBrands,  bool isLoadingBrands,  List<UserSearchResult> globalSearchResults,  List<BrandAccount> brandSearchResults,  List<ContactSuggestion> suggestions,  bool isLoadingSuggestions,  Set<String> sentContactRequestIds,  String? actionSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that.status,_that.contacts,_that.contactRequests,_that.pendingRequestCount,_that.searchResults,_that.isSearching,_that.actionError,_that.isImporting,_that.matchedPhoneContacts,_that.unmatchedPhoneNumbers,_that.followedBrands,_that.availableBrands,_that.isLoadingBrands,_that.globalSearchResults,_that.brandSearchResults,_that.suggestions,_that.isLoadingSuggestions,_that.sentContactRequestIds,_that.actionSuccess);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContactLoadingStatus status,  List<Contact> contacts,  List<Contact> contactRequests,  int pendingRequestCount,  List<Contact> searchResults,  bool isSearching,  String? actionError,  bool isImporting,  List<Map<String, dynamic>> matchedPhoneContacts,  List<String> unmatchedPhoneNumbers,  List<BrandAccount> followedBrands,  List<BrandAccount> availableBrands,  bool isLoadingBrands,  List<UserSearchResult> globalSearchResults,  List<BrandAccount> brandSearchResults,  List<ContactSuggestion> suggestions,  bool isLoadingSuggestions,  Set<String> sentContactRequestIds,  String? actionSuccess)  $default,) {final _that = this;
switch (_that) {
case _ContactState():
return $default(_that.status,_that.contacts,_that.contactRequests,_that.pendingRequestCount,_that.searchResults,_that.isSearching,_that.actionError,_that.isImporting,_that.matchedPhoneContacts,_that.unmatchedPhoneNumbers,_that.followedBrands,_that.availableBrands,_that.isLoadingBrands,_that.globalSearchResults,_that.brandSearchResults,_that.suggestions,_that.isLoadingSuggestions,_that.sentContactRequestIds,_that.actionSuccess);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContactLoadingStatus status,  List<Contact> contacts,  List<Contact> contactRequests,  int pendingRequestCount,  List<Contact> searchResults,  bool isSearching,  String? actionError,  bool isImporting,  List<Map<String, dynamic>> matchedPhoneContacts,  List<String> unmatchedPhoneNumbers,  List<BrandAccount> followedBrands,  List<BrandAccount> availableBrands,  bool isLoadingBrands,  List<UserSearchResult> globalSearchResults,  List<BrandAccount> brandSearchResults,  List<ContactSuggestion> suggestions,  bool isLoadingSuggestions,  Set<String> sentContactRequestIds,  String? actionSuccess)?  $default,) {final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that.status,_that.contacts,_that.contactRequests,_that.pendingRequestCount,_that.searchResults,_that.isSearching,_that.actionError,_that.isImporting,_that.matchedPhoneContacts,_that.unmatchedPhoneNumbers,_that.followedBrands,_that.availableBrands,_that.isLoadingBrands,_that.globalSearchResults,_that.brandSearchResults,_that.suggestions,_that.isLoadingSuggestions,_that.sentContactRequestIds,_that.actionSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _ContactState implements ContactState {
  const _ContactState({this.status = ContactLoadingStatus.initial, final  List<Contact> contacts = const [], final  List<Contact> contactRequests = const [], this.pendingRequestCount = 0, final  List<Contact> searchResults = const [], this.isSearching = false, this.actionError, this.isImporting = false, final  List<Map<String, dynamic>> matchedPhoneContacts = const [], final  List<String> unmatchedPhoneNumbers = const [], final  List<BrandAccount> followedBrands = const [], final  List<BrandAccount> availableBrands = const [], this.isLoadingBrands = false, final  List<UserSearchResult> globalSearchResults = const [], final  List<BrandAccount> brandSearchResults = const [], final  List<ContactSuggestion> suggestions = const [], this.isLoadingSuggestions = false, final  Set<String> sentContactRequestIds = const {}, this.actionSuccess}): _contacts = contacts,_contactRequests = contactRequests,_searchResults = searchResults,_matchedPhoneContacts = matchedPhoneContacts,_unmatchedPhoneNumbers = unmatchedPhoneNumbers,_followedBrands = followedBrands,_availableBrands = availableBrands,_globalSearchResults = globalSearchResults,_brandSearchResults = brandSearchResults,_suggestions = suggestions,_sentContactRequestIds = sentContactRequestIds;
  

@override@JsonKey() final  ContactLoadingStatus status;
 final  List<Contact> _contacts;
@override@JsonKey() List<Contact> get contacts {
  if (_contacts is EqualUnmodifiableListView) return _contacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contacts);
}

 final  List<Contact> _contactRequests;
@override@JsonKey() List<Contact> get contactRequests {
  if (_contactRequests is EqualUnmodifiableListView) return _contactRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contactRequests);
}

@override@JsonKey() final  int pendingRequestCount;
 final  List<Contact> _searchResults;
@override@JsonKey() List<Contact> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

@override@JsonKey() final  bool isSearching;
@override final  String? actionError;
// Phone import state
@override@JsonKey() final  bool isImporting;
 final  List<Map<String, dynamic>> _matchedPhoneContacts;
@override@JsonKey() List<Map<String, dynamic>> get matchedPhoneContacts {
  if (_matchedPhoneContacts is EqualUnmodifiableListView) return _matchedPhoneContacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedPhoneContacts);
}

 final  List<String> _unmatchedPhoneNumbers;
@override@JsonKey() List<String> get unmatchedPhoneNumbers {
  if (_unmatchedPhoneNumbers is EqualUnmodifiableListView) return _unmatchedPhoneNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unmatchedPhoneNumbers);
}

// Brand accounts state
 final  List<BrandAccount> _followedBrands;
// Brand accounts state
@override@JsonKey() List<BrandAccount> get followedBrands {
  if (_followedBrands is EqualUnmodifiableListView) return _followedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followedBrands);
}

 final  List<BrandAccount> _availableBrands;
@override@JsonKey() List<BrandAccount> get availableBrands {
  if (_availableBrands is EqualUnmodifiableListView) return _availableBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableBrands);
}

@override@JsonKey() final  bool isLoadingBrands;
// Unified search state
 final  List<UserSearchResult> _globalSearchResults;
// Unified search state
@override@JsonKey() List<UserSearchResult> get globalSearchResults {
  if (_globalSearchResults is EqualUnmodifiableListView) return _globalSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalSearchResults);
}

 final  List<BrandAccount> _brandSearchResults;
@override@JsonKey() List<BrandAccount> get brandSearchResults {
  if (_brandSearchResults is EqualUnmodifiableListView) return _brandSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brandSearchResults);
}

// People You May Know suggestions
 final  List<ContactSuggestion> _suggestions;
// People You May Know suggestions
@override@JsonKey() List<ContactSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  bool isLoadingSuggestions;
// Track sent contact request user IDs for UI feedback
 final  Set<String> _sentContactRequestIds;
// Track sent contact request user IDs for UI feedback
@override@JsonKey() Set<String> get sentContactRequestIds {
  if (_sentContactRequestIds is EqualUnmodifiableSetView) return _sentContactRequestIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_sentContactRequestIds);
}

// Success message for actions (e.g. contact request sent)
@override final  String? actionSuccess;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactStateCopyWith<_ContactState> get copyWith => __$ContactStateCopyWithImpl<_ContactState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._contacts, _contacts)&&const DeepCollectionEquality().equals(other._contactRequests, _contactRequests)&&(identical(other.pendingRequestCount, pendingRequestCount) || other.pendingRequestCount == pendingRequestCount)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.isImporting, isImporting) || other.isImporting == isImporting)&&const DeepCollectionEquality().equals(other._matchedPhoneContacts, _matchedPhoneContacts)&&const DeepCollectionEquality().equals(other._unmatchedPhoneNumbers, _unmatchedPhoneNumbers)&&const DeepCollectionEquality().equals(other._followedBrands, _followedBrands)&&const DeepCollectionEquality().equals(other._availableBrands, _availableBrands)&&(identical(other.isLoadingBrands, isLoadingBrands) || other.isLoadingBrands == isLoadingBrands)&&const DeepCollectionEquality().equals(other._globalSearchResults, _globalSearchResults)&&const DeepCollectionEquality().equals(other._brandSearchResults, _brandSearchResults)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.isLoadingSuggestions, isLoadingSuggestions) || other.isLoadingSuggestions == isLoadingSuggestions)&&const DeepCollectionEquality().equals(other._sentContactRequestIds, _sentContactRequestIds)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(_contacts),const DeepCollectionEquality().hash(_contactRequests),pendingRequestCount,const DeepCollectionEquality().hash(_searchResults),isSearching,actionError,isImporting,const DeepCollectionEquality().hash(_matchedPhoneContacts),const DeepCollectionEquality().hash(_unmatchedPhoneNumbers),const DeepCollectionEquality().hash(_followedBrands),const DeepCollectionEquality().hash(_availableBrands),isLoadingBrands,const DeepCollectionEquality().hash(_globalSearchResults),const DeepCollectionEquality().hash(_brandSearchResults),const DeepCollectionEquality().hash(_suggestions),isLoadingSuggestions,const DeepCollectionEquality().hash(_sentContactRequestIds),actionSuccess]);

@override
String toString() {
  return 'ContactState(status: $status, contacts: $contacts, contactRequests: $contactRequests, pendingRequestCount: $pendingRequestCount, searchResults: $searchResults, isSearching: $isSearching, actionError: $actionError, isImporting: $isImporting, matchedPhoneContacts: $matchedPhoneContacts, unmatchedPhoneNumbers: $unmatchedPhoneNumbers, followedBrands: $followedBrands, availableBrands: $availableBrands, isLoadingBrands: $isLoadingBrands, globalSearchResults: $globalSearchResults, brandSearchResults: $brandSearchResults, suggestions: $suggestions, isLoadingSuggestions: $isLoadingSuggestions, sentContactRequestIds: $sentContactRequestIds, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class _$ContactStateCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory _$ContactStateCopyWith(_ContactState value, $Res Function(_ContactState) _then) = __$ContactStateCopyWithImpl;
@override @useResult
$Res call({
 ContactLoadingStatus status, List<Contact> contacts, List<Contact> contactRequests, int pendingRequestCount, List<Contact> searchResults, bool isSearching, String? actionError, bool isImporting, List<Map<String, dynamic>> matchedPhoneContacts, List<String> unmatchedPhoneNumbers, List<BrandAccount> followedBrands, List<BrandAccount> availableBrands, bool isLoadingBrands, List<UserSearchResult> globalSearchResults, List<BrandAccount> brandSearchResults, List<ContactSuggestion> suggestions, bool isLoadingSuggestions, Set<String> sentContactRequestIds, String? actionSuccess
});




}
/// @nodoc
class __$ContactStateCopyWithImpl<$Res>
    implements _$ContactStateCopyWith<$Res> {
  __$ContactStateCopyWithImpl(this._self, this._then);

  final _ContactState _self;
  final $Res Function(_ContactState) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? contacts = null,Object? contactRequests = null,Object? pendingRequestCount = null,Object? searchResults = null,Object? isSearching = null,Object? actionError = freezed,Object? isImporting = null,Object? matchedPhoneContacts = null,Object? unmatchedPhoneNumbers = null,Object? followedBrands = null,Object? availableBrands = null,Object? isLoadingBrands = null,Object? globalSearchResults = null,Object? brandSearchResults = null,Object? suggestions = null,Object? isLoadingSuggestions = null,Object? sentContactRequestIds = null,Object? actionSuccess = freezed,}) {
  return _then(_ContactState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContactLoadingStatus,contacts: null == contacts ? _self._contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<Contact>,contactRequests: null == contactRequests ? _self._contactRequests : contactRequests // ignore: cast_nullable_to_non_nullable
as List<Contact>,pendingRequestCount: null == pendingRequestCount ? _self.pendingRequestCount : pendingRequestCount // ignore: cast_nullable_to_non_nullable
as int,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<Contact>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,isImporting: null == isImporting ? _self.isImporting : isImporting // ignore: cast_nullable_to_non_nullable
as bool,matchedPhoneContacts: null == matchedPhoneContacts ? _self._matchedPhoneContacts : matchedPhoneContacts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,unmatchedPhoneNumbers: null == unmatchedPhoneNumbers ? _self._unmatchedPhoneNumbers : unmatchedPhoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,followedBrands: null == followedBrands ? _self._followedBrands : followedBrands // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,availableBrands: null == availableBrands ? _self._availableBrands : availableBrands // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,isLoadingBrands: null == isLoadingBrands ? _self.isLoadingBrands : isLoadingBrands // ignore: cast_nullable_to_non_nullable
as bool,globalSearchResults: null == globalSearchResults ? _self._globalSearchResults : globalSearchResults // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,brandSearchResults: null == brandSearchResults ? _self._brandSearchResults : brandSearchResults // ignore: cast_nullable_to_non_nullable
as List<BrandAccount>,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ContactSuggestion>,isLoadingSuggestions: null == isLoadingSuggestions ? _self.isLoadingSuggestions : isLoadingSuggestions // ignore: cast_nullable_to_non_nullable
as bool,sentContactRequestIds: null == sentContactRequestIds ? _self._sentContactRequestIds : sentContactRequestIds // ignore: cast_nullable_to_non_nullable
as Set<String>,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
