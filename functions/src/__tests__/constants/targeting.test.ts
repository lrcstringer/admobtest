/**
 * Targeting Validation Unit Tests
 *
 * Tests for targeting criteria validation, earning type validation,
 * engagement level calculation, and age calculation.
 */

import {
  PROVINCES,
  LANGUAGES,
  INTERESTS,
  GENDERS,
  ENGAGEMENT_LEVELS,
  DEVICE_PLATFORMS,
  EARNING_TYPES,
  BRAND_INTERACTION_OPTIONS,
  TargetingCriteria,
  validateTargetingCriteria,
  validateEarningType,
  calculateEngagementLevel,
  calculateAge,
} from "../../constants/targeting";

describe("Targeting Validation", () => {
  // ============================================================================
  // Constants Verification
  // ============================================================================
  describe("Constants", () => {
    it("should have all 9 South African provinces", () => {
      expect(PROVINCES).toHaveLength(9);
      expect(PROVINCES).toContain("gauteng");
      expect(PROVINCES).toContain("western_cape");
      expect(PROVINCES).toContain("eastern_cape");
      expect(PROVINCES).toContain("kwazulu_natal");
      expect(PROVINCES).toContain("free_state");
      expect(PROVINCES).toContain("north_west");
      expect(PROVINCES).toContain("mpumalanga");
      expect(PROVINCES).toContain("limpopo");
      expect(PROVINCES).toContain("northern_cape");
    });

    it("should have all 11 South African official languages", () => {
      expect(LANGUAGES).toHaveLength(11);
      expect(LANGUAGES).toContain("en");
      expect(LANGUAGES).toContain("af");
      expect(LANGUAGES).toContain("zu");
    });

    it("should have interest categories", () => {
      expect(INTERESTS.length).toBeGreaterThan(0);
      expect(INTERESTS).toContain("sports");
      expect(INTERESTS).toContain("tech");
      expect(INTERESTS).toContain("music");
    });

    it("should have gender options", () => {
      expect(GENDERS).toContain("male");
      expect(GENDERS).toContain("female");
      expect(GENDERS).toContain("non-binary");
      expect(GENDERS).toContain("prefer_not_to_say");
    });

    it("should have engagement levels", () => {
      expect(ENGAGEMENT_LEVELS).toEqual(["new", "active", "dormant"]);
    });

    it("should have device platforms", () => {
      expect(DEVICE_PLATFORMS).toEqual(["android", "ios"]);
    });

    it("should have earning types", () => {
      expect(EARNING_TYPES).toContain("video");
      expect(EARNING_TYPES).toContain("image");
      expect(EARNING_TYPES).toContain("survey");
      expect(EARNING_TYPES).toContain("poll");
      expect(EARNING_TYPES).toContain("adVideo");
      expect(EARNING_TYPES).toContain("upload");
      expect(EARNING_TYPES).toHaveLength(6);
    });

    it("should have brand interaction options", () => {
      expect(BRAND_INTERACTION_OPTIONS).toEqual(["include", "exclude"]);
    });
  });

  // ============================================================================
  // validateTargetingCriteria Tests
  // ============================================================================
  describe("validateTargetingCriteria", () => {
    describe("null/undefined handling", () => {
      it("should return valid for null targeting", () => {
        const result = validateTargetingCriteria(null);
        expect(result.valid).toBe(true);
        expect(result.errors).toEqual([]);
      });

      it("should return valid for undefined targeting", () => {
        const result = validateTargetingCriteria(undefined);
        expect(result.valid).toBe(true);
        expect(result.errors).toEqual([]);
      });

      it("should return valid for empty targeting object", () => {
        const result = validateTargetingCriteria({});
        expect(result.valid).toBe(true);
        expect(result.errors).toEqual([]);
      });
    });

    describe("gender validation", () => {
      it("should accept valid genders", () => {
        const result = validateTargetingCriteria({
          genders: ["male", "female"],
        });
        expect(result.valid).toBe(true);
      });

      it("should accept all valid gender values", () => {
        const result = validateTargetingCriteria({
          genders: ["male", "female", "non-binary", "prefer_not_to_say"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid genders", () => {
        const result = validateTargetingCriteria({
          genders: ["male", "invalid_gender"] as TargetingCriteria["genders"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid gender: invalid_gender");
      });

      it("should reject non-array genders", () => {
        const result = validateTargetingCriteria({
          genders: "male" as unknown as TargetingCriteria["genders"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("genders must be an array");
      });
    });

    describe("age range validation", () => {
      it("should accept valid age range", () => {
        const result = validateTargetingCriteria({
          ageMin: 18,
          ageMax: 65,
        });
        expect(result.valid).toBe(true);
      });

      it("should accept only ageMin", () => {
        const result = validateTargetingCriteria({
          ageMin: 21,
        });
        expect(result.valid).toBe(true);
      });

      it("should accept only ageMax", () => {
        const result = validateTargetingCriteria({
          ageMax: 45,
        });
        expect(result.valid).toBe(true);
      });

      it("should reject negative ageMin", () => {
        const result = validateTargetingCriteria({
          ageMin: -5,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("ageMin must be a non-negative number");
      });

      it("should reject negative ageMax", () => {
        const result = validateTargetingCriteria({
          ageMax: -10,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("ageMax must be a non-negative number");
      });

      it("should reject ageMin > ageMax", () => {
        const result = validateTargetingCriteria({
          ageMin: 50,
          ageMax: 30,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("ageMin cannot be greater than ageMax");
      });

      it("should accept equal ageMin and ageMax", () => {
        const result = validateTargetingCriteria({
          ageMin: 25,
          ageMax: 25,
        });
        expect(result.valid).toBe(true);
      });

      it("should reject non-number ageMin", () => {
        const result = validateTargetingCriteria({
          ageMin: "18" as unknown as number,
        });
        expect(result.valid).toBe(false);
      });
    });

    describe("province validation", () => {
      it("should accept valid provinces", () => {
        const result = validateTargetingCriteria({
          provinces: ["gauteng", "western_cape"],
        });
        expect(result.valid).toBe(true);
      });

      it("should accept all valid provinces", () => {
        const result = validateTargetingCriteria({
          provinces: [...PROVINCES],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid provinces", () => {
        const result = validateTargetingCriteria({
          provinces: ["gauteng", "invalid_province"] as unknown as TargetingCriteria["provinces"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid province: invalid_province");
      });

      it("should reject non-array provinces", () => {
        const result = validateTargetingCriteria({
          provinces: "gauteng" as unknown as TargetingCriteria["provinces"],
        });
        expect(result.valid).toBe(false);
      });
    });

    describe("city validation", () => {
      it("should accept valid city array", () => {
        const result = validateTargetingCriteria({
          cities: ["Johannesburg", "Cape Town", "Durban"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject non-array cities", () => {
        const result = validateTargetingCriteria({
          cities: "Johannesburg" as unknown as string[],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("cities must be an array");
      });

      it("should reject non-string city values", () => {
        const result = validateTargetingCriteria({
          cities: ["Johannesburg", 123 as unknown as string],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("cities must contain only strings");
      });
    });

    describe("language validation", () => {
      it("should accept valid languages", () => {
        const result = validateTargetingCriteria({
          languages: ["en", "zu", "af"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid languages", () => {
        const result = validateTargetingCriteria({
          languages: ["en", "fr"] as unknown as TargetingCriteria["languages"], // French not in SA official languages
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid language: fr");
      });
    });

    describe("interest validation", () => {
      it("should accept valid interests", () => {
        const result = validateTargetingCriteria({
          interests: ["sports", "tech", "music"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid interests", () => {
        const result = validateTargetingCriteria({
          interests: ["sports", "invalid_interest"] as unknown as TargetingCriteria["interests"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid interest: invalid_interest");
      });
    });

    describe("device platform validation", () => {
      it("should accept valid device platforms", () => {
        const result = validateTargetingCriteria({
          devicePlatforms: ["android", "ios"],
        });
        expect(result.valid).toBe(true);
      });

      it("should accept single platform", () => {
        const result = validateTargetingCriteria({
          devicePlatforms: ["android"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid platforms", () => {
        const result = validateTargetingCriteria({
          devicePlatforms: ["android", "windows"] as unknown as TargetingCriteria["devicePlatforms"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid devicePlatform: windows");
      });
    });

    describe("account age validation", () => {
      it("should accept valid account age range", () => {
        const result = validateTargetingCriteria({
          accountAgeMinDays: 7,
          accountAgeMaxDays: 365,
        });
        expect(result.valid).toBe(true);
      });

      it("should reject negative accountAgeMinDays", () => {
        const result = validateTargetingCriteria({
          accountAgeMinDays: -1,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("accountAgeMinDays must be a non-negative number");
      });

      it("should reject accountAgeMinDays > accountAgeMaxDays", () => {
        const result = validateTargetingCriteria({
          accountAgeMinDays: 100,
          accountAgeMaxDays: 50,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain(
          "accountAgeMinDays cannot be greater than accountAgeMaxDays"
        );
      });
    });

    describe("engagement level validation", () => {
      it("should accept valid engagement levels", () => {
        const result = validateTargetingCriteria({
          engagementLevel: ["new", "active"],
        });
        expect(result.valid).toBe(true);
      });

      it("should accept all engagement levels", () => {
        const result = validateTargetingCriteria({
          engagementLevel: ["new", "active", "dormant"],
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid engagement levels", () => {
        const result = validateTargetingCriteria({
          engagementLevel: ["active", "super_active"] as unknown as TargetingCriteria["engagementLevel"],
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid engagementLevel: super_active");
      });
    });

    describe("previousBrandInteraction validation", () => {
      it("should accept include", () => {
        const result = validateTargetingCriteria({
          previousBrandInteraction: "include",
        });
        expect(result.valid).toBe(true);
      });

      it("should accept exclude", () => {
        const result = validateTargetingCriteria({
          previousBrandInteraction: "exclude",
        });
        expect(result.valid).toBe(true);
      });

      it("should reject invalid values", () => {
        const result = validateTargetingCriteria({
          previousBrandInteraction: "maybe" as "include" | "exclude",
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("Invalid previousBrandInteraction: maybe");
      });
    });

    describe("maxAudience validation", () => {
      it("should accept positive maxAudience", () => {
        const result = validateTargetingCriteria({
          maxAudience: 1000,
        });
        expect(result.valid).toBe(true);
      });

      it("should accept maxAudience of 1", () => {
        const result = validateTargetingCriteria({
          maxAudience: 1,
        });
        expect(result.valid).toBe(true);
      });

      it("should reject zero maxAudience", () => {
        const result = validateTargetingCriteria({
          maxAudience: 0,
        });
        expect(result.valid).toBe(false);
        expect(result.errors[0]).toContain("maxAudience must be a positive number");
      });

      it("should reject negative maxAudience", () => {
        const result = validateTargetingCriteria({
          maxAudience: -100,
        });
        expect(result.valid).toBe(false);
      });
    });

    describe("multiple errors", () => {
      it("should collect all validation errors", () => {
        const result = validateTargetingCriteria({
          genders: ["invalid_gender"] as unknown as TargetingCriteria["genders"],
          ageMin: -5,
          provinces: ["invalid_province"] as unknown as TargetingCriteria["provinces"],
          languages: ["invalid_lang"] as unknown as TargetingCriteria["languages"],
        });

        expect(result.valid).toBe(false);
        expect(result.errors.length).toBeGreaterThanOrEqual(4);
      });
    });

    describe("complete valid targeting", () => {
      it("should accept fully specified valid targeting", () => {
        const targeting: TargetingCriteria = {
          genders: ["male", "female"],
          ageMin: 18,
          ageMax: 45,
          provinces: ["gauteng", "western_cape"],
          cities: ["Johannesburg", "Cape Town"],
          languages: ["en", "zu"],
          interests: ["sports", "tech"],
          devicePlatforms: ["android", "ios"],
          accountAgeMinDays: 7,
          accountAgeMaxDays: 365,
          engagementLevel: ["active"],
          previousBrandInteraction: "exclude",
          maxAudience: 10000,
        };

        const result = validateTargetingCriteria(targeting);
        expect(result.valid).toBe(true);
        expect(result.errors).toEqual([]);
      });
    });
  });

  // ============================================================================
  // validateEarningType Tests
  // ============================================================================
  describe("validateEarningType", () => {
    it("should return true for survey", () => {
      expect(validateEarningType("survey")).toBe(true);
    });

    it("should return true for video", () => {
      expect(validateEarningType("video")).toBe(true);
    });

    it("should return true for image", () => {
      expect(validateEarningType("image")).toBe(true);
    });

    it("should return false for removed type trivia", () => {
      expect(validateEarningType("trivia")).toBe(false);
    });

    it("should return false for removed type rating", () => {
      expect(validateEarningType("rating")).toBe(false);
    });

    it("should return true for poll", () => {
      expect(validateEarningType("poll")).toBe(true);
    });

    it("should return true for adVideo (AdMob rewarded video)", () => {
      expect(validateEarningType("adVideo")).toBe(true);
    });

    it("should return true for upload (user-generated content)", () => {
      expect(validateEarningType("upload")).toBe(true);
    });

    it("should return false for invalid type", () => {
      expect(validateEarningType("invalid")).toBe(false);
    });

    it("should return false for empty string", () => {
      expect(validateEarningType("")).toBe(false);
    });

    it("should be case-sensitive", () => {
      expect(validateEarningType("Survey")).toBe(false);
      expect(validateEarningType("VIDEO")).toBe(false);
    });
  });

  // ============================================================================
  // calculateEngagementLevel Tests
  // ============================================================================
  describe("calculateEngagementLevel", () => {
    // Helper to create dates relative to now
    const daysAgo = (days: number): Date => {
      const date = new Date();
      date.setDate(date.getDate() - days);
      return date;
    };

    describe("new user classification", () => {
      it("should return new for account created today", () => {
        const result = calculateEngagementLevel(new Date(), 0, false);
        expect(result).toBe("new");
      });

      it("should return new for account created 3 days ago", () => {
        const result = calculateEngagementLevel(daysAgo(3), 0, false);
        expect(result).toBe("new");
      });

      it("should return new for account created 6 days ago", () => {
        const result = calculateEngagementLevel(daysAgo(6), 0, false);
        expect(result).toBe("new");
      });

      it("should NOT return new for account created exactly 7 days ago", () => {
        const result = calculateEngagementLevel(daysAgo(7), 0, false);
        expect(result).not.toBe("new");
      });
    });

    describe("active user classification", () => {
      it("should return active for user with recent engagement", () => {
        const result = calculateEngagementLevel(daysAgo(30), 1, true);
        expect(result).toBe("active");
      });

      it("should return active for user with multiple recent engagements", () => {
        const result = calculateEngagementLevel(daysAgo(60), 5, true);
        expect(result).toBe("active");
      });

      it("should prioritize new over active for new accounts with engagements", () => {
        // New user (< 7 days) should still be classified as new
        const result = calculateEngagementLevel(daysAgo(3), 2, true);
        expect(result).toBe("new");
      });
    });

    describe("dormant user classification", () => {
      it("should return dormant for old account with no recent activity", () => {
        const result = calculateEngagementLevel(daysAgo(90), 0, false);
        expect(result).toBe("dormant");
      });

      it("should return dormant for 8-day old account with no activity", () => {
        const result = calculateEngagementLevel(daysAgo(8), 0, false);
        expect(result).toBe("dormant");
      });

      it("should return active for old account with 30-day activity", () => {
        // Has engagement in 30 days but not in 7 days (0 recentCompletedEngagements)
        const result = calculateEngagementLevel(daysAgo(60), 0, true);
        expect(result).toBe("active");
      });
    });

    describe("edge cases", () => {
      it("should handle account created in the future gracefully", () => {
        const futureDate = new Date();
        futureDate.setDate(futureDate.getDate() + 1);
        const result = calculateEngagementLevel(futureDate, 0, false);
        expect(result).toBe("new"); // Treated as new since negative days < 7
      });
    });
  });

  // ============================================================================
  // calculateAge Tests
  // ============================================================================
  describe("calculateAge", () => {
    // Helper to create DOB for specific age
    const createDOBForAge = (targetAge: number, beforeBirthday = false): Date => {
      const today = new Date();
      const dob = new Date(
        today.getFullYear() - targetAge,
        today.getMonth(),
        today.getDate()
      );
      if (beforeBirthday) {
        // Birthday hasn't happened yet this year
        dob.setMonth(dob.getMonth() + 1);
      }
      return dob;
    };

    it("should calculate correct age for birthday today", () => {
      const dob = createDOBForAge(25);
      expect(calculateAge(dob)).toBe(25);
    });

    it("should calculate correct age before birthday this year", () => {
      const dob = createDOBForAge(25, true);
      expect(calculateAge(dob)).toBe(24);
    });

    it("should calculate age for very young person", () => {
      const today = new Date();
      const dob = new Date(today.getFullYear(), today.getMonth() - 6, today.getDate());
      expect(calculateAge(dob)).toBe(0);
    });

    it("should calculate age for elderly person", () => {
      const dob = new Date(1940, 0, 15);
      const age = calculateAge(dob);
      expect(age).toBeGreaterThan(80);
    });

    it("should handle birth date at end of month", () => {
      // Born on Jan 31, checking on Feb 28
      const dob = new Date(1990, 0, 31);
      const age = calculateAge(dob);
      const expectedAge = new Date().getFullYear() - 1990;
      // Could be expectedAge or expectedAge - 1 depending on current date
      expect(age).toBeGreaterThanOrEqual(expectedAge - 1);
      expect(age).toBeLessThanOrEqual(expectedAge);
    });

    it("should handle leap year birthdays", () => {
      // Born on Feb 29
      const dob = new Date(2000, 1, 29);
      const age = calculateAge(dob);
      const expectedAge = new Date().getFullYear() - 2000;
      expect(age).toBeGreaterThanOrEqual(expectedAge - 1);
      expect(age).toBeLessThanOrEqual(expectedAge);
    });

    it("should return negative age for future DOB", () => {
      const futureDate = new Date();
      futureDate.setFullYear(futureDate.getFullYear() + 5);
      const age = calculateAge(futureDate);
      expect(age).toBeLessThan(0);
    });
  });
});
