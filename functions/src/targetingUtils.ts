/**
 * Shared Targeting Utilities
 *
 * Extracted from getEligibleThreads so that getEligibleInbox and
 * earnNotifications can reuse the same eligibility logic.
 */

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { TargetingCriteria, calculateAge, calculateEngagementLevel } from "./constants/targeting";

const db = admin.firestore();

const DAILY_EARN_CAP = 30;

/**
 * User profile attributes needed for targeting evaluation
 */
export interface UserTargetingProfile {
  gender: string | null;
  age: number | null;
  province: string | null;
  city: string | null;
  languages: string[];
  interests: string[];
  devicePlatform: string | null;
  accountAgeDays: number;
  engagementLevel: string;
  interactedClientIds: string[];
}

/**
 * Evaluate whether a user matches a set of targeting criteria.
 *
 * All criteria use AND logic (every filter must pass).
 * Array-type filters (languages, interests) use ANY-match within
 * the array, so the user needs at least one overlap.
 *
 * NOTE: The `maxAudience` check compares against a thread/opportunity's
 * `completedUniqueUsers` count and is NOT user-specific, so it must
 * be checked separately by the caller.
 *
 * @returns true if the user is eligible (passes all filters)
 */
export function isUserEligibleForTargeting(
  user: UserTargetingProfile,
  targeting: TargetingCriteria | null | undefined,
  /** Optional: pass thread's completedUniqueUsers for maxAudience check */
  completedUniqueUsers?: number
): boolean {
  // No targeting = eligible for everyone
  if (!targeting) return true;

  // Gender filter
  if (targeting.genders && targeting.genders.length > 0) {
    if (!user.gender || !targeting.genders.includes(user.gender as never)) {
      return false;
    }
  }

  // Age filter (min)
  if (targeting.ageMin !== undefined && targeting.ageMin !== null) {
    if (user.age === null || user.age < targeting.ageMin) {
      return false;
    }
  }

  // Age filter (max)
  if (targeting.ageMax !== undefined && targeting.ageMax !== null) {
    if (user.age === null || user.age > targeting.ageMax) {
      return false;
    }
  }

  // Province filter
  if (targeting.provinces && targeting.provinces.length > 0) {
    if (
      !user.province ||
      !targeting.provinces.includes(user.province.toLowerCase() as never)
    ) {
      return false;
    }
  }

  // City filter
  if (targeting.cities && targeting.cities.length > 0) {
    if (
      !user.city ||
      !targeting.cities
        .map((c) => c.toLowerCase())
        .includes(user.city.toLowerCase())
    ) {
      return false;
    }
  }

  // Language filter (ANY match)
  if (targeting.languages && targeting.languages.length > 0) {
    const hasMatchingLanguage = user.languages.some((l) =>
      targeting.languages!.includes(l as never)
    );
    if (!hasMatchingLanguage) {
      return false;
    }
  }

  // Interest filter (ANY match)
  if (targeting.interests && targeting.interests.length > 0) {
    const hasMatchingInterest = user.interests.some((i) =>
      targeting.interests!.includes(i as never)
    );
    if (!hasMatchingInterest) {
      return false;
    }
  }

  // Device platform filter
  if (targeting.devicePlatforms && targeting.devicePlatforms.length > 0) {
    if (
      !user.devicePlatform ||
      !targeting.devicePlatforms.includes(user.devicePlatform as never)
    ) {
      return false;
    }
  }

  // Account age filter (min)
  if (
    targeting.accountAgeMinDays !== undefined &&
    targeting.accountAgeMinDays !== null
  ) {
    if (user.accountAgeDays < targeting.accountAgeMinDays) {
      return false;
    }
  }

  // Account age filter (max)
  if (
    targeting.accountAgeMaxDays !== undefined &&
    targeting.accountAgeMaxDays !== null
  ) {
    if (user.accountAgeDays > targeting.accountAgeMaxDays) {
      return false;
    }
  }

  // Engagement level filter
  if (targeting.engagementLevel && targeting.engagementLevel.length > 0) {
    if (!targeting.engagementLevel.includes(user.engagementLevel as never)) {
      return false;
    }
  }

  // Previous brand interaction filter — requires the caller to set
  // interactedClientIds on the user profile AND the thread's clientId
  // to be considered. This is checked per-thread by the caller when
  // iterating threads, so we skip it here if no clientId context is
  // available. Callers that need this should check it themselves.
  // (Kept here for notification filtering where we pass the relevant clientId.)

  // Max audience filter
  if (
    targeting.maxAudience !== undefined &&
    targeting.maxAudience !== null &&
    completedUniqueUsers !== undefined
  ) {
    if (completedUniqueUsers >= targeting.maxAudience) {
      return false;
    }
  }

  return true;
}

