/**
 * Adaptive Bonus Token Award Engine (V2)
 *
 * TypeScript port of the algorithm specified in bonus_token_algorithm_spec_v2.pdf
 *
 * Determines whether an engagement should receive bonus tokens using
 * eligible-aware deficit-tracking adaptive probability with triple streak protection.
 *
 * Key V2 improvement: tracks eligible engagements separately to compensate for
 * guard suppression, ensuring the overall bonus rate converges to targetRate
 * across ALL engagements.
 */

// ============================================================================
// Configuration Interface
// ============================================================================

export interface BonusEngineConfig {
  /** Target long-term bonus rate (e.g. 0.20 = 20% of all engagements). */
  targetRate: number;

  /** Correction aggressiveness for deficit tracking. Higher = faster convergence. */
  correctionK: number;

  /** Minimum probability floor. Ensures every eligible engagement has a chance. */
  minProbability: number;

  /** Maximum probability ceiling (Streak Protection Layer 3). */
  maxProbability: number;

  /** Mandatory non-bonus engagements after each bonus (Streak Protection Layer 1). */
  cooldownAfterBonus: number;

  /** Size of the rolling window for burst detection (Streak Protection Layer 2). */
  windowSize: number;

  /** Maximum bonuses permitted within the rolling window. */
  maxBonusesInWindow: number;
}

// ============================================================================
// State Interface (persisted per user)
// ============================================================================

export interface BonusEngineState {
  /** Lifetime count of engagements for bonus-eligible opportunities. */
  totalVideosWatched: number;

  /** Lifetime count of bonus awards for this user. */
  totalBonusesAwarded: number;

  /** Lifetime count of engagements that passed all guards (eligible for draw). */
  totalEligible: number;

  /** Engagements since the last bonus was awarded. */
  videosSinceLastBonus: number;

  /** Rolling window of recent results (true = bonus awarded). */
  recentResults: boolean[];
}

// ============================================================================
// Default Configuration
// ============================================================================

export const DEFAULT_BONUS_CONFIG: BonusEngineConfig = {
  targetRate: 0.20,
  correctionK: 3.0,
  minProbability: 0.02,
  maxProbability: 0.50,
  cooldownAfterBonus: 3,
  windowSize: 10,
  maxBonusesInWindow: 3,
};

// ============================================================================
// Helper: Create initial state for new users
// ============================================================================

export function createInitialBonusState(
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): BonusEngineState {
  return {
    totalVideosWatched: 0,
    totalBonusesAwarded: 0,
    totalEligible: 0,
    // Initialize high so the first engagement is eligible
    videosSinceLastBonus: config.cooldownAfterBonus + 1,
    recentResults: [],
  };
}

// ============================================================================
// Core Algorithm
// ============================================================================

export interface BonusDecision {
  /** Whether a bonus should be awarded. */
  awarded: boolean;

  /** Updated state to persist. */
  newState: BonusEngineState;

  /** Diagnostic info. */
  diagnostics: {
    wasEligible: boolean;
    calculatedProbability: number;
    randomValue: number;
    blockedByCooldown: boolean;
    blockedByWindowCap: boolean;
    currentRate: number;
    currentDeficit: number;
  };
}

/**
 * Determines whether the current engagement should receive bonus tokens.
 *
 * This function is pure - it takes the current state and returns the decision
 * along with the new state. The caller is responsible for persisting the state.
 *
 * @param state Current bonus engine state for the user
 * @param config Algorithm configuration (use DEFAULT_BONUS_CONFIG if not customized)
 * @param randomValue Random value in [0, 1) - pass Math.random() or a seeded RNG
 * @returns Decision and updated state
 */
export function shouldAwardBonus(
  state: BonusEngineState,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG,
  randomValue: number = Math.random()
): BonusDecision {
  // Clone state to avoid mutations
  const newState: BonusEngineState = {
    totalVideosWatched: state.totalVideosWatched,
    totalBonusesAwarded: state.totalBonusesAwarded,
    totalEligible: state.totalEligible,
    videosSinceLastBonus: state.videosSinceLastBonus + 1,
    recentResults: [...state.recentResults],
  };

  let wasEligible = true;
  let blockedByCooldown = false;
  let blockedByWindowCap = false;
  let calculatedProbability = config.targetRate;
  let awarded = false;

  // ── Guard 1: Cooldown Window ──
  if (newState.videosSinceLastBonus <= config.cooldownAfterBonus) {
    wasEligible = false;
    blockedByCooldown = true;
  }

  // ── Guard 2: Rolling Window Cap ──
  if (wasEligible && isWindowCapped(newState.recentResults, config)) {
    wasEligible = false;
    blockedByWindowCap = true;
  }

  // ── Calculate probability and make random draw if eligible ──
  if (wasEligible) {
    calculatedProbability = calculateProbability(newState, config);
    awarded = randomValue < calculatedProbability;
  }

  // ── Update state ──
  newState.totalVideosWatched++;
  if (wasEligible) {
    newState.totalEligible++;
  }
  if (awarded) {
    newState.totalBonusesAwarded++;
    newState.videosSinceLastBonus = 0;
  }

  // Update rolling window
  newState.recentResults.push(awarded);
  if (newState.recentResults.length > config.windowSize) {
    newState.recentResults.shift();
  }

  // Calculate diagnostics
  const currentRate =
    newState.totalVideosWatched === 0
      ? 0
      : newState.totalBonusesAwarded / newState.totalVideosWatched;
  const currentDeficit =
    config.targetRate * newState.totalVideosWatched - newState.totalBonusesAwarded;

  return {
    awarded,
    newState,
    diagnostics: {
      wasEligible,
      calculatedProbability,
      randomValue,
      blockedByCooldown,
      blockedByWindowCap,
      currentRate,
      currentDeficit,
    },
  };
}

