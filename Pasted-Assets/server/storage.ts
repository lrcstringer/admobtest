import {
  users,
  wallets,
  transactions,
  contacts,
  moneyChatThreads,
  moneyChatEntries,
  referrals,
  earnThreads,
  earnOpportunities,
  userEarnCompletions,
  leaderboardScores,
  prizePots,
  purchases,
  campaigns,
  campaignCreatives,
  campaignSurveyQuestions,
  campaignSurveyResponses,
  campaignMetrics,
  campaignUserFrequency,
  advertiserWallets,
  advertiserTopUps,
  type User,
  type InsertUser,
  type Wallet,
  type InsertWallet,
  type Transaction,
  type InsertTransaction,
  type Contact,
  type InsertContact,
  type MoneyChatThread,
  type InsertMoneyChatThread,
  type MoneyChatEntry,
  type InsertMoneyChatEntry,
  type Referral,
  type InsertReferral,
  type EarnThread,
  type InsertEarnThread,
  type EarnOpportunity,
  type InsertEarnOpportunity,
  type UserEarnCompletion,
  type InsertUserEarnCompletion,
  type LeaderboardScore,
  type InsertLeaderboardScore,
  type PrizePot,
  type InsertPrizePot,
  type Purchase,
  type InsertPurchase,
  type Campaign,
  type CampaignCreative,
  type CampaignSurveyQuestion,
  type InsertCampaignSurveyResponse,
  type CampaignUserFrequency,
  type InsertCampaignUserFrequency,
} from "@shared/schema";
import { db } from "./db";
import { eq, and, desc, sql, asc, gte, lte, or, isNull, inArray } from "drizzle-orm";

export interface IStorage {
  // User Operations
  getUser(id: string): Promise<User | undefined>;
  getUserByUsername(username: string): Promise<User | undefined>;
  getUserByPhoneNumber(phoneNumber: string): Promise<User | undefined>;
  createUser(user: InsertUser): Promise<User>;
  updateUser(id: string, data: Partial<User>): Promise<User | undefined>;

  // Wallet Operations
  getWalletsByUserId(userId: string): Promise<Wallet[]>;
  getWalletById(id: string): Promise<Wallet | undefined>;
  createWallet(wallet: InsertWallet): Promise<Wallet>;
  updateWallet(id: string, data: Partial<Wallet>): Promise<Wallet | undefined>;

  // Transaction Operations
  getTransactionsByUserId(userId: string, limit?: number): Promise<Transaction[]>;
  createTransaction(transaction: InsertTransaction): Promise<Transaction>;
  updateTransaction(id: string, data: Partial<Transaction>): Promise<Transaction | undefined>;

  // Contact Operations
  getContactsByUserId(userId: string): Promise<Contact[]>;
  getContactById(id: string): Promise<Contact | undefined>;
  createContact(contact: InsertContact): Promise<Contact>;
  updateContact(id: string, data: Partial<Contact>): Promise<Contact | undefined>;
  blockContact(contactId: string): Promise<Contact | undefined>;
  unblockContact(contactId: string): Promise<Contact | undefined>;

  // Money Chat Operations
  getMoneyChatThreadsByUserId(userId: string): Promise<MoneyChatThread[]>;
  getMoneyChatThreadByContactId(userId: string, contactId: string): Promise<MoneyChatThread | undefined>;
  createMoneyChatThread(thread: InsertMoneyChatThread): Promise<MoneyChatThread>;
  updateMoneyChatThread(id: string, data: Partial<MoneyChatThread>): Promise<MoneyChatThread | undefined>;
  getMoneyChatEntriesByThreadId(threadId: string): Promise<MoneyChatEntry[]>;
  createMoneyChatEntry(entry: InsertMoneyChatEntry): Promise<MoneyChatEntry>;

  // Referral Operations
  getReferralsByReferrerId(referrerId: string): Promise<Referral[]>;
  getReferralByPhoneNumber(phoneNumber: string): Promise<Referral | undefined>;
  createReferral(referral: InsertReferral): Promise<Referral>;
  updateReferral(id: string, data: Partial<Referral>): Promise<Referral | undefined>;