/**
 * Check previous brand interaction targeting for a specific thread's client.
 *
 * Separated from `isUserEligibleForTargeting` because it requires
 * knowing the thread's `clientId`, which varies per iteration.
 */
export function checkBrandInteraction(
  targeting: TargetingCriteria | null | undefined,
  userInteractedClientIds: string[],
  threadClientId: string
): boolean {
  if (!targeting?.previousBrandInteraction) return true;

  const hasInteracted = userInteractedClientIds.includes(threadClientId);

  if (targeting.previousBrandInteraction === "include" && !hasInteracted) {
    return false;
  }
  if (targeting.previousBrandInteraction === "exclude" && hasInteracted) {
    return false;
  }

  return true;
}

/**
 * Result from building the full user targeting context
 */
export interface UserTargetingContext {
  userId: string;
  profile: UserTargetingProfile;
  dailyCompletions: number;
  dailyEarnCap: number;
  dailyLimitReached: boolean;
}

/**
 * Build user targeting context from Firestore user doc + engagement stats.
 * Shared between getEligibleThreads, getEligibleInbox, etc.
 */
export async function buildUserTargetingContext(
  context: functions.https.CallableContext
): Promise<UserTargetingContext> {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;

  // 1. Get user profile
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) {
    throw new functions.https.HttpsError("not-found", "User profile not found");
  }

  const userData = userDoc.data()!;
  const userProfile = userData.profile || {};

  const userGender = userProfile.gender || userData.gender || null;
  const userDateOfBirth =
    userProfile.dateOfBirth?.toDate?.() ||
    userData.dateOfBirth?.toDate?.() ||
    null;
  const userAge = userDateOfBirth ? calculateAge(userDateOfBirth) : null;
  const userProvince = userProfile.province || userData.province || null;
  const userCity = userProfile.city || userData.city || null;
  const userLanguages: string[] = userProfile.languages || userData.languages || [];
  const userInterests: string[] = userProfile.interests || userData.interests || [];
  const userInteractedClientIds: string[] = userData.interactedClientIds || [];

  const userCreatedAt = userData.createdAt?.toDate?.() || new Date();
  const accountAgeDays = Math.floor(
    (Date.now() - userCreatedAt.getTime()) / (1000 * 60 * 60 * 24)
  );

  // Device platform from user-agent
  const userAgent = context.rawRequest?.headers?.["user-agent"] || "";
  let devicePlatform: string | null = null;
  if (userAgent.toLowerCase().includes("android")) {
    devicePlatform = "android";
  } else if (
    userAgent.toLowerCase().includes("iphone") ||
    userAgent.toLowerCase().includes("ipad")
  ) {
    devicePlatform = "ios";
  }

  // 2. Calculate engagement level & daily limit
  const sevenDaysAgo = new Date();
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
  const thirtyDaysAgo = new Date();
  thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const [recentQ, thirtyDayQ, todayQ] = await Promise.all([
    db.collection("engagements")
      .where("userId", "==", userId)
      .where("status", "==", "completed")
      .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(sevenDaysAgo))
      .count().get(),
    db.collection("engagements")
      .where("userId", "==", userId)
      .where("status", "==", "completed")
      .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(thirtyDaysAgo))
      .count().get(),
    db.collection("engagements")
      .where("userId", "==", userId)
      .where("status", "==", "completed")
      .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
      .count().get(),
  ]);

  const dailyCompletions = todayQ.data().count;
  const dailyLimitReached = dailyCompletions >= DAILY_EARN_CAP;
  const engagementLevel = calculateEngagementLevel(
    userCreatedAt,
    recentQ.data().count,
    thirtyDayQ.data().count > 0
  );

  return {
    userId,
    profile: {
      gender: userGender,
      age: userAge,
      province: userProvince,
      city: userCity,
      languages: userLanguages,
      interests: userInterests,
      devicePlatform,
      accountAgeDays,
      engagementLevel,
      interactedClientIds: userInteractedClientIds,
    },
    dailyCompletions,
    dailyEarnCap: DAILY_EARN_CAP,
    dailyLimitReached,
  };
}
