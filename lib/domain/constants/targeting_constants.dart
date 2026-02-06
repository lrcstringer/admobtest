/// Targeting constants for audience filtering
/// Mirrored from functions/src/constants/targeting.ts
class TargetingConstants {
  TargetingConstants._();

  /// South African Provinces
  static const provinces = [
    'gauteng',
    'western_cape',
    'eastern_cape',
    'kwazulu_natal',
    'free_state',
    'north_west',
    'mpumalanga',
    'limpopo',
    'northern_cape',
  ];

  /// Province display labels
  static const provinceLabels = {
    'gauteng': 'Gauteng',
    'western_cape': 'Western Cape',
    'eastern_cape': 'Eastern Cape',
    'kwazulu_natal': 'KwaZulu-Natal',
    'free_state': 'Free State',
    'north_west': 'North West',
    'mpumalanga': 'Mpumalanga',
    'limpopo': 'Limpopo',
    'northern_cape': 'Northern Cape',
  };

  /// South African Official Languages
  static const languages = [
    'en', // English
    'af', // Afrikaans
    'zu', // isiZulu
    'xh', // isiXhosa
    'st', // Sesotho
    'tn', // Setswana
    'nr', // isiNdebele
    'nso', // Sepedi
    'ss', // siSwati
    've', // Tshivenda
    'ts', // Xitsonga
  ];

  /// Language display labels
  static const languageLabels = {
    'en': 'English',
    'af': 'Afrikaans',
    'zu': 'isiZulu',
    'xh': 'isiXhosa',
    'st': 'Sesotho',
    'tn': 'Setswana',
    'nr': 'isiNdebele',
    'nso': 'Sepedi',
    'ss': 'siSwati',
    've': 'Tshivenda',
    'ts': 'Xitsonga',
  };

  /// Interest Categories
  static const interests = [
    'sports',
    'fashion',
    'tech',
    'food',
    'music',
    'gaming',
    'fitness',
    'travel',
    'beauty',
    'finance',
    'education',
    'entertainment',
    'automotive',
    'health',
    'shopping',
    'parenting',
  ];

  /// Interest display labels
  static const interestLabels = {
    'sports': 'Sports',
    'fashion': 'Fashion',
    'tech': 'Technology',
    'food': 'Food & Dining',
    'music': 'Music',
    'gaming': 'Gaming',
    'fitness': 'Fitness',
    'travel': 'Travel',
    'beauty': 'Beauty',
    'finance': 'Finance',
    'education': 'Education',
    'entertainment': 'Entertainment',
    'automotive': 'Automotive',
    'health': 'Health',
    'shopping': 'Shopping',
    'parenting': 'Parenting',
  };

  /// Genders
  static const genders = [
    'male',
    'female',
    'non-binary',
    'prefer_not_to_say',
  ];

  /// Gender display labels
  static const genderLabels = {
    'male': 'Male',
    'female': 'Female',
    'non-binary': 'Non-binary',
    'prefer_not_to_say': 'Prefer not to say',
  };

  /// Engagement Levels
  static const engagementLevels = [
    'new',
    'active',
    'dormant',
  ];

  /// Engagement level display labels
  static const engagementLevelLabels = {
    'new': 'New Users (< 7 days)',
    'active': 'Active Users',
    'dormant': 'Dormant Users',
  };

  /// Earning Types
  static const earningTypes = [
    'survey',
    'video',
    'trivia',
    'rating',
    'poll',
  ];

  /// Earning type display labels
  static const earningTypeLabels = {
    'survey': 'Survey',
    'video': 'Video',
    'trivia': 'Trivia',
    'rating': 'Rating',
    'poll': 'Poll',
  };

  /// Device Platforms
  static const devicePlatforms = [
    'android',
    'ios',
  ];

  /// Device platform display labels
  static const devicePlatformLabels = {
    'android': 'Android',
    'ios': 'iOS',
  };

  /// Previous Brand Interaction Options
  static const brandInteractionOptions = [
    'include',
    'exclude',
  ];

  /// Brand interaction display labels
  static const brandInteractionLabels = {
    'include': 'Returning users only',
    'exclude': 'New users only',
  };
}
