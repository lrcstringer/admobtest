/**
 * BonusAwardEngine Unit Tests
 *
 * Comprehensive tests for the Adaptive Bonus Token Award Engine V2.
 * Covers all algorithm paths, guards, probability calculations, and edge cases.
 */

import {
  BonusEngineConfig,
  BonusEngineState,
  DEFAULT_BONUS_CONFIG,
  createInitialBonusState,
  shouldAwardBonus,
  shouldAwardEveryXBonus,
  stateToFirestore,
  stateFromFirestore,
  getCurrentRate,
  getCurrentDeficit,
  getEligibleFraction,
  getNextProbability,
  getBonusesInCurrentWindow,
  isCooldownActive,
  isWindowCapActive,
} from "../../bonus/BonusAwardEngine";

describe("BonusAwardEngine", () => {
  // ============================================================================
  // Initial State Tests
  // ============================================================================
  describe("createInitialBonusState", () => {
    it("should create state with all counters at zero", () => {
      const state = createInitialBonusState();

      expect(state.totalVideosWatched).toBe(0);
      expect(state.totalBonusesAwarded).toBe(0);
      expect(state.totalEligible).toBe(0);
      expect(state.recentResults).toEqual([]);
    });

    it("should set videosSinceLastBonus to allow first engagement to be eligible", () => {
      const state = createInitialBonusState();

      // Should be > cooldownAfterBonus so first engagement passes cooldown
      expect(state.videosSinceLastBonus).toBe(DEFAULT_BONUS_CONFIG.cooldownAfterBonus + 1);
    });

    it("should use custom config values for initial videosSinceLastBonus", () => {
      const customConfig: BonusEngineConfig = {
        ...DEFAULT_BONUS_CONFIG,
        cooldownAfterBonus: 5,
      };
      const state = createInitialBonusState(customConfig);

      expect(state.videosSinceLastBonus).toBe(6);
    });
  });

  // ============================================================================
  // Cooldown Guard Tests (Layer 1)
  // ============================================================================
  describe("Cooldown Guard (Layer 1)", () => {
    it("should block bonus immediately after one was awarded", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: 0, // Just got a bonus
        recentResults: [true],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.awarded).toBe(false);
      expect(decision.diagnostics.blockedByCooldown).toBe(true);
      expect(decision.diagnostics.wasEligible).toBe(false);
    });

    it("should block during cooldown period", () => {
      const decisions = [];
      let state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: 0,
        recentResults: [true],
      };

      // Run through cooldown period (default = 3)
      for (let i = 0; i < DEFAULT_BONUS_CONFIG.cooldownAfterBonus; i++) {
        const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);
        decisions.push(decision);
        state = decision.newState;
      }

      // All should be blocked by cooldown
      decisions.forEach((d) => {
        expect(d.diagnostics.blockedByCooldown).toBe(true);
        expect(d.awarded).toBe(false);
      });
    });

    it("should allow bonus after cooldown expires", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: DEFAULT_BONUS_CONFIG.cooldownAfterBonus + 1,
        recentResults: [true, false, false, false],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.diagnostics.blockedByCooldown).toBe(false);
      expect(decision.diagnostics.wasEligible).toBe(true);
    });

    it("should reset videosSinceLastBonus to 0 when bonus awarded", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 1,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [true, false, false, false, false],
      };

      // Use very low random to guarantee award
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.001);

      expect(decision.awarded).toBe(true);
      expect(decision.newState.videosSinceLastBonus).toBe(0);
    });

    it("should increment videosSinceLastBonus when no bonus awarded", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [true, false, false, false, false],
      };

      // Use high random to guarantee no award
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.999);

      expect(decision.awarded).toBe(false);
      expect(decision.newState.videosSinceLastBonus).toBe(6);
    });
  });

  // ============================================================================
  // Rolling Window Cap Tests (Layer 2)
  // ============================================================================
  describe("Rolling Window Cap (Layer 2)", () => {
    it("should block when window cap is reached", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 20,
        totalBonusesAwarded: 4,
        totalEligible: 15,
        videosSinceLastBonus: 4, // Past cooldown
        // 3 bonuses in window (max default)
        recentResults: [true, false, true, false, true, false, false, false, false, false],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.diagnostics.blockedByWindowCap).toBe(true);
      expect(decision.diagnostics.wasEligible).toBe(false);
      expect(decision.awarded).toBe(false);
    });

    it("should allow when under window cap", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 20,
        totalBonusesAwarded: 3,
        totalEligible: 15,
        videosSinceLastBonus: 4,
        // 2 bonuses in window (under max)
        recentResults: [true, false, true, false, false, false, false, false, false, false],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.diagnostics.blockedByWindowCap).toBe(false);
      expect(decision.diagnostics.wasEligible).toBe(true);
    });

    it("should pro-rate cap for partial windows", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 3,
        totalBonusesAwarded: 1,
        totalEligible: 3,
        videosSinceLastBonus: 4,
        // 1 bonus in small window (3 items)
        recentResults: [true, false, false],
      };

      // For 3 items out of 10, pro-rated cap = ceil(3/10 * 3) = ceil(0.9) = 1
      // So 1 bonus should be at cap
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.diagnostics.blockedByWindowCap).toBe(true);
    });

    it("should allow first bonus in empty window", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 5,
        totalBonusesAwarded: 0,
        totalEligible: 5,
        videosSinceLastBonus: 6,
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.diagnostics.blockedByWindowCap).toBe(false);
    });

    it("should maintain window at correct size", () => {
      let state = createInitialBonusState();

      // Process 15 engagements (more than window size of 10)
      for (let i = 0; i < 15; i++) {
        const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);
        state = decision.newState;
      }

      // Window should be capped at windowSize
      expect(state.recentResults.length).toBe(DEFAULT_BONUS_CONFIG.windowSize);
    });
  });

  // ============================================================================
  // Probability Calculation Tests
  // ============================================================================
  describe("Probability Calculation", () => {
    it("should return targetRate for first eligible engagement", () => {
      const state = createInitialBonusState();

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // First engagement has no eligible history, so probability = targetRate
      expect(decision.diagnostics.calculatedProbability).toBe(DEFAULT_BONUS_CONFIG.targetRate);
    });

    it("should increase probability when under-awarded", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 10, // 10% rate, target is 20%
        totalEligible: 80,
        videosSinceLastBonus: 10,
        recentResults: new Array(10).fill(false),
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // Should be higher than target to compensate
      expect(decision.diagnostics.calculatedProbability).toBeGreaterThan(DEFAULT_BONUS_CONFIG.targetRate);
    });

    it("should decrease probability when over-awarded", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 30, // 30% rate, target is 20%
        totalEligible: 80,
        videosSinceLastBonus: 10,
        recentResults: new Array(10).fill(false),
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // Should be lower than target to compensate
      expect(decision.diagnostics.calculatedProbability).toBeLessThan(DEFAULT_BONUS_CONFIG.targetRate);
    });

    it("should clamp probability at minProbability", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 50, // 50% rate, way over target
        totalEligible: 80,
        videosSinceLastBonus: 10,
        recentResults: new Array(10).fill(false),
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      expect(decision.diagnostics.calculatedProbability).toBe(DEFAULT_BONUS_CONFIG.minProbability);
    });

    it("should clamp probability at maxProbability", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 0, // 0% rate, way under target
        totalEligible: 80,
        videosSinceLastBonus: 10,
        recentResults: new Array(10).fill(false),
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      expect(decision.diagnostics.calculatedProbability).toBe(DEFAULT_BONUS_CONFIG.maxProbability);
    });

    it("should account for eligible fraction in probability", () => {
      // State with low eligible fraction (many blocked by guards)
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 10,
        totalEligible: 40, // Only 40% eligible
        videosSinceLastBonus: 10,
        recentResults: new Array(10).fill(false),
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // Effective target = 0.20 / 0.40 = 0.50
      // This should result in higher probability
      expect(decision.diagnostics.calculatedProbability).toBeGreaterThan(DEFAULT_BONUS_CONFIG.targetRate);
    });
  });

  // ============================================================================
  // Random Draw Tests
  // ============================================================================
  describe("Random Draw", () => {
    it("should award when random < probability", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 1,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [true, false, false, false, false],
      };

      // Probability will be around 0.2-0.3, use 0.01 to guarantee win
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      expect(decision.awarded).toBe(true);
    });

    it("should not award when random >= probability", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 3, // Slightly over target
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [true, false, false, false, false, true, false, false],
      };

      // Use high random to guarantee no win
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.999);

      expect(decision.awarded).toBe(false);
    });

    it("should award at exact probability boundary", () => {
      // Use a state that will result in targetRate probability
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 20, // Exactly at target (20%)
        totalEligible: 100,
        videosSinceLastBonus: 10, // Past cooldown
        recentResults: [false, false, false, false, false, false, false, false, false, false],
      };

      // Get the calculated probability
      const testDecision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);
      const prob = testDecision.diagnostics.calculatedProbability;

      // Random value just below probability should win
      const decisionWin = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, prob - 0.0001);
      expect(decisionWin.awarded).toBe(true);

      // Random value at or above probability should lose
      const decisionLose = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, prob);
      expect(decisionLose.awarded).toBe(false);
    });
  });

  // ============================================================================
  // State Update Tests
  // ============================================================================
  describe("State Updates", () => {
    it("should increment totalVideosWatched on every engagement", () => {
      const state = createInitialBonusState();
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      expect(decision.newState.totalVideosWatched).toBe(1);
    });

    it("should increment totalEligible only for eligible engagements", () => {
      // Eligible engagement
      const eligibleState = createInitialBonusState();
      const eligibleDecision = shouldAwardBonus(eligibleState, DEFAULT_BONUS_CONFIG, 0.5);
      expect(eligibleDecision.newState.totalEligible).toBe(1);

      // Ineligible (blocked by cooldown)
      const ineligibleState: BonusEngineState = {
        ...createInitialBonusState(),
        videosSinceLastBonus: 0,
      };
      const ineligibleDecision = shouldAwardBonus(ineligibleState, DEFAULT_BONUS_CONFIG, 0.5);
      expect(ineligibleDecision.newState.totalEligible).toBe(0);
    });

    it("should increment totalBonusesAwarded only when bonus awarded", () => {
      const state = createInitialBonusState();

      // Guarantee win
      const winDecision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.001);
      expect(winDecision.newState.totalBonusesAwarded).toBe(1);

      // Guarantee loss
      const loseDecision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.999);
      expect(loseDecision.newState.totalBonusesAwarded).toBe(0);
    });

    it("should add result to recentResults", () => {
      const state = createInitialBonusState();

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      expect(decision.newState.recentResults.length).toBe(1);
      expect(decision.newState.recentResults[0]).toBe(decision.awarded);
    });

    it("should not mutate original state", () => {
      const state = createInitialBonusState();
      const originalWatched = state.totalVideosWatched;

      shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      expect(state.totalVideosWatched).toBe(originalWatched);
    });
  });

  // ============================================================================
  // Diagnostics Tests
  // ============================================================================
  describe("Diagnostics", () => {
    it("should report correct currentRate", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.999);

      // After this engagement: 11 watched, 2 awarded (no new bonus with 0.999)
      expect(decision.diagnostics.currentRate).toBeCloseTo(2 / 11, 5);
    });

    it("should report correct currentDeficit", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 1,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.999);

      // After: target = 0.2 * 11 = 2.2, awarded = 1, deficit = 1.2
      expect(decision.diagnostics.currentDeficit).toBeCloseTo(1.2, 5);
    });

    it("should report randomValue used", () => {
      const state = createInitialBonusState();
      const randomValue = 0.42;

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, randomValue);

      expect(decision.diagnostics.randomValue).toBe(randomValue);
    });
  });

  // ============================================================================
  // Every X Completions Mode Tests
  // ============================================================================
  describe("shouldAwardEveryXBonus", () => {
    it("should return true when completion count is multiple of X", () => {
      expect(shouldAwardEveryXBonus(5, 5)).toBe(true);
      expect(shouldAwardEveryXBonus(10, 5)).toBe(true);
      expect(shouldAwardEveryXBonus(15, 5)).toBe(true);
    });

    it("should return false when completion count is not multiple of X", () => {
      expect(shouldAwardEveryXBonus(1, 5)).toBe(false);
      expect(shouldAwardEveryXBonus(4, 5)).toBe(false);
      expect(shouldAwardEveryXBonus(6, 5)).toBe(false);
    });

    it("should return false for intervalX = 0", () => {
      expect(shouldAwardEveryXBonus(5, 0)).toBe(false);
      expect(shouldAwardEveryXBonus(0, 0)).toBe(false);
    });

    it("should return false for negative intervalX", () => {
      expect(shouldAwardEveryXBonus(5, -1)).toBe(false);
      expect(shouldAwardEveryXBonus(10, -5)).toBe(false);
    });

    it("should return false for completionCount = 0", () => {
      expect(shouldAwardEveryXBonus(0, 5)).toBe(false);
    });

    it("should handle intervalX = 1 (every completion)", () => {
      expect(shouldAwardEveryXBonus(1, 1)).toBe(true);
      expect(shouldAwardEveryXBonus(2, 1)).toBe(true);
      expect(shouldAwardEveryXBonus(100, 1)).toBe(true);
    });

    it("should handle large completion counts", () => {
      expect(shouldAwardEveryXBonus(1000, 5)).toBe(true);
      expect(shouldAwardEveryXBonus(999, 5)).toBe(false);
    });
  });

  // ============================================================================
  // Serialization Tests
  // ============================================================================
  describe("State Serialization", () => {
    describe("stateToFirestore", () => {
      it("should serialize all state fields", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 50,
          totalBonusesAwarded: 10,
          totalEligible: 40,
          videosSinceLastBonus: 3,
          recentResults: [true, false, false],
        };

        const serialized = stateToFirestore(state);

        expect(serialized.totalVideosWatched).toBe(50);
        expect(serialized.totalBonusesAwarded).toBe(10);
        expect(serialized.totalEligible).toBe(40);
        expect(serialized.videosSinceLastBonus).toBe(3);
        expect(serialized.recentResults).toEqual([true, false, false]);
      });
    });

    describe("stateFromFirestore", () => {
      it("should deserialize all state fields", () => {
        const data = {
          totalVideosWatched: 50,
          totalBonusesAwarded: 10,
          totalEligible: 40,
          videosSinceLastBonus: 3,
          recentResults: [true, false, false],
        };

        const state = stateFromFirestore(data);

        expect(state.totalVideosWatched).toBe(50);
        expect(state.totalBonusesAwarded).toBe(10);
        expect(state.totalEligible).toBe(40);
        expect(state.videosSinceLastBonus).toBe(3);
        expect(state.recentResults).toEqual([true, false, false]);
      });

      it("should return initial state for undefined data", () => {
        const state = stateFromFirestore(undefined);

        expect(state.totalVideosWatched).toBe(0);
        expect(state.totalBonusesAwarded).toBe(0);
        expect(state.videosSinceLastBonus).toBe(DEFAULT_BONUS_CONFIG.cooldownAfterBonus + 1);
      });

      it("should handle missing fields with defaults", () => {
        const data = {
          totalVideosWatched: 10,
          // Missing other fields
        };

        const state = stateFromFirestore(data);

        expect(state.totalVideosWatched).toBe(10);
        expect(state.totalBonusesAwarded).toBe(0);
        expect(state.totalEligible).toBe(0);
        expect(state.recentResults).toEqual([]);
      });

      it("should round-trip correctly", () => {
        const original: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 20,
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [true, false, true, false, false, true, false, false, false, false],
        };

        const serialized = stateToFirestore(original);
        const restored = stateFromFirestore(serialized);

        expect(restored).toEqual(original);
      });
    });
  });

  // ============================================================================
  // Diagnostic Getter Tests
  // ============================================================================
  describe("Diagnostic Getters", () => {
    describe("getCurrentRate", () => {
      it("should calculate correct rate", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 20,
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [],
        };

        expect(getCurrentRate(state)).toBe(0.2);
      });

      it("should return 0 for no engagements", () => {
        const state = createInitialBonusState();
        expect(getCurrentRate(state)).toBe(0);
      });
    });

    describe("getCurrentDeficit", () => {
      it("should return positive when under-awarded", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 10, // Should be 20
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [],
        };

        expect(getCurrentDeficit(state)).toBe(10); // 20 - 10 = 10
      });

      it("should return negative when over-awarded", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 30, // Should be 20
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [],
        };

        expect(getCurrentDeficit(state)).toBe(-10); // 20 - 30 = -10
      });
    });

    describe("getEligibleFraction", () => {
      it("should calculate correct fraction", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 20,
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [],
        };

        expect(getEligibleFraction(state)).toBe(0.75);
      });

      it("should return 1.0 for no engagements", () => {
        const state = createInitialBonusState();
        expect(getEligibleFraction(state)).toBe(1.0);
      });
    });

    describe("getBonusesInCurrentWindow", () => {
      it("should count bonuses in window", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 20,
          totalBonusesAwarded: 5,
          totalEligible: 15,
          videosSinceLastBonus: 3,
          recentResults: [true, false, true, false, false, true, false, false, false, false],
        };

        expect(getBonusesInCurrentWindow(state)).toBe(3);
      });

      it("should return 0 for empty window", () => {
        const state = createInitialBonusState();
        expect(getBonusesInCurrentWindow(state)).toBe(0);
      });
    });

    describe("isCooldownActive", () => {
      it("should return true during cooldown", () => {
        const state: BonusEngineState = {
          ...createInitialBonusState(),
          videosSinceLastBonus: 1,
        };

        expect(isCooldownActive(state)).toBe(true);
      });

      it("should return false after cooldown", () => {
        const state: BonusEngineState = {
          ...createInitialBonusState(),
          videosSinceLastBonus: DEFAULT_BONUS_CONFIG.cooldownAfterBonus + 1,
        };

        expect(isCooldownActive(state)).toBe(false);
      });
    });

    describe("isWindowCapActive", () => {
      it("should return true when capped", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 20,
          totalBonusesAwarded: 5,
          totalEligible: 15,
          videosSinceLastBonus: 5,
          recentResults: [true, true, true, false, false, false, false, false, false, false],
        };

        expect(isWindowCapActive(state)).toBe(true);
      });

      it("should return false when under cap", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 20,
          totalBonusesAwarded: 3,
          totalEligible: 15,
          videosSinceLastBonus: 5,
          recentResults: [true, true, false, false, false, false, false, false, false, false],
        };

        expect(isWindowCapActive(state)).toBe(false);
      });
    });

    describe("getNextProbability", () => {
      it("should return target rate for new user", () => {
        const state = createInitialBonusState();
        expect(getNextProbability(state)).toBe(DEFAULT_BONUS_CONFIG.targetRate);
      });

      it("should return adjusted probability based on history", () => {
        const state: BonusEngineState = {
          totalVideosWatched: 100,
          totalBonusesAwarded: 10,
          totalEligible: 75,
          videosSinceLastBonus: 5,
          recentResults: [],
        };

        const prob = getNextProbability(state);
        expect(prob).toBeGreaterThan(DEFAULT_BONUS_CONFIG.targetRate);
        expect(prob).toBeLessThanOrEqual(DEFAULT_BONUS_CONFIG.maxProbability);
      });
    });
  });

  // ============================================================================
  // Edge Cases
  // ============================================================================
  describe("Edge Cases", () => {
    it("should handle very first engagement", () => {
      const state = createInitialBonusState();
      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.1);

      expect(decision.diagnostics.wasEligible).toBe(true);
      expect(decision.newState.totalVideosWatched).toBe(1);
    });

    it("should handle both guards blocking simultaneously", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 20,
        totalBonusesAwarded: 5,
        totalEligible: 15,
        videosSinceLastBonus: 0, // Cooldown active
        // Window cap also reached
        recentResults: [true, true, true, false, false, false, false, false, false, false],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.01);

      // Cooldown takes precedence (checked first)
      expect(decision.diagnostics.blockedByCooldown).toBe(true);
      expect(decision.diagnostics.blockedByWindowCap).toBe(false); // Not checked if cooldown blocks
      expect(decision.awarded).toBe(false);
    });

    it("should converge toward target rate over many engagements", () => {
      let state = createInitialBonusState();
      const iterations = 1000;

      // Use seeded random for reproducibility
      const seededRandom = () => {
        // Simple LCG for testing
        const a = 1664525;
        const c = 1013904223;
        const m = Math.pow(2, 32);
        let seed = 12345;
        return () => {
          seed = (a * seed + c) % m;
          return seed / m;
        };
      };

      const random = seededRandom();

      for (let i = 0; i < iterations; i++) {
        const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, random());
        state = decision.newState;
      }

      const finalRate = getCurrentRate(state);

      // Should be within 5 percentage points of target
      expect(finalRate).toBeGreaterThan(DEFAULT_BONUS_CONFIG.targetRate - 0.05);
      expect(finalRate).toBeLessThan(DEFAULT_BONUS_CONFIG.targetRate + 0.05);
    });

    it("should handle high eligible fraction", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 20,
        totalEligible: 100, // All were eligible
        videosSinceLastBonus: 5,
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // Should still calculate valid probability
      expect(decision.diagnostics.calculatedProbability).toBeGreaterThanOrEqual(
        DEFAULT_BONUS_CONFIG.minProbability
      );
      expect(decision.diagnostics.calculatedProbability).toBeLessThanOrEqual(
        DEFAULT_BONUS_CONFIG.maxProbability
      );
    });

    it("should handle low eligible fraction", () => {
      const state: BonusEngineState = {
        totalVideosWatched: 100,
        totalBonusesAwarded: 5,
        totalEligible: 30, // Only 30% eligible (clamped to 0.3 minimum)
        videosSinceLastBonus: 5,
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, DEFAULT_BONUS_CONFIG, 0.5);

      // Effective target should be boosted due to low eligible fraction
      expect(decision.diagnostics.calculatedProbability).toBeGreaterThan(
        DEFAULT_BONUS_CONFIG.targetRate
      );
    });
  });

  // ============================================================================
  // Custom Configuration Tests
  // ============================================================================
  describe("Custom Configuration", () => {
    it("should respect custom targetRate", () => {
      const config: BonusEngineConfig = {
        ...DEFAULT_BONUS_CONFIG,
        targetRate: 0.5, // 50% target
      };

      const state = createInitialBonusState(config);
      const decision = shouldAwardBonus(state, config, 0.5);

      expect(decision.diagnostics.calculatedProbability).toBe(0.5);
    });

    it("should respect custom cooldown period", () => {
      const config: BonusEngineConfig = {
        ...DEFAULT_BONUS_CONFIG,
        cooldownAfterBonus: 10,
      };

      const state: BonusEngineState = {
        totalVideosWatched: 50,
        totalBonusesAwarded: 10,
        totalEligible: 40,
        videosSinceLastBonus: 5, // Within custom cooldown
        recentResults: [],
      };

      const decision = shouldAwardBonus(state, config, 0.01);

      expect(decision.diagnostics.blockedByCooldown).toBe(true);
    });

    it("should respect custom window settings", () => {
      const config: BonusEngineConfig = {
        ...DEFAULT_BONUS_CONFIG,
        windowSize: 5,
        maxBonusesInWindow: 1,
      };

      const state: BonusEngineState = {
        totalVideosWatched: 10,
        totalBonusesAwarded: 2,
        totalEligible: 8,
        videosSinceLastBonus: 5,
        recentResults: [true, false, false, false, false], // 1 bonus in window of 5
      };

      const decision = shouldAwardBonus(state, config, 0.01);

      expect(decision.diagnostics.blockedByWindowCap).toBe(true);
    });
  });
});
