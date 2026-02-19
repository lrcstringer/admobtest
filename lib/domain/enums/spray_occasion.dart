/// Occasion types for a community token spray celebration.
enum SprayOccasion {
  newJob,
  birthday,
  graduation,
  newBaby,
  wedding,
  achievement,
  custom;

  String get displayName {
    switch (this) {
      case SprayOccasion.newJob:
        return 'New Job';
      case SprayOccasion.birthday:
        return 'Birthday';
      case SprayOccasion.graduation:
        return 'Graduation';
      case SprayOccasion.newBaby:
        return 'New Baby';
      case SprayOccasion.wedding:
        return 'Wedding';
      case SprayOccasion.achievement:
        return 'Achievement';
      case SprayOccasion.custom:
        return 'Custom';
    }
  }
}
