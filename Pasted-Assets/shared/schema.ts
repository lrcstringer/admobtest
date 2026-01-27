import { sql, relations } from "drizzle-orm";
import { pgTable, text, varchar, integer, decimal, timestamp, boolean, pgEnum, json } from "drizzle-orm/pg-core";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { z } from "zod";

// Enums
export const walletTypeEnum = pgEnum("wallet_type", ["main", "brand"]);
export const transactionTypeEnum = pgEnum("transaction_type", ["earn", "send", "receive", "purchase", "referral_bonus", "pot_win"]);
export const transactionStatusEnum = pgEnum("transaction_status", ["pending", "completed", "failed"]);
export const moneyChatDirectionEnum = pgEnum("money_chat_direction", ["sent", "received", "request_in", "request_out"]);
export const purchaseTypeEnum = pgEnum("purchase_type", ["airtime", "data", "electricity"]);
export const referralStatusEnum = pgEnum("referral_status", ["invited", "joined"]);

// New enums for advertiser portal
export const userRoleEnum = pgEnum("user_role", ["user", "advertiser", "super_admin"]);
export const advertiserOrgRoleEnum = pgEnum("advertiser_org_role", ["org_admin", "campaign_manager", "analyst"]);
export const topUpStatusEnum = pgEnum("top_up_status", ["pending", "under_review", "cleared", "rejected"]);
export const campaignStatusEnum = pgEnum("campaign_status", ["draft", "pending_review", "approved", "rejected", "active", "paused", "completed", "cancelled"]);
export const creativeTypeEnum = pgEnum("creative_type", ["video", "image"]);
export const creativeStatusEnum = pgEnum("creative_status", ["pending", "approved", "rejected"]);

