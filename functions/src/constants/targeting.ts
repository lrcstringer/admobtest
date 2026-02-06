/**
 * Targeting Constants and Validation
 *
 * Shared constants for audience targeting criteria.
 * These are used for validation in Cloud Functions and should be
 * mirrored in lib/domain/constants/targeting_constants.dart for Flutter.
 */

// South African Provinces
export const PROVINCES = [
  "gauteng",
  "western_cape",
  "eastern_cape",
  "kwazulu_natal",
  "free_state",
  "north_west",
  "mpumalanga",
  "limpopo",
  "northern_cape",
] as const;

export type Province = (typeof PROVINCES)[number];

// South African Official Languages
export const LANGUAGES = [
  "en", // English
  "af", // Afrikaans
  "zu", // isiZulu
  "xh", // isiXhosa
  "st", // Sesotho
  "tn", // Setswana
  "nr", // isiNdebele
  "nso", // Sepedi
  "ss", // siSwati
  "ve", // Tshivenda
  "ts", // Xitsonga
] as const;

export type Language = (typeof LANGUAGES)[number];

// Interest Categories
export const INTERESTS = [
  "sports",
  "fashion",
  "tech",
  "food",
  "music",
  "gaming",
  "fitness",
  "travel",
  "beauty",
  "finance",
  "education",
  "entertainment",
  "automotive",
  "health",
  "shopping",
  "parenting",
] as const;

export type Interest = (typeof INTERESTS)[number];

// Genders
export const GENDERS = [
  "male",
  "female",
  "non-binary",
  "prefer_not_to_say",
] as const;

export type Gender = (typeof GENDERS)[number];

// Engagement Levels
export const ENGAGEMENT_LEVELS = ["new", "active", "dormant"] as const;

export type EngagementLevel = (typeof ENGAGEMENT_LEVELS)[number];

// Device Platforms
export const DEVICE_PLATFORMS = ["android", "ios"] as const;

export type DevicePlatform = (typeof DEVICE_PLATFORMS)[number];

// Earning Types
export const EARNING_TYPES = [
  "survey",
  "video",
  "trivia",
  "rating",
  "poll",
] as const;

export type EarningType = (typeof EARNING_TYPES)[number];

// Previous Brand Interaction Options
export const BRAND_INTERACTION_OPTIONS = ["include", "exclude"] as const;

export type BrandInteractionOption = (typeof BRAND_INTERACTION_OPTIONS)[number];

/**
 * Targeting Criteria Interface
 */
export interface TargetingCriteria {
  genders?: Gender[];
  ageMin?: number;
  ageMax?: number;
  provinces?: Province[];
  cities?: string[];
  languages?: Language[];
  interests?: Interest[];
  devicePlatforms?: DevicePlatform[];
  accountAgeMinDays?: number;
  accountAgeMaxDays?: number;
  engagementLevel?: EngagementLevel[];
  previousBrandInteraction?: BrandInteractionOption;
  maxAudience?: number;
}

/**
 * Validation Result
 */
export interface ValidationResult {
  valid: boolean;
  errors: string[];
}

/**
 * Validate targeting criteria object
 * Returns validation result with specific errors
 */
