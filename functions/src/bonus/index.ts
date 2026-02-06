/**
 * Bonus Token Award System
 *
 * Exports for the Adaptive Bonus Token Award Engine (V2)
 */

export {
  // Types
  BonusEngineConfig,
  BonusEngineState,
  BonusDecision,
  // Constants
  DEFAULT_BONUS_CONFIG,
  // Core functions
  createInitialBonusState,
  shouldAwardBonus,
  shouldAwardEveryXBonus,
  // Diagnostic getters
  getCurrentRate,
  getCurrentDeficit,
  getEligibleFraction,
  getNextProbability,
  getBonusesInCurrentWindow,
  isCooldownActive,
  isWindowCapActive,
  // Serialization
  stateToFirestore,
  stateFromFirestore,
} from "./BonusAwardEngine";