// ============================================================================
// Internal Helpers
// ============================================================================

/**
 * Calculate the adaptive probability based on eligible-aware deficit tracking.
 */
function calculateProbability(
  state: BonusEngineState,
  config: BonusEngineConfig
): number {
  if (state.totalEligible === 0) {
    return config.targetRate;
  }

  // Compute the eligible fraction and derive the effective target
  const eligFrac = state.totalEligible / state.totalVideosWatched;
  // Clamp to prevent division issues in pathological cases
  const clampedEligFrac = Math.max(0.3, Math.min(1.0, eligFrac));
  const effectiveTarget = config.targetRate / clampedEligFrac;

  // Current bonus rate on eligible engagements only
  const currentEligibleRate = state.totalBonusesAwarded / state.totalEligible;

  // Proportional correction against the effective target
  const rawP =
    effectiveTarget + config.correctionK * (effectiveTarget - currentEligibleRate);

  // Clamp to bounds
  return Math.max(config.minProbability, Math.min(config.maxProbability, rawP));
}

/**
 * Check if the rolling window cap has been reached.
 */
function isWindowCapped(
  recentResults: boolean[],
  config: BonusEngineConfig
): boolean {
  if (recentResults.length === 0) {
    return false;
  }

  const currentBonuses = recentResults.filter((b) => b).length;

  if (recentResults.length < config.windowSize) {
    // Pro-rate the cap for partial windows
    const partialMax = Math.max(
      1,
      Math.min(
        config.maxBonusesInWindow,
        Math.ceil(
          (config.maxBonusesInWindow / config.windowSize) * recentResults.length
        )
      )
    );
    return currentBonuses >= partialMax;
  }

  return currentBonuses >= config.maxBonusesInWindow;
}

// ============================================================================
// Diagnostic Getters
// ============================================================================

/**
 * Get current lifetime bonus rate across ALL engagements.
 */
export function getCurrentRate(state: BonusEngineState): number {
  return state.totalVideosWatched === 0
    ? 0
    : state.totalBonusesAwarded / state.totalVideosWatched;
}

/**
 * Get current deficit: positive = under-awarded, negative = over-awarded.
 */
export function getCurrentDeficit(
  state: BonusEngineState,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): number {
  return config.targetRate * state.totalVideosWatched - state.totalBonusesAwarded;
}

/**
 * Get fraction of engagements that were eligible (passed all guards).
 */
export function getEligibleFraction(state: BonusEngineState): number {
  return state.totalVideosWatched === 0
    ? 1.0
    : state.totalEligible / state.totalVideosWatched;
}

/**
 * Get the probability that would be calculated for the next eligible engagement.
 */
export function getNextProbability(
  state: BonusEngineState,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): number {
  return calculateProbability(state, config);
}

/**
 * Get number of bonuses in the current rolling window.
 */
export function getBonusesInCurrentWindow(state: BonusEngineState): number {
  return state.recentResults.filter((b) => b).length;
}

/**
 * Check if the cooldown guard is currently active.
 */
export function isCooldownActive(
  state: BonusEngineState,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): boolean {
  return state.videosSinceLastBonus <= config.cooldownAfterBonus;
}

/**
 * Check if the rolling window cap is currently active.
 */
export function isWindowCapActive(
  state: BonusEngineState,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): boolean {
  return isWindowCapped(state.recentResults, config);
}

// ============================================================================
// "Every X Completions" Mode Helper
// ============================================================================

/**
 * Check if bonus should be awarded for "every_x" mode.
 *
 * @param completionCount Total completions by this user for this opportunity
 * @param intervalX Award bonus every X completions
 * @returns Whether this completion should receive a bonus
 */
export function shouldAwardEveryXBonus(
  completionCount: number,
  intervalX: number
): boolean {
  if (intervalX <= 0) {
    return false;
  }
  return completionCount > 0 && completionCount % intervalX === 0;
}

// ============================================================================
// Serialization Helpers
// ============================================================================

/**
 * Convert state to Firestore-compatible format.
 */
export function stateToFirestore(state: BonusEngineState): Record<string, unknown> {
  return {
    totalVideosWatched: state.totalVideosWatched,
    totalBonusesAwarded: state.totalBonusesAwarded,
    totalEligible: state.totalEligible,
    videosSinceLastBonus: state.videosSinceLastBonus,
    recentResults: state.recentResults,
  };
}

/**
 * Parse state from Firestore document data.
 */
export function stateFromFirestore(
  data: Record<string, unknown> | undefined,
  config: BonusEngineConfig = DEFAULT_BONUS_CONFIG
): BonusEngineState {
  if (!data) {
    return createInitialBonusState(config);
  }

  return {
    totalVideosWatched: (data.totalVideosWatched as number) || 0,
    totalBonusesAwarded: (data.totalBonusesAwarded as number) || 0,
    totalEligible: (data.totalEligible as number) || 0,
    videosSinceLastBonus:
      (data.videosSinceLastBonus as number) ?? config.cooldownAfterBonus + 1,
    recentResults: (data.recentResults as boolean[]) || [],
  };
}
