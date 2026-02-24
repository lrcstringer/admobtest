/// Who can find this user via search
enum Discoverability {
  everyone,
  contactsOnly,
  nobody,
}

/// Who can see this user's phone number
enum PhoneNumberVisibility {
  contactsOnly,
  nobody,
}

/// Who can see this user's profile photo
enum ProfilePhotoVisibility {
  everyone,
  contactsOnly,
}

/// Who can see this user's last seen / online status
enum LastSeenVisibility {
  everyone,
  contactsOnly,
  nobody,
}

/// Who can add this user to groups/communities
enum GroupAddPermission {
  everyone,
  contactsOnly,
}

/// Whether brands can message this user
enum BrandMessaging {
  allowAll,
  optedInOnly,
  none,
}