// Users Table (extended with role)
export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  username: text("username").notNull().unique(),
  password: text("password").notNull(),
  phoneNumber: text("phone_number").notNull().unique(),
  email: text("email"),
  firstName: text("first_name"),
  lastName: text("last_name"),
  role: userRoleEnum("role").notNull().default("user"),
  emailVerified: boolean("email_verified").notNull().default(false),
  currentStreak: integer("current_streak").notNull().default(0),
  lastActiveDate: timestamp("last_active_date"),
  totalEarnings: decimal("total_earnings", { precision: 10, scale: 2 }).notNull().default("0"),
  // Targeting data for campaign matching
  dateOfBirth: timestamp("date_of_birth"),
  gender: text("gender"),
  province: text("province"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Wallets Table
export const wallets = pgTable("wallets", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  name: text("name").notNull(),
  type: walletTypeEnum("type").notNull().default("main"),
  balanceTokens: integer("balance_tokens").notNull().default(0),
  balanceZar: decimal("balance_zar", { precision: 10, scale: 2 }).notNull().default("0"),
  brandId: text("brand_id"),
  canWithdraw: boolean("can_withdraw").notNull().default(true),
  color: text("color"),
  icon: text("icon"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Transactions Table
export const transactions = pgTable("transactions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  walletId: varchar("wallet_id").references(() => wallets.id, { onDelete: "set null" }),
  type: transactionTypeEnum("type").notNull(),
  amount: decimal("amount", { precision: 10, scale: 2 }).notNull(),
  currency: text("currency").notNull().default("ZAR"),
  status: transactionStatusEnum("status").notNull().default("completed"),
  description: text("description"),
  metadata: text("metadata"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Contacts Table
export const contacts = pgTable("contacts", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  contactUserId: varchar("contact_user_id").references(() => users.id, { onDelete: "cascade" }),
  name: text("name").notNull(),
  phoneNumber: text("phone_number").notNull(),
  isOnImaliChat: boolean("is_on_imali_chat").notNull().default(false),
  blocked: boolean("blocked").notNull().default(false),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Money Chat Threads Table
export const moneyChatThreads = pgTable("money_chat_threads", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  contactId: varchar("contact_id").notNull().references(() => contacts.id, { onDelete: "cascade" }),
  lastMessage: text("last_message"),
  unreadCount: integer("unread_count").notNull().default(0),
  lastUpdatedAt: timestamp("last_updated_at").notNull().defaultNow(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Money Chat Entries Table
export const moneyChatEntries = pgTable("money_chat_entries", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  threadId: varchar("thread_id").notNull().references(() => moneyChatThreads.id, { onDelete: "cascade" }),
  direction: moneyChatDirectionEnum("direction").notNull(),
  amount: decimal("amount", { precision: 10, scale: 2 }).notNull(),
  currency: text("currency").notNull().default("ZAR"),
  status: transactionStatusEnum("status").notNull().default("pending"),
  note: text("note"),
  transactionId: varchar("transaction_id").references(() => transactions.id, { onDelete: "set null" }),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Referrals Table
export const referrals = pgTable("referrals", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  referrerId: varchar("referrer_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  referredUserId: varchar("referred_user_id").references(() => users.id, { onDelete: "cascade" }),
  referredPhoneNumber: text("referred_phone_number").notNull(),
  status: referralStatusEnum("status").notNull().default("invited"),
  earningsReferrer: decimal("earnings_referrer", { precision: 10, scale: 2 }).notNull().default("0"),
  earningsReferred: decimal("earnings_referred", { precision: 10, scale: 2 }).notNull().default("0"),
  assistScore: integer("assist_score").notNull().default(0),
  invitedAt: timestamp("invited_at").notNull().defaultNow(),
  joinedAt: timestamp("joined_at"),
});

// Earn Threads Table (Brand chat threads for surveys/ads)
export const earnThreads = pgTable("earn_threads", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  brandId: text("brand_id").notNull(),
  brandName: text("brand_name").notNull(),
  avatarColor: text("avatar_color"),
  avatarImage: text("avatar_image"),
  isPinned: boolean("is_pinned").notNull().default(false),
  isActive: boolean("is_active").notNull().default(true),
  // Link to advertiser org if this is a direct campaign thread
  advertiserOrgId: varchar("advertiser_org_id"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Earn Opportunities Table (Surveys/Ads available in threads)
export const earnOpportunities = pgTable("earn_opportunities", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  threadId: varchar("thread_id").notNull().references(() => earnThreads.id, { onDelete: "cascade" }),
  campaignId: varchar("campaign_id"), // Link to direct campaign if applicable
  title: text("title").notNull(),
  description: text("description"),
  tokenReward: integer("token_reward").notNull(),
  expiresAt: timestamp("expires_at"),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// User Earn Completions Table
export const userEarnCompletions = pgTable("user_earn_completions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  opportunityId: varchar("opportunity_id").notNull().references(() => earnOpportunities.id, { onDelete: "cascade" }),
  campaignId: varchar("campaign_id"), // Link to campaign for billing
  tokensEarned: integer("tokens_earned").notNull(),
  scoreEarned: integer("score_earned").notNull(),
  completedAt: timestamp("completed_at").notNull().defaultNow(),
});

// Leaderboard Scores Table
export const leaderboardScores = pgTable("leaderboard_scores", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  period: text("period").notNull(), // "daily_YYYY-MM-DD" or "weekly_YYYY-WW"
  score: integer("score").notNull().default(0),
  rank: integer("rank"),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

// Prize Pots Table
export const prizePots = pgTable("prize_pots", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  period: text("period").notNull(), // "daily_YYYY-MM-DD" or "weekly_YYYY-WW"
  totalAmount: decimal("total_amount", { precision: 10, scale: 2 }).notNull().default("0"),
  closesAt: timestamp("closes_at").notNull(),
  isDistributed: boolean("is_distributed").notNull().default(false),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Purchases Table
export const purchases = pgTable("purchases", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  walletId: varchar("wallet_id").notNull().references(() => wallets.id, { onDelete: "cascade" }),
  type: purchaseTypeEnum("type").notNull(),
  provider: text("provider"),
  recipientNumber: text("recipient_number"),
  meterNumber: text("meter_number"),
  amount: decimal("amount", { precision: 10, scale: 2 }).notNull(),
  status: transactionStatusEnum("status").notNull().default("completed"),
  token: text("token"), // For electricity purchases
  metadata: text("metadata"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// ============================================
// ADVERTISER PORTAL TABLES
// ============================================

// Advertiser Organizations Table
export const advertiserOrgs = pgTable("advertiser_orgs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  companyName: text("company_name").notNull(),
  brandName: text("brand_name").notNull(),
  vatNumber: text("vat_number"),
  registrationNumber: text("registration_number"),
  billingEmail: text("billing_email").notNull(),
  billingContactName: text("billing_contact_name"),
  billingContactPhone: text("billing_contact_phone"),
  logoUrl: text("logo_url"),
  acceptedTerms: boolean("accepted_terms").notNull().default(false),
  acceptedPopia: boolean("accepted_popia").notNull().default(false),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Advertiser Organization Members Table
export const advertiserOrgMembers = pgTable("advertiser_org_members", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  orgId: varchar("org_id").notNull().references(() => advertiserOrgs.id, { onDelete: "cascade" }),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  role: advertiserOrgRoleEnum("role").notNull().default("analyst"),
  invitedBy: varchar("invited_by").references(() => users.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Advertiser Wallets Table (prepaid funding)
export const advertiserWallets = pgTable("advertiser_wallets", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  orgId: varchar("org_id").notNull().references(() => advertiserOrgs.id, { onDelete: "cascade" }).unique(),
  balanceZar: decimal("balance_zar", { precision: 12, scale: 2 }).notNull().default("0"),
  totalSpent: decimal("total_spent", { precision: 12, scale: 2 }).notNull().default("0"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Advertiser Wallet Top-ups Table (EFT payments)
export const advertiserTopUps = pgTable("advertiser_top_ups", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  walletId: varchar("wallet_id").notNull().references(() => advertiserWallets.id, { onDelete: "cascade" }),
  orgId: varchar("org_id").notNull().references(() => advertiserOrgs.id, { onDelete: "cascade" }),
  amount: decimal("amount", { precision: 12, scale: 2 }).notNull(),
  status: topUpStatusEnum("status").notNull().default("pending"),
  proofOfPaymentUrl: text("proof_of_payment_url"),
  reference: text("reference"),
  reviewedBy: varchar("reviewed_by").references(() => users.id),
  reviewedAt: timestamp("reviewed_at"),
  rejectionReason: text("rejection_reason"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Campaigns Table
export const campaigns = pgTable("campaigns", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  orgId: varchar("org_id").notNull().references(() => advertiserOrgs.id, { onDelete: "cascade" }),
  name: text("name").notNull(),
  status: campaignStatusEnum("status").notNull().default("draft"),
  
  // Dates
  startDate: timestamp("start_date"),
  endDate: timestamp("end_date"),
  
  // Targeting (null = all)
  targetAgeMin: integer("target_age_min"),
  targetAgeMax: integer("target_age_max"),
  targetGenders: text("target_genders").array(), // ["male", "female", "non-binary"]
  targetProvinces: text("target_provinces").array(), // ["gauteng", "western_cape", etc.]
  
  // Budget & Pricing
  cpeZar: decimal("cpe_zar", { precision: 10, scale: 4 }).notNull(), // Cost Per Engagement
  totalBudget: decimal("total_budget", { precision: 12, scale: 2 }).notNull(),
  dailyCap: decimal("daily_cap", { precision: 12, scale: 2 }), // Optional daily spending cap
  frequencyCapPerUser: integer("frequency_cap_per_user").notNull().default(2), // Per user per day
  pacing: text("pacing").notNull().default("even"), // "even" or "accelerated"
  
  // Spending tracking
  totalSpent: decimal("total_spent", { precision: 12, scale: 2 }).notNull().default("0"),
  todaySpent: decimal("today_spent", { precision: 12, scale: 2 }).notNull().default("0"),
  lastSpendResetDate: timestamp("last_spend_reset_date"),
  
  // Review
  reviewedBy: varchar("reviewed_by").references(() => users.id),
  reviewedAt: timestamp("reviewed_at"),
  rejectionReason: text("rejection_reason"),
  
  createdBy: varchar("created_by").references(() => users.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

// Campaign Creatives Table (video or image)
export const campaignCreatives = pgTable("campaign_creatives", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  campaignId: varchar("campaign_id").notNull().references(() => campaigns.id, { onDelete: "cascade" }),
  type: creativeTypeEnum("type").notNull(),
  fileUrl: text("file_url").notNull(),
  fileName: text("file_name"),
  fileSizeBytes: integer("file_size_bytes"),
  durationSeconds: integer("duration_seconds"), // For video
  width: integer("width"),
  height: integer("height"),
  status: creativeStatusEnum("status").notNull().default("pending"),
  reviewedBy: varchar("reviewed_by").references(() => users.id),
  reviewedAt: timestamp("reviewed_at"),
  rejectionReason: text("rejection_reason"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Campaign Survey Questions Table (MCQ questions)
export const campaignSurveyQuestions = pgTable("campaign_survey_questions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  campaignId: varchar("campaign_id").notNull().references(() => campaigns.id, { onDelete: "cascade" }),
  questionText: text("question_text").notNull(),
  options: text("options").array().notNull(), // Array of answer options (max 4)
  orderIndex: integer("order_index").notNull().default(0),
  isRequired: boolean("is_required").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Campaign Survey Responses Table (user answers)
export const campaignSurveyResponses = pgTable("campaign_survey_responses", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  questionId: varchar("question_id").notNull().references(() => campaignSurveyQuestions.id, { onDelete: "cascade" }),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  campaignId: varchar("campaign_id").notNull().references(() => campaigns.id, { onDelete: "cascade" }),
  selectedOption: integer("selected_option").notNull(), // Index of selected option
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// Campaign Metrics Table (daily aggregates)
export const campaignMetrics = pgTable("campaign_metrics", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  campaignId: varchar("campaign_id").notNull().references(() => campaigns.id, { onDelete: "cascade" }),
  date: timestamp("date").notNull(), // SAST date
  impressionsStarted: integer("impressions_started").notNull().default(0),
  impressionsCompleted: integer("impressions_completed").notNull().default(0),
  surveySubmits: integer("survey_submits").notNull().default(0),
  spendZar: decimal("spend_zar", { precision: 12, scale: 2 }).notNull().default("0"),
  tokensDistributed: integer("tokens_distributed").notNull().default(0),
  
  // Demographic breakdowns (JSON for flexibility)
  ageBreakdown: text("age_breakdown"), // JSON: { "18-24": 100, "25-34": 200, ... }
  genderBreakdown: text("gender_breakdown"), // JSON: { "male": 150, "female": 180, ... }
  provinceBreakdown: text("province_breakdown"), // JSON: { "gauteng": 200, ... }
  
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

// Campaign User Frequency Table (track impressions per user per campaign per day)
export const campaignUserFrequency = pgTable("campaign_user_frequency", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  campaignId: varchar("campaign_id").notNull().references(() => campaigns.id, { onDelete: "cascade" }),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  date: timestamp("date").notNull(), // SAST date
  impressionCount: integer("impression_count").notNull().default(0),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// System Settings Table (for super admin configuration)
export const systemSettings = pgTable("system_settings", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  key: text("key").notNull().unique(),
  value: text("value").notNull(),
  description: text("description"),
  updatedBy: varchar("updated_by").references(() => users.id),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

// ============================================
// RELATIONS
// ============================================

export const usersRelations = relations(users, ({ many }) => ({
  wallets: many(wallets),
  transactions: many(transactions),
  contacts: many(contacts),
  referralsGiven: many(referrals, { relationName: "referrer" }),
  referralsReceived: many(referrals, { relationName: "referred" }),
  earnCompletions: many(userEarnCompletions),
  leaderboardScores: many(leaderboardScores),
  purchases: many(purchases),
  moneyChatThreads: many(moneyChatThreads),
  advertiserOrgMemberships: many(advertiserOrgMembers),
}));

export const walletsRelations = relations(wallets, ({ one, many }) => ({
  user: one(users, {
    fields: [wallets.userId],
    references: [users.id],
  }),
  transactions: many(transactions),
  purchases: many(purchases),
}));

export const transactionsRelations = relations(transactions, ({ one }) => ({
  user: one(users, {
    fields: [transactions.userId],
    references: [users.id],
  }),
  wallet: one(wallets, {
    fields: [transactions.walletId],
    references: [wallets.id],
  }),
}));

export const contactsRelations = relations(contacts, ({ one, many }) => ({
  user: one(users, {
    fields: [contacts.userId],
    references: [users.id],
  }),
  contactUser: one(users, {
    fields: [contacts.contactUserId],
    references: [users.id],
  }),
  moneyChatThreads: many(moneyChatThreads),
}));

export const moneyChatThreadsRelations = relations(moneyChatThreads, ({ one, many }) => ({
  user: one(users, {
    fields: [moneyChatThreads.userId],
    references: [users.id],
  }),
  contact: one(contacts, {
    fields: [moneyChatThreads.contactId],
    references: [contacts.id],
  }),
  entries: many(moneyChatEntries),
}));

export const moneyChatEntriesRelations = relations(moneyChatEntries, ({ one }) => ({
  thread: one(moneyChatThreads, {
    fields: [moneyChatEntries.threadId],
    references: [moneyChatThreads.id],
  }),
  transaction: one(transactions, {
    fields: [moneyChatEntries.transactionId],
    references: [transactions.id],
  }),
}));

export const referralsRelations = relations(referrals, ({ one }) => ({
  referrer: one(users, {
    fields: [referrals.referrerId],
    references: [users.id],
    relationName: "referrer",
  }),
  referredUser: one(users, {
    fields: [referrals.referredUserId],
    references: [users.id],
    relationName: "referred",
  }),
}));

export const earnThreadsRelations = relations(earnThreads, ({ one, many }) => ({
  opportunities: many(earnOpportunities),
  advertiserOrg: one(advertiserOrgs, {
    fields: [earnThreads.advertiserOrgId],
    references: [advertiserOrgs.id],
  }),
}));

export const earnOpportunitiesRelations = relations(earnOpportunities, ({ one, many }) => ({
  thread: one(earnThreads, {
    fields: [earnOpportunities.threadId],
    references: [earnThreads.id],
  }),
  campaign: one(campaigns, {
    fields: [earnOpportunities.campaignId],
    references: [campaigns.id],
  }),
  completions: many(userEarnCompletions),
}));

export const userEarnCompletionsRelations = relations(userEarnCompletions, ({ one }) => ({
  user: one(users, {
    fields: [userEarnCompletions.userId],
    references: [users.id],
  }),
  opportunity: one(earnOpportunities, {
    fields: [userEarnCompletions.opportunityId],
    references: [earnOpportunities.id],
  }),
  campaign: one(campaigns, {
    fields: [userEarnCompletions.campaignId],
    references: [campaigns.id],
  }),
}));

export const leaderboardScoresRelations = relations(leaderboardScores, ({ one }) => ({
  user: one(users, {
    fields: [leaderboardScores.userId],
    references: [users.id],
  }),
}));

export const purchasesRelations = relations(purchases, ({ one }) => ({
  user: one(users, {
    fields: [purchases.userId],
    references: [users.id],
  }),
  wallet: one(wallets, {
    fields: [purchases.walletId],
    references: [wallets.id],
  }),
}));

// Advertiser Portal Relations
export const advertiserOrgsRelations = relations(advertiserOrgs, ({ one, many }) => ({
  members: many(advertiserOrgMembers),
  wallet: one(advertiserWallets),
  campaigns: many(campaigns),
  topUps: many(advertiserTopUps),
  earnThreads: many(earnThreads),
}));

export const advertiserOrgMembersRelations = relations(advertiserOrgMembers, ({ one }) => ({
  org: one(advertiserOrgs, {
    fields: [advertiserOrgMembers.orgId],
    references: [advertiserOrgs.id],
  }),
  user: one(users, {
    fields: [advertiserOrgMembers.userId],
    references: [users.id],
  }),
  invitedByUser: one(users, {
    fields: [advertiserOrgMembers.invitedBy],
    references: [users.id],
  }),
}));

export const advertiserWalletsRelations = relations(advertiserWallets, ({ one, many }) => ({
  org: one(advertiserOrgs, {
    fields: [advertiserWallets.orgId],
    references: [advertiserOrgs.id],
  }),
  topUps: many(advertiserTopUps),
}));

export const advertiserTopUpsRelations = relations(advertiserTopUps, ({ one }) => ({
  wallet: one(advertiserWallets, {
    fields: [advertiserTopUps.walletId],
    references: [advertiserWallets.id],
  }),
  org: one(advertiserOrgs, {
    fields: [advertiserTopUps.orgId],
    references: [advertiserOrgs.id],
  }),
  reviewer: one(users, {
    fields: [advertiserTopUps.reviewedBy],
    references: [users.id],
  }),
}));

export const campaignsRelations = relations(campaigns, ({ one, many }) => ({
  org: one(advertiserOrgs, {
    fields: [campaigns.orgId],
    references: [advertiserOrgs.id],
  }),
  creatives: many(campaignCreatives),
  surveyQuestions: many(campaignSurveyQuestions),
  metrics: many(campaignMetrics),
  userFrequencies: many(campaignUserFrequency),
  surveyResponses: many(campaignSurveyResponses),
  opportunities: many(earnOpportunities),
  creator: one(users, {
    fields: [campaigns.createdBy],
    references: [users.id],
  }),
  reviewer: one(users, {
    fields: [campaigns.reviewedBy],
    references: [users.id],
  }),
}));

export const campaignCreativesRelations = relations(campaignCreatives, ({ one }) => ({
  campaign: one(campaigns, {
    fields: [campaignCreatives.campaignId],
    references: [campaigns.id],
  }),
  reviewer: one(users, {
    fields: [campaignCreatives.reviewedBy],
    references: [users.id],
  }),
}));

export const campaignSurveyQuestionsRelations = relations(campaignSurveyQuestions, ({ one, many }) => ({
  campaign: one(campaigns, {
    fields: [campaignSurveyQuestions.campaignId],
    references: [campaigns.id],
  }),
  responses: many(campaignSurveyResponses),
}));

export const campaignSurveyResponsesRelations = relations(campaignSurveyResponses, ({ one }) => ({
  question: one(campaignSurveyQuestions, {
    fields: [campaignSurveyResponses.questionId],
    references: [campaignSurveyQuestions.id],
  }),
  user: one(users, {
    fields: [campaignSurveyResponses.userId],
    references: [users.id],
  }),
  campaign: one(campaigns, {
    fields: [campaignSurveyResponses.campaignId],
    references: [campaigns.id],
  }),
}));

export const campaignMetricsRelations = relations(campaignMetrics, ({ one }) => ({
  campaign: one(campaigns, {
    fields: [campaignMetrics.campaignId],
    references: [campaigns.id],
  }),
}));

export const campaignUserFrequencyRelations = relations(campaignUserFrequency, ({ one }) => ({
  campaign: one(campaigns, {
    fields: [campaignUserFrequency.campaignId],
    references: [campaigns.id],
  }),
  user: one(users, {
    fields: [campaignUserFrequency.userId],
    references: [users.id],
  }),
}));

// ============================================
// INSERT SCHEMAS
// ============================================

export const insertUserSchema = createInsertSchema(users).omit({
  id: true,
  currentStreak: true,
  lastActiveDate: true,
  totalEarnings: true,
  createdAt: true,
});

export const insertWalletSchema = createInsertSchema(wallets).omit({
  id: true,
  createdAt: true,
});

export const insertTransactionSchema = createInsertSchema(transactions).omit({
  id: true,
  createdAt: true,
});

export const insertContactSchema = createInsertSchema(contacts).omit({
  id: true,
  createdAt: true,
});

export const insertMoneyChatThreadSchema = createInsertSchema(moneyChatThreads).omit({
  id: true,
  createdAt: true,
});

export const insertMoneyChatEntrySchema = createInsertSchema(moneyChatEntries).omit({
  id: true,
  createdAt: true,
});

export const insertReferralSchema = createInsertSchema(referrals).omit({
  id: true,
  invitedAt: true,
  joinedAt: true,
});

export const insertEarnThreadSchema = createInsertSchema(earnThreads).omit({
  id: true,
  createdAt: true,
});

export const insertEarnOpportunitySchema = createInsertSchema(earnOpportunities).omit({
  id: true,
  createdAt: true,
});

export const insertUserEarnCompletionSchema = createInsertSchema(userEarnCompletions).omit({
  id: true,
  completedAt: true,
});

export const insertLeaderboardScoreSchema = createInsertSchema(leaderboardScores).omit({
  id: true,
  updatedAt: true,
});

export const insertPrizePotSchema = createInsertSchema(prizePots).omit({
  id: true,
  createdAt: true,
});

export const insertPurchaseSchema = createInsertSchema(purchases).omit({
  id: true,
  createdAt: true,
});

// Advertiser Portal Insert Schemas
export const insertAdvertiserOrgSchema = createInsertSchema(advertiserOrgs).omit({
  id: true,
  createdAt: true,
});

export const insertAdvertiserOrgMemberSchema = createInsertSchema(advertiserOrgMembers).omit({
  id: true,
  createdAt: true,
});

export const insertAdvertiserWalletSchema = createInsertSchema(advertiserWallets).omit({
  id: true,
  createdAt: true,
});

export const insertAdvertiserTopUpSchema = createInsertSchema(advertiserTopUps).omit({
  id: true,
  createdAt: true,
});

export const insertCampaignSchema = createInsertSchema(campaigns).omit({
  id: true,
  totalSpent: true,
  todaySpent: true,
  createdAt: true,
  updatedAt: true,
});

export const insertCampaignCreativeSchema = createInsertSchema(campaignCreatives).omit({
  id: true,
  createdAt: true,
});

export const insertCampaignSurveyQuestionSchema = createInsertSchema(campaignSurveyQuestions).omit({
  id: true,
  createdAt: true,
});

export const insertCampaignSurveyResponseSchema = createInsertSchema(campaignSurveyResponses).omit({
  id: true,
  createdAt: true,
});

export const insertCampaignMetricsSchema = createInsertSchema(campaignMetrics).omit({
  id: true,
  createdAt: true,
  updatedAt: true,
});

export const insertCampaignUserFrequencySchema = createInsertSchema(campaignUserFrequency).omit({
  id: true,
  createdAt: true,
});

export const insertSystemSettingSchema = createInsertSchema(systemSettings).omit({
  id: true,
  updatedAt: true,
});

// ============================================
// TYPES
// ============================================

export type InsertUser = z.infer<typeof insertUserSchema>;
export type User = typeof users.$inferSelect;

export type InsertWallet = z.infer<typeof insertWalletSchema>;
export type Wallet = typeof wallets.$inferSelect;

export type InsertTransaction = z.infer<typeof insertTransactionSchema>;
export type Transaction = typeof transactions.$inferSelect;

export type InsertContact = z.infer<typeof insertContactSchema>;
export type Contact = typeof contacts.$inferSelect;

export type InsertMoneyChatThread = z.infer<typeof insertMoneyChatThreadSchema>;
export type MoneyChatThread = typeof moneyChatThreads.$inferSelect;

export type InsertMoneyChatEntry = z.infer<typeof insertMoneyChatEntrySchema>;
export type MoneyChatEntry = typeof moneyChatEntries.$inferSelect;

export type InsertReferral = z.infer<typeof insertReferralSchema>;
export type Referral = typeof referrals.$inferSelect;

export type InsertEarnThread = z.infer<typeof insertEarnThreadSchema>;
export type EarnThread = typeof earnThreads.$inferSelect;

export type InsertEarnOpportunity = z.infer<typeof insertEarnOpportunitySchema>;
export type EarnOpportunity = typeof earnOpportunities.$inferSelect;

export type InsertUserEarnCompletion = z.infer<typeof insertUserEarnCompletionSchema>;
export type UserEarnCompletion = typeof userEarnCompletions.$inferSelect;

export type InsertLeaderboardScore = z.infer<typeof insertLeaderboardScoreSchema>;
export type LeaderboardScore = typeof leaderboardScores.$inferSelect;

export type InsertPrizePot = z.infer<typeof insertPrizePotSchema>;
export type PrizePot = typeof prizePots.$inferSelect;

export type InsertPurchase = z.infer<typeof insertPurchaseSchema>;
export type Purchase = typeof purchases.$inferSelect;

// Advertiser Portal Types
export type InsertAdvertiserOrg = z.infer<typeof insertAdvertiserOrgSchema>;
export type AdvertiserOrg = typeof advertiserOrgs.$inferSelect;

export type InsertAdvertiserOrgMember = z.infer<typeof insertAdvertiserOrgMemberSchema>;
export type AdvertiserOrgMember = typeof advertiserOrgMembers.$inferSelect;

export type InsertAdvertiserWallet = z.infer<typeof insertAdvertiserWalletSchema>;
export type AdvertiserWallet = typeof advertiserWallets.$inferSelect;

export type InsertAdvertiserTopUp = z.infer<typeof insertAdvertiserTopUpSchema>;
export type AdvertiserTopUp = typeof advertiserTopUps.$inferSelect;

export type InsertCampaign = z.infer<typeof insertCampaignSchema>;
export type Campaign = typeof campaigns.$inferSelect;

export type InsertCampaignCreative = z.infer<typeof insertCampaignCreativeSchema>;
export type CampaignCreative = typeof campaignCreatives.$inferSelect;

export type InsertCampaignSurveyQuestion = z.infer<typeof insertCampaignSurveyQuestionSchema>;
export type CampaignSurveyQuestion = typeof campaignSurveyQuestions.$inferSelect;

export type InsertCampaignSurveyResponse = z.infer<typeof insertCampaignSurveyResponseSchema>;
export type CampaignSurveyResponse = typeof campaignSurveyResponses.$inferSelect;

export type InsertCampaignMetrics = z.infer<typeof insertCampaignMetricsSchema>;
export type CampaignMetrics = typeof campaignMetrics.$inferSelect;

export type InsertCampaignUserFrequency = z.infer<typeof insertCampaignUserFrequencySchema>;
export type CampaignUserFrequency = typeof campaignUserFrequency.$inferSelect;

export type InsertSystemSetting = z.infer<typeof insertSystemSettingSchema>;
export type SystemSetting = typeof systemSettings.$inferSelect;