  // Earn Operations
  getEarnThreads(): Promise<EarnThread[]>;
  getEarnThreadById(id: string): Promise<EarnThread | undefined>;
  createEarnThread(thread: InsertEarnThread): Promise<EarnThread>;
  getEarnOpportunitiesByThreadId(threadId: string): Promise<EarnOpportunity[]>;
  getActiveEarnOpportunities(): Promise<EarnOpportunity[]>;
  createEarnOpportunity(opportunity: InsertEarnOpportunity): Promise<EarnOpportunity>;
  getUserEarnCompletionsByUserId(userId: string): Promise<UserEarnCompletion[]>;
  createUserEarnCompletion(completion: InsertUserEarnCompletion): Promise<UserEarnCompletion>;
  hasUserCompletedOpportunity(userId: string, opportunityId: string): Promise<boolean>;

  // Leaderboard Operations
  getLeaderboardScoresByPeriod(period: string): Promise<LeaderboardScore[]>;
  getLeaderboardScoreByUserAndPeriod(userId: string, period: string): Promise<LeaderboardScore | undefined>;
  createOrUpdateLeaderboardScore(score: InsertLeaderboardScore): Promise<LeaderboardScore>;
  updateLeaderboardRanks(period: string): Promise<void>;

  // Prize Pot Operations
  getPrizePotByPeriod(period: string): Promise<PrizePot | undefined>;
  createOrUpdatePrizePot(pot: InsertPrizePot): Promise<PrizePot>;

  // Purchase Operations
  getPurchasesByUserId(userId: string, limit?: number): Promise<Purchase[]>;
  createPurchase(purchase: InsertPurchase): Promise<Purchase>;

  // Campaign Delivery Operations
  getEligibleCampaignsForUser(user: User): Promise<Campaign[]>;
  getCampaignById(campaignId: string): Promise<Campaign | undefined>;
  getCampaignCreatives(campaignId: string): Promise<CampaignCreative[]>;
  getCampaignSurveyQuestions(campaignId: string): Promise<CampaignSurveyQuestion[]>;
  getUserFrequencyForCampaign(userId: string, campaignId: string, date: Date): Promise<CampaignUserFrequency | undefined>;
  incrementUserFrequency(userId: string, campaignId: string, date: Date): Promise<CampaignUserFrequency>;
  recordCampaignEngagement(campaignId: string, userId: string, surveyResponses?: InsertCampaignSurveyResponse[]): Promise<{ success: boolean; tokensEarned: number; error?: string }>;
  chargeCampaignBudget(campaign: Campaign, cpeZar: number): Promise<boolean>;
  updateCampaignMetrics(campaignId: string, date: Date, updates: { impressionsStarted?: number; impressionsCompleted?: number; surveySubmits?: number }): Promise<void>;
  pauseCampaignIfBudgetExhausted(campaignId: string): Promise<void>;
}