export function validateTargetingCriteria(
  targeting: TargetingCriteria | null | undefined
): ValidationResult {
  const errors: string[] = [];

  if (!targeting) {
    return { valid: true, errors: [] };
  }

  // Validate genders
  if (targeting.genders) {
    if (!Array.isArray(targeting.genders)) {
      errors.push("genders must be an array");
    } else {
      for (const g of targeting.genders) {
        if (!GENDERS.includes(g as Gender)) {
          errors.push(`Invalid gender: ${g}. Valid values: ${GENDERS.join(", ")}`);
        }
      }
    }
  }

  // Validate age range
  if (targeting.ageMin !== undefined && targeting.ageMin !== null) {
    if (typeof targeting.ageMin !== "number" || targeting.ageMin < 0) {
      errors.push("ageMin must be a non-negative number");
    }
  }
  if (targeting.ageMax !== undefined && targeting.ageMax !== null) {
    if (typeof targeting.ageMax !== "number" || targeting.ageMax < 0) {
      errors.push("ageMax must be a non-negative number");
    }
  }
  if (
    targeting.ageMin !== undefined &&
    targeting.ageMax !== undefined &&
    targeting.ageMin > targeting.ageMax
  ) {
    errors.push("ageMin cannot be greater than ageMax");
  }

  // Validate provinces
  if (targeting.provinces) {
    if (!Array.isArray(targeting.provinces)) {
      errors.push("provinces must be an array");
    } else {
      for (const p of targeting.provinces) {
        if (!PROVINCES.includes(p as Province)) {
          errors.push(`Invalid province: ${p}. Valid values: ${PROVINCES.join(", ")}`);
        }
      }
    }
  }

  // Validate cities (just check it's an array of strings)
  if (targeting.cities) {
    if (!Array.isArray(targeting.cities)) {
      errors.push("cities must be an array");
    } else {
      for (const c of targeting.cities) {
        if (typeof c !== "string") {
          errors.push("cities must contain only strings");
          break;
        }
      }
    }
  }

  // Validate languages
  if (targeting.languages) {
    if (!Array.isArray(targeting.languages)) {
      errors.push("languages must be an array");
    } else {
      for (const l of targeting.languages) {
        if (!LANGUAGES.includes(l as Language)) {
          errors.push(`Invalid language: ${l}. Valid values: ${LANGUAGES.join(", ")}`);
        }
      }
    }
  }

  // Validate interests
  if (targeting.interests) {
    if (!Array.isArray(targeting.interests)) {
      errors.push("interests must be an array");
    } else {
      for (const i of targeting.interests) {
        if (!INTERESTS.includes(i as Interest)) {
          errors.push(`Invalid interest: ${i}. Valid values: ${INTERESTS.join(", ")}`);
        }
      }
    }
  }

  // Validate device platforms
  if (targeting.devicePlatforms) {
    if (!Array.isArray(targeting.devicePlatforms)) {
      errors.push("devicePlatforms must be an array");
    } else {
      for (const d of targeting.devicePlatforms) {
        if (!DEVICE_PLATFORMS.includes(d as DevicePlatform)) {
          errors.push(
            `Invalid devicePlatform: ${d}. Valid values: ${DEVICE_PLATFORMS.join(", ")}`
          );
        }
      }
    }
  }

  // Validate account age range
  if (targeting.accountAgeMinDays !== undefined && targeting.accountAgeMinDays !== null) {
    if (
      typeof targeting.accountAgeMinDays !== "number" ||
      targeting.accountAgeMinDays < 0
    ) {
      errors.push("accountAgeMinDays must be a non-negative number");
    }
  }
  if (targeting.accountAgeMaxDays !== undefined && targeting.accountAgeMaxDays !== null) {
    if (
      typeof targeting.accountAgeMaxDays !== "number" ||
      targeting.accountAgeMaxDays < 0
    ) {
      errors.push("accountAgeMaxDays must be a non-negative number");
    }
  }
  if (
    targeting.accountAgeMinDays !== undefined &&
    targeting.accountAgeMaxDays !== undefined &&
    targeting.accountAgeMinDays > targeting.accountAgeMaxDays
  ) {
    errors.push("accountAgeMinDays cannot be greater than accountAgeMaxDays");
  }

  // Validate engagement level
  if (targeting.engagementLevel) {
    if (!Array.isArray(targeting.engagementLevel)) {
      errors.push("engagementLevel must be an array");
    } else {
      for (const e of targeting.engagementLevel) {
        if (!ENGAGEMENT_LEVELS.includes(e as EngagementLevel)) {
          errors.push(
            `Invalid engagementLevel: ${e}. Valid values: ${ENGAGEMENT_LEVELS.join(", ")}`
          );
        }
      }
    }
  }

  // Validate previousBrandInteraction
  if (targeting.previousBrandInteraction !== undefined && targeting.previousBrandInteraction !== null) {
    if (
      !BRAND_INTERACTION_OPTIONS.includes(
        targeting.previousBrandInteraction as BrandInteractionOption
      )
    ) {
      errors.push(
        `Invalid previousBrandInteraction: ${targeting.previousBrandInteraction}. Valid values: ${BRAND_INTERACTION_OPTIONS.join(", ")}`
      );
    }
  }

  // Validate maxAudience
  if (targeting.maxAudience !== undefined && targeting.maxAudience !== null) {
    if (typeof targeting.maxAudience !== "number" || targeting.maxAudience < 1) {
      errors.push("maxAudience must be a positive number");
    }
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}

/**
 * Validate earning type
 */
export function validateEarningType(earningType: string): boolean {
  return EARNING_TYPES.includes(earningType as EarningType);
}

/**
 * Calculate user's engagement level based on account age and recent activity
 */
export function calculateEngagementLevel(
  accountCreatedAt: Date,
  recentCompletedEngagements: number,
  hasEngagementIn30Days: boolean
): EngagementLevel {
  const now = new Date();
  const accountAgeMs = now.getTime() - accountCreatedAt.getTime();
  const accountAgeDays = accountAgeMs / (1000 * 60 * 60 * 24);

  // New: account created < 7 days ago
  if (accountAgeDays < 7) {
    return "new";
  }

  // Active: completed >= 1 engagement in last 7 days
  if (recentCompletedEngagements >= 1) {
    return "active";
  }

  // Dormant: account > 7 days old AND no engagement in last 30 days
  if (accountAgeDays > 7 && !hasEngagementIn30Days) {
    return "dormant";
  }

  // Default to active if has some activity
  return "active";
}

/**
 * Calculate age from date of birth
 */
export function calculateAge(dateOfBirth: Date): number {
  const today = new Date();
  let age = today.getFullYear() - dateOfBirth.getFullYear();
  const monthDiff = today.getMonth() - dateOfBirth.getMonth();

  if (
    monthDiff < 0 ||
    (monthDiff === 0 && today.getDate() < dateOfBirth.getDate())
  ) {
    age--;
  }

  return age;
}