export class DatabaseStorage implements IStorage {
  // User Operations
  async getUser(id: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.id, id));
    return user || undefined;
  }

  async getUserByUsername(username: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.username, username));
    return user || undefined;
  }

  async getUserByPhoneNumber(phoneNumber: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.phoneNumber, phoneNumber));
    return user || undefined;
  }

  async createUser(insertUser: InsertUser): Promise<User> {
    const [user] = await db.insert(users).values(insertUser).returning();
    
    // Create default main wallet for new user
    await db.insert(wallets).values({
      userId: user.id,
      name: "iMaliChat Wallet",
      type: "main",
      color: "from-primary to-pink-600",
    });

    return user;
  }

  async updateUser(id: string, data: Partial<User>): Promise<User | undefined> {
    const [user] = await db.update(users).set(data).where(eq(users.id, id)).returning();
    return user || undefined;
  }

  // Wallet Operations
  async getWalletsByUserId(userId: string): Promise<Wallet[]> {
    return await db.select().from(wallets).where(eq(wallets.userId, userId));
  }

  async getWalletById(id: string): Promise<Wallet | undefined> {
    const [wallet] = await db.select().from(wallets).where(eq(wallets.id, id));
    return wallet || undefined;
  }

  async createWallet(wallet: InsertWallet): Promise<Wallet> {
    const [newWallet] = await db.insert(wallets).values(wallet).returning();
    return newWallet;
  }

  async updateWallet(id: string, data: Partial<Wallet>): Promise<Wallet | undefined> {
    const [wallet] = await db.update(wallets).set(data).where(eq(wallets.id, id)).returning();
    return wallet || undefined;
  }

  // Transaction Operations
  async getTransactionsByUserId(userId: string, limit: number = 50): Promise<Transaction[]> {
    return await db
      .select()
      .from(transactions)
      .where(eq(transactions.userId, userId))
      .orderBy(desc(transactions.createdAt))
      .limit(limit);
  }

  async createTransaction(transaction: InsertTransaction): Promise<Transaction> {
    const [newTransaction] = await db.insert(transactions).values(transaction).returning();
    return newTransaction;
  }

  async updateTransaction(id: string, data: Partial<Transaction>): Promise<Transaction | undefined> {
    const [transaction] = await db.update(transactions).set(data).where(eq(transactions.id, id)).returning();
    return transaction || undefined;
  }

  // Contact Operations
  async getContactsByUserId(userId: string): Promise<Contact[]> {
    return await db.select().from(contacts).where(eq(contacts.userId, userId));
  }

  async getContactById(id: string): Promise<Contact | undefined> {
    const [contact] = await db.select().from(contacts).where(eq(contacts.id, id));
    return contact || undefined;
  }

  async createContact(contact: InsertContact): Promise<Contact> {
    const [newContact] = await db.insert(contacts).values(contact).returning();
    return newContact;
  }

  async updateContact(id: string, data: Partial<Contact>): Promise<Contact | undefined> {
    const [contact] = await db.update(contacts).set(data).where(eq(contacts.id, id)).returning();
    return contact || undefined;
  }

  async blockContact(contactId: string): Promise<Contact | undefined> {
    return this.updateContact(contactId, { blocked: true });
  }

  async unblockContact(contactId: string): Promise<Contact | undefined> {
    return this.updateContact(contactId, { blocked: false });
  }

  // Money Chat Operations
  async getMoneyChatThreadsByUserId(userId: string): Promise<MoneyChatThread[]> {
    return await db
      .select()
      .from(moneyChatThreads)
      .where(eq(moneyChatThreads.userId, userId))
      .orderBy(desc(moneyChatThreads.lastUpdatedAt));
  }

  async getMoneyChatThreadByContactId(userId: string, contactId: string): Promise<MoneyChatThread | undefined> {
    const [thread] = await db
      .select()
      .from(moneyChatThreads)
      .where(and(eq(moneyChatThreads.userId, userId), eq(moneyChatThreads.contactId, contactId)));
    return thread || undefined;
  }

  async createMoneyChatThread(thread: InsertMoneyChatThread): Promise<MoneyChatThread> {
    const [newThread] = await db.insert(moneyChatThreads).values(thread).returning();
    return newThread;
  }

  async updateMoneyChatThread(id: string, data: Partial<MoneyChatThread>): Promise<MoneyChatThread | undefined> {
    const [thread] = await db.update(moneyChatThreads).set(data).where(eq(moneyChatThreads.id, id)).returning();
    return thread || undefined;
  }

  async getMoneyChatEntriesByThreadId(threadId: string): Promise<MoneyChatEntry[]> {
    return await db
      .select()
      .from(moneyChatEntries)
      .where(eq(moneyChatEntries.threadId, threadId))
      .orderBy(asc(moneyChatEntries.createdAt));
  }

  async createMoneyChatEntry(entry: InsertMoneyChatEntry): Promise<MoneyChatEntry> {
    const [newEntry] = await db.insert(moneyChatEntries).values(entry).returning();
    return newEntry;
  }

  // Referral Operations
  async getReferralsByReferrerId(referrerId: string): Promise<Referral[]> {
    return await db.select().from(referrals).where(eq(referrals.referrerId, referrerId));
  }

  async getReferralByPhoneNumber(phoneNumber: string): Promise<Referral | undefined> {
    const [referral] = await db
      .select()
      .from(referrals)
      .where(eq(referrals.referredPhoneNumber, phoneNumber))
      .orderBy(asc(referrals.invitedAt))
      .limit(1);
    return referral || undefined;
  }

  async createReferral(referral: InsertReferral): Promise<Referral> {
    const [newReferral] = await db.insert(referrals).values(referral).returning();
    return newReferral;
  }

  async updateReferral(id: string, data: Partial<Referral>): Promise<Referral | undefined> {
    const [referral] = await db.update(referrals).set(data).where(eq(referrals.id, id)).returning();
    return referral || undefined;
  }

  // Earn Operations
  async getEarnThreads(): Promise<EarnThread[]> {
    return await db
      .select()
      .from(earnThreads)
      .where(eq(earnThreads.isActive, true))
      .orderBy(desc(earnThreads.isPinned), desc(earnThreads.createdAt));
  }

  async getEarnThreadById(id: string): Promise<EarnThread | undefined> {
    const [thread] = await db.select().from(earnThreads).where(eq(earnThreads.id, id));
    return thread || undefined;
  }

  async createEarnThread(thread: InsertEarnThread): Promise<EarnThread> {
    const [newThread] = await db.insert(earnThreads).values(thread).returning();
    return newThread;
  }

  async getEarnOpportunitiesByThreadId(threadId: string): Promise<EarnOpportunity[]> {
    const now = new Date();
    return await db
      .select()
      .from(earnOpportunities)
      .where(
        and(
          eq(earnOpportunities.threadId, threadId),
          eq(earnOpportunities.isActive, true),
          sql`(${earnOpportunities.expiresAt} IS NULL OR ${earnOpportunities.expiresAt} > ${now})`
        )
      );
  }

  async getActiveEarnOpportunities(): Promise<EarnOpportunity[]> {
    const now = new Date();
    return await db
      .select()
      .from(earnOpportunities)
      .where(
        and(
          eq(earnOpportunities.isActive, true),
          sql`(${earnOpportunities.expiresAt} IS NULL OR ${earnOpportunities.expiresAt} > ${now})`
        )
      );
  }

  async createEarnOpportunity(opportunity: InsertEarnOpportunity): Promise<EarnOpportunity> {
    const [newOpportunity] = await db.insert(earnOpportunities).values(opportunity).returning();
    return newOpportunity;
  }

  async getUserEarnCompletionsByUserId(userId: string): Promise<UserEarnCompletion[]> {
    return await db
      .select()
      .from(userEarnCompletions)
      .where(eq(userEarnCompletions.userId, userId))
      .orderBy(desc(userEarnCompletions.completedAt));
  }

  async createUserEarnCompletion(completion: InsertUserEarnCompletion): Promise<UserEarnCompletion> {
    const [newCompletion] = await db.insert(userEarnCompletions).values(completion).returning();
    return newCompletion;
  }

  async hasUserCompletedOpportunity(userId: string, opportunityId: string): Promise<boolean> {
    const [completion] = await db
      .select()
      .from(userEarnCompletions)
      .where(
        and(
          eq(userEarnCompletions.userId, userId),
          eq(userEarnCompletions.opportunityId, opportunityId)
        )
      )
      .limit(1);
    return !!completion;
  }

  // Leaderboard Operations
  async getLeaderboardScoresByPeriod(period: string): Promise<LeaderboardScore[]> {
    return await db
      .select()
      .from(leaderboardScores)
      .where(eq(leaderboardScores.period, period))
      .orderBy(asc(leaderboardScores.rank));
  }

  async getLeaderboardScoreByUserAndPeriod(userId: string, period: string): Promise<LeaderboardScore | undefined> {
    const [score] = await db
      .select()
      .from(leaderboardScores)
      .where(and(eq(leaderboardScores.userId, userId), eq(leaderboardScores.period, period)));
    return score || undefined;
  }

  async createOrUpdateLeaderboardScore(scoreData: InsertLeaderboardScore): Promise<LeaderboardScore> {
    const existing = await this.getLeaderboardScoreByUserAndPeriod(scoreData.userId, scoreData.period);
    
    if (existing) {
      const [updated] = await db
        .update(leaderboardScores)
        .set({ ...scoreData, updatedAt: new Date() })
        .where(eq(leaderboardScores.id, existing.id))
        .returning();
      return updated;
    } else {
      const [newScore] = await db.insert(leaderboardScores).values(scoreData).returning();
      return newScore;
    }
  }

  async updateLeaderboardRanks(period: string): Promise<void> {
    const scores = await db
      .select()
      .from(leaderboardScores)
      .where(eq(leaderboardScores.period, period))
      .orderBy(desc(leaderboardScores.score));

    for (let i = 0; i < scores.length; i++) {
      await db
        .update(leaderboardScores)
        .set({ rank: i + 1 })
        .where(eq(leaderboardScores.id, scores[i].id));
    }
  }

  // Prize Pot Operations
  async getPrizePotByPeriod(period: string): Promise<PrizePot | undefined> {
    const [pot] = await db.select().from(prizePots).where(eq(prizePots.period, period));
    return pot || undefined;
  }

  async createOrUpdatePrizePot(potData: InsertPrizePot): Promise<PrizePot> {
    const existing = await this.getPrizePotByPeriod(potData.period);
    
    if (existing) {
      const [updated] = await db
        .update(prizePots)
        .set(potData)
        .where(eq(prizePots.id, existing.id))
        .returning();
      return updated;
    } else {
      const [newPot] = await db.insert(prizePots).values(potData).returning();
      return newPot;
    }
  }

  // Purchase Operations
  async getPurchasesByUserId(userId: string, limit: number = 50): Promise<Purchase[]> {
    return await db
      .select()
      .from(purchases)
      .where(eq(purchases.userId, userId))
      .orderBy(desc(purchases.createdAt))
      .limit(limit);
  }

  async createPurchase(purchase: InsertPurchase): Promise<Purchase> {
    const [newPurchase] = await db.insert(purchases).values(purchase).returning();
    return newPurchase;
  }

  // Campaign Delivery Operations
  async getEligibleCampaignsForUser(user: User): Promise<Campaign[]> {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    
    // Get all active campaigns within date range and budget, joined with advertiser wallets
    const activeCampaigns = await db
      .select({
        campaign: campaigns,
        walletBalance: advertiserWallets.balanceZar,
      })
      .from(campaigns)
      .innerJoin(advertiserWallets, eq(advertiserWallets.orgId, campaigns.orgId))
      .where(
        and(
          eq(campaigns.status, "active"),
          or(isNull(campaigns.startDate), lte(campaigns.startDate, now)),
          or(isNull(campaigns.endDate), gte(campaigns.endDate, now)),
          sql`CAST(${campaigns.totalSpent} AS DECIMAL) < CAST(${campaigns.totalBudget} AS DECIMAL)`,
          // Ensure advertiser has enough balance for at least one engagement
          sql`CAST(${advertiserWallets.balanceZar} AS DECIMAL) >= CAST(${campaigns.cpeZar} AS DECIMAL)`
        )
      );

    const eligible: Campaign[] = [];
    
    for (const row of activeCampaigns) {
      const campaign = row.campaign;
      
      // Check daily cap (reset if needed)
      if (campaign.dailyCap) {
        const lastReset = campaign.lastSpendResetDate ? new Date(campaign.lastSpendResetDate) : null;
        if (!lastReset || lastReset < today) {
          // Reset daily spending
          await db.update(campaigns)
            .set({ todaySpent: "0", lastSpendResetDate: today })
            .where(eq(campaigns.id, campaign.id));
          campaign.todaySpent = "0";
        }
        
        const todaySpent = parseFloat(campaign.todaySpent || "0") || 0;
        const dailyCapVal = parseFloat(campaign.dailyCap) || 0;
        if (dailyCapVal > 0 && todaySpent >= dailyCapVal) {
          continue; // Daily cap reached
        }
      }

      // Check targeting: age (calculated from date of birth)
      if (user.dateOfBirth && (campaign.targetAgeMin || campaign.targetAgeMax)) {
        const nowDate = new Date();
        const birthDate = new Date(user.dateOfBirth);
        const userAge = Math.floor((nowDate.getTime() - birthDate.getTime()) / (365.25 * 24 * 60 * 60 * 1000));
        if (campaign.targetAgeMin && userAge < campaign.targetAgeMin) continue;
        if (campaign.targetAgeMax && userAge > campaign.targetAgeMax) continue;
      }
      
      // Check targeting: gender
      if (campaign.targetGenders && campaign.targetGenders.length > 0 && user.gender) {
        if (!campaign.targetGenders.includes(user.gender)) continue;
      }
      
      // Check targeting: province
      if (campaign.targetProvinces && campaign.targetProvinces.length > 0 && user.province) {
        if (!campaign.targetProvinces.includes(user.province)) continue;
      }

      // Check user frequency cap (default to 2 if not set)
      const frequencyCapPerUser = campaign.frequencyCapPerUser ?? 2;
      const frequency = await this.getUserFrequencyForCampaign(user.id, campaign.id, today);
      if (frequency && frequency.impressionCount >= frequencyCapPerUser) {
        continue; // User has seen this campaign enough today
      }

      eligible.push(campaign);
    }

    return eligible;
  }

  async getCampaignById(campaignId: string): Promise<Campaign | undefined> {
    const [campaign] = await db.select().from(campaigns).where(eq(campaigns.id, campaignId));
    return campaign || undefined;
  }

  async getCampaignCreatives(campaignId: string): Promise<CampaignCreative[]> {
    return await db.select().from(campaignCreatives)
      .where(and(
        eq(campaignCreatives.campaignId, campaignId),
        eq(campaignCreatives.status, "approved")
      ));
  }

  async getCampaignSurveyQuestions(campaignId: string): Promise<CampaignSurveyQuestion[]> {
    return await db.select().from(campaignSurveyQuestions)
      .where(eq(campaignSurveyQuestions.campaignId, campaignId))
      .orderBy(asc(campaignSurveyQuestions.orderIndex));
  }

  async getUserFrequencyForCampaign(userId: string, campaignId: string, date: Date): Promise<CampaignUserFrequency | undefined> {
    const startOfDay = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    const endOfDay = new Date(startOfDay.getTime() + 24 * 60 * 60 * 1000);
    
    const [freq] = await db.select().from(campaignUserFrequency)
      .where(and(
        eq(campaignUserFrequency.userId, userId),
        eq(campaignUserFrequency.campaignId, campaignId),
        gte(campaignUserFrequency.date, startOfDay),
        lte(campaignUserFrequency.date, endOfDay)
      ));
    return freq || undefined;
  }

  async incrementUserFrequency(userId: string, campaignId: string, date: Date): Promise<CampaignUserFrequency> {
    const startOfDay = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    const existing = await this.getUserFrequencyForCampaign(userId, campaignId, startOfDay);
    
    if (existing) {
      const [updated] = await db.update(campaignUserFrequency)
        .set({ impressionCount: existing.impressionCount + 1 })
        .where(eq(campaignUserFrequency.id, existing.id))
        .returning();
      return updated;
    } else {
      const [newFreq] = await db.insert(campaignUserFrequency)
        .values({ userId, campaignId, date: startOfDay, impressionCount: 1 })
        .returning();
      return newFreq;
    }
  }

  async recordCampaignEngagement(
    campaignId: string, 
    userId: string, 
    surveyResponses?: InsertCampaignSurveyResponse[]
  ): Promise<{ success: boolean; tokensEarned: number; error?: string }> {
    try {
      const campaign = await this.getCampaignById(campaignId);
      if (!campaign) {
        return { success: false, tokensEarned: 0, error: "Campaign not found" };
      }

      if (campaign.status !== "active") {
        return { success: false, tokensEarned: 0, error: "Campaign is not active" };
      }

      const cpeZar = parseFloat(campaign.cpeZar) || 0;
      if (cpeZar <= 0) {
        return { success: false, tokensEarned: 0, error: "Invalid campaign CPE" };
      }
      
      // Check budget with safe parsing
      const totalSpent = parseFloat(campaign.totalSpent || "0") || 0;
      const totalBudget = parseFloat(campaign.totalBudget) || 0;
      
      if (totalSpent + cpeZar > totalBudget) {
        return { success: false, tokensEarned: 0, error: "Campaign budget exhausted" };
      }

      // Charge advertiser wallet (includes wallet deduction and campaign spend updates)
      const charged = await this.chargeCampaignBudget(campaign, cpeZar);
      if (!charged) {
        return { success: false, tokensEarned: 0, error: "Insufficient advertiser funds" };
      }

      // Record survey responses if provided
      if (surveyResponses && surveyResponses.length > 0) {
        await db.insert(campaignSurveyResponses).values(surveyResponses);
      }

      // Update campaign metrics
      const today = new Date();
      await this.updateCampaignMetrics(campaignId, today, {
        impressionsCompleted: 1,
        surveySubmits: surveyResponses && surveyResponses.length > 0 ? 1 : 0,
      });

      // Increment user frequency
      await this.incrementUserFrequency(userId, campaignId, today);

      // Check if budget exhausted and auto-pause
      await this.pauseCampaignIfBudgetExhausted(campaignId);

      // Calculate user reward: 100 tokens = R1, so CPE in ZAR * 100 = tokens
      // User gets 90% of the CPE value as tokens
      const tokensEarned = Math.floor(cpeZar * 100 * 0.9);

      return { success: true, tokensEarned };
    } catch (error) {
      console.error("Error recording campaign engagement:", error);
      return { success: false, tokensEarned: 0, error: "Failed to process engagement" };
    }
  }

  async chargeCampaignBudget(campaign: Campaign, cpeZar: number): Promise<boolean> {
    try {
      // Get advertiser wallet
      const [wallet] = await db.select().from(advertiserWallets)
        .where(eq(advertiserWallets.orgId, campaign.orgId));
      
      if (!wallet) return false;
      
      const currentBalance = parseFloat(wallet.balanceZar) || 0;
      if (currentBalance < cpeZar) return false;

      // Calculate new values with safe parsing
      const newWalletBalance = currentBalance - cpeZar;
      const newTotalSpent = (parseFloat(campaign.totalSpent || "0") || 0) + cpeZar;
      const newTodaySpent = (parseFloat(campaign.todaySpent || "0") || 0) + cpeZar;

      // Deduct from wallet and update campaign spending together
      await db.update(advertiserWallets)
        .set({ 
          balanceZar: newWalletBalance.toFixed(2),
          totalSpent: ((parseFloat(wallet.totalSpent) || 0) + cpeZar).toFixed(2)
        })
        .where(eq(advertiserWallets.id, wallet.id));

      await db.update(campaigns)
        .set({ 
          totalSpent: newTotalSpent.toFixed(2),
          todaySpent: newTodaySpent.toFixed(2)
        })
        .where(eq(campaigns.id, campaign.id));

      return true;
    } catch (error) {
      console.error("Error charging campaign budget:", error);
      return false;
    }
  }

  async updateCampaignMetrics(
    campaignId: string, 
    date: Date, 
    updates: { impressionsStarted?: number; impressionsCompleted?: number; surveySubmits?: number }
  ): Promise<void> {
    const startOfDay = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    
    // Try to get existing metrics for today
    const [existing] = await db.select().from(campaignMetrics)
      .where(and(
        eq(campaignMetrics.campaignId, campaignId),
        gte(campaignMetrics.date, startOfDay),
        lte(campaignMetrics.date, new Date(startOfDay.getTime() + 24 * 60 * 60 * 1000))
      ));

    if (existing) {
      await db.update(campaignMetrics)
        .set({
          impressionsStarted: existing.impressionsStarted + (updates.impressionsStarted || 0),
          impressionsCompleted: existing.impressionsCompleted + (updates.impressionsCompleted || 0),
          surveySubmits: existing.surveySubmits + (updates.surveySubmits || 0),
          updatedAt: new Date(),
        })
        .where(eq(campaignMetrics.id, existing.id));
    } else {
      await db.insert(campaignMetrics).values({
        campaignId,
        date: startOfDay,
        impressionsStarted: updates.impressionsStarted || 0,
        impressionsCompleted: updates.impressionsCompleted || 0,
        surveySubmits: updates.surveySubmits || 0,
      });
    }
  }

  async pauseCampaignIfBudgetExhausted(campaignId: string): Promise<void> {
    const campaign = await this.getCampaignById(campaignId);
    if (!campaign) return;

    const totalSpent = parseFloat(campaign.totalSpent || "0");
    const totalBudget = parseFloat(campaign.totalBudget);

    // Check if budget is 99%+ exhausted
    if (totalSpent >= totalBudget * 0.99) {
      await db.update(campaigns)
        .set({ status: "paused" })
        .where(eq(campaigns.id, campaignId));
    }
  }
}

export const storage = new DatabaseStorage();
