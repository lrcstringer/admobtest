import type { Express, Request, Response, NextFunction } from "express";
import { createServer, type Server } from "http";
import { storage } from "./storage";
import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";
import session from "express-session";
import bcrypt from "bcrypt";
import { z } from "zod";
import { insertUserSchema, insertContactSchema, type User } from "@shared/schema";
import adminRoutes from "./routes/admin";

// Extend Express User type for TypeScript
declare global {
  namespace Express {
    interface User {
      id: string;
      username: string;
      phoneNumber: string;
      email?: string | null;
      firstName: string | null;
      lastName: string | null;
      role: "user" | "advertiser" | "super_admin";
      currentStreak: number;
      lastActiveDate: Date | null;
      totalEarnings: string;
      createdAt: Date;
    }
  }
}

// Helper function to calculate period strings
function getDailyPeriod(date: Date = new Date()): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `daily_${year}-${month}-${day}`;
}

function getWeeklyPeriod(date: Date = new Date()): string {
  const year = date.getFullYear();
  const onejan = new Date(year, 0, 1);
  const week = Math.ceil((((date.getTime() - onejan.getTime()) / 86400000) + onejan.getDay() + 1) / 7);
  return `weekly_${year}-${String(week).padStart(2, '0')}`;
}

// Helper function to generate 20-digit electricity token
function generateElectricityToken(): string {
  let token = '';
  for (let i = 0; i < 20; i++) {
    token += Math.floor(Math.random() * 10);
  }
  return token;
}

// Helper function to calculate greeting based on time
function getGreeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return "Good Morning";
  if (hour < 18) return "Good Afternoon";
  return "Good Evening";
}

// Authentication middleware
function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.status(401).json({ message: "Unauthorized" });
}

export async function registerRoutes(
  httpServer: Server,
  app: Express
): Promise<Server> {
  // Configure Passport Local Strategy
  passport.use(
    new LocalStrategy(async (username, password, done) => {
      try {
        const user = await storage.getUserByUsername(username);
        if (!user) {
          return done(null, false, { message: "Invalid credentials" });
        }

        const isValid = await bcrypt.compare(password, user.password);
        if (!isValid) {
          return done(null, false, { message: "Invalid credentials" });
        }

        return done(null, user);
      } catch (error) {
        return done(error);
      }
    })
  );

  passport.serializeUser((user, done) => {
    done(null, user.id);
  });

  passport.deserializeUser(async (id: string, done) => {
    try {
      const user = await storage.getUser(id);
      done(null, user || false);
    } catch (error) {
      done(error);
    }
  });

  // Session middleware
  app.use(
    session({
      secret: process.env.SESSION_SECRET || "imali-chat-secret-key-change-in-production",
      resave: false,
      saveUninitialized: false,
      cookie: {
        maxAge: 1000 * 60 * 60 * 24 * 7, // 1 week
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
      },
    })
  );

  app.use(passport.initialize());
  app.use(passport.session());

  // Register admin routes
  app.use("/api/admin", adminRoutes);

  // ===== AUTH ROUTES =====

  // Register
  app.post("/api/auth/register", async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        username: z.string().min(3),
        password: z.string().min(6),
        phoneNumber: z.string().min(10),
        firstName: z.string().optional(),
        lastName: z.string().optional(),
      });

      const data = schema.parse(req.body);

      // Check if username already exists
      const existingUser = await storage.getUserByUsername(data.username);
      if (existingUser) {
        return res.status(400).json({ message: "Username already exists" });
      }

      // Check if phone number already exists
      const existingPhone = await storage.getUserByPhoneNumber(data.phoneNumber);
      if (existingPhone) {
        return res.status(400).json({ message: "Phone number already registered" });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(data.password, 10);

      // Create user
      const user = await storage.createUser({
        username: data.username,
        password: hashedPassword,
        phoneNumber: data.phoneNumber,
        firstName: data.firstName || null,
        lastName: data.lastName || null,
      });

      // Log in the user
      req.login(user, (err) => {
        if (err) {
          return res.status(500).json({ message: "Error logging in after registration" });
        }
        const { password, ...userWithoutPassword } = user;
        res.status(201).json(userWithoutPassword);
      });
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Registration error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Login
  app.post("/api/auth/login", (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate("local", (err: any, user: User | false, info: any) => {
      if (err) {
        return res.status(500).json({ message: "Internal server error" });
      }
      if (!user) {
        return res.status(401).json({ message: info?.message || "Invalid credentials" });
      }
      req.login(user, (loginErr) => {
        if (loginErr) {
          return res.status(500).json({ message: "Error during login" });
        }
        const { password, ...userWithoutPassword } = user;
        res.json(userWithoutPassword);
      });
    })(req, res, next);
  });

  // Logout
  app.post("/api/auth/logout", (req: Request, res: Response) => {
    req.logout((err) => {
      if (err) {
        return res.status(500).json({ message: "Error during logout" });
      }
      res.json({ message: "Logged out successfully" });
    });
  });

  // Get current user
  app.get("/api/auth/me", requireAuth, (req: Request, res: Response) => {
    if (req.user) {
      const { password, ...userWithoutPassword } = req.user as any;
      res.json(userWithoutPassword);
    } else {
      res.status(401).json({ message: "Not authenticated" });
    }
  });

  // ===== USER & WALLET ROUTES =====

  // Get user profile
  app.get("/api/user/profile", requireAuth, async (req: Request, res: Response) => {
    try {
      const user = await storage.getUser(req.user!.id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      const { password, ...userWithoutPassword } = user;
      res.json(userWithoutPassword);
    } catch (error) {
      console.error("Get profile error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Update user profile
  app.patch("/api/user/profile", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        firstName: z.string().optional(),
        lastName: z.string().optional(),
      });

      const data = schema.parse(req.body);
      const user = await storage.updateUser(req.user!.id, data);
      
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      const { password, ...userWithoutPassword } = user;
      res.json(userWithoutPassword);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Update profile error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get all wallets
  app.get("/api/wallets", requireAuth, async (req: Request, res: Response) => {
    try {
      const wallets = await storage.getWalletsByUserId(req.user!.id);
      res.json(wallets);
    } catch (error) {
      console.error("Get wallets error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get specific wallet
  app.get("/api/wallets/:id", requireAuth, async (req: Request, res: Response) => {
    try {
      const wallet = await storage.getWalletById(req.params.id);
      if (!wallet) {
        return res.status(404).json({ message: "Wallet not found" });
      }
      if (wallet.userId !== req.user!.id) {
        return res.status(403).json({ message: "Forbidden" });
      }
      res.json(wallet);
    } catch (error) {
      console.error("Get wallet error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get transactions
  app.get("/api/transactions", requireAuth, async (req: Request, res: Response) => {
    try {
      const limit = req.query.limit ? parseInt(req.query.limit as string) : 50;
      const transactions = await storage.getTransactionsByUserId(req.user!.id, limit);
      res.json(transactions);
    } catch (error) {
      console.error("Get transactions error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== CONTACTS & MONEY CHAT ROUTES =====

  // Sync contacts
  app.post("/api/contacts/sync", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        contacts: z.array(z.object({
          name: z.string(),
          phoneNumber: z.string(),
        })),
      });

      const { contacts } = schema.parse(req.body);
      const syncedContacts = [];

      for (const contact of contacts) {
        // Check if contact already exists
        const existingContacts = await storage.getContactsByUserId(req.user!.id);
        const existing = existingContacts.find(c => c.phoneNumber === contact.phoneNumber);
        
        if (!existing) {
          // Check if phone number is registered on iMaliChat
          const contactUser = await storage.getUserByPhoneNumber(contact.phoneNumber);
          
          const newContact = await storage.createContact({
            userId: req.user!.id,
            contactUserId: contactUser?.id || null,
            name: contact.name,
            phoneNumber: contact.phoneNumber,
            isOnImaliChat: !!contactUser,
            blocked: false,
          });
          syncedContacts.push(newContact);
        } else {
          syncedContacts.push(existing);
        }
      }

      res.status(201).json(syncedContacts);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Sync contacts error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get all contacts
  app.get("/api/contacts", requireAuth, async (req: Request, res: Response) => {
    try {
      const contacts = await storage.getContactsByUserId(req.user!.id);
      res.json(contacts);
    } catch (error) {
      console.error("Get contacts error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Block contact
  app.post("/api/contacts/:id/block", requireAuth, async (req: Request, res: Response) => {
    try {
      const contact = await storage.getContactById(req.params.id);
      if (!contact) {
        return res.status(404).json({ message: "Contact not found" });
      }
      if (contact.userId !== req.user!.id) {
        return res.status(403).json({ message: "Forbidden" });
      }

      const blockedContact = await storage.blockContact(req.params.id);
      res.json(blockedContact);
    } catch (error) {
      console.error("Block contact error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Unblock contact
  app.post("/api/contacts/:id/unblock", requireAuth, async (req: Request, res: Response) => {
    try {
      const contact = await storage.getContactById(req.params.id);
      if (!contact) {
        return res.status(404).json({ message: "Contact not found" });
      }
      if (contact.userId !== req.user!.id) {
        return res.status(403).json({ message: "Forbidden" });
      }

      const unblockedContact = await storage.unblockContact(req.params.id);
      res.json(unblockedContact);
    } catch (error) {
      console.error("Unblock contact error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get all money chat threads
  app.get("/api/money-chat/threads", requireAuth, async (req: Request, res: Response) => {
    try {
      const threads = await storage.getMoneyChatThreadsByUserId(req.user!.id);
      res.json(threads);
    } catch (error) {
      console.error("Get money chat threads error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get thread with entries for specific contact
  app.get("/api/money-chat/threads/:contactId", requireAuth, async (req: Request, res: Response) => {
    try {
      const contact = await storage.getContactById(req.params.contactId);
      if (!contact) {
        return res.status(404).json({ message: "Contact not found" });
      }
      if (contact.userId !== req.user!.id) {
        return res.status(403).json({ message: "Forbidden" });
      }

      let thread = await storage.getMoneyChatThreadByContactId(req.user!.id, req.params.contactId);
      
      // Create thread if it doesn't exist
      if (!thread) {
        thread = await storage.createMoneyChatThread({
          userId: req.user!.id,
          contactId: req.params.contactId,
          lastMessage: null,
          unreadCount: 0,
          lastUpdatedAt: new Date(),
        });
      }

      const entries = await storage.getMoneyChatEntriesByThreadId(thread.id);
      
      res.json({
        thread,
        entries,
      });
    } catch (error) {
      console.error("Get money chat thread error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Send money
  app.post("/api/money-chat/send", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        contactId: z.string(),
        amount: z.string(),
        note: z.string().optional(),
        walletId: z.string(),
      });

      const data = schema.parse(req.body);
      
      // Verify contact exists and belongs to user
      const contact = await storage.getContactById(data.contactId);
      if (!contact || contact.userId !== req.user!.id) {
        return res.status(404).json({ message: "Contact not found" });
      }

      // Verify wallet and sufficient balance
      const wallet = await storage.getWalletById(data.walletId);
      if (!wallet || wallet.userId !== req.user!.id) {
        return res.status(404).json({ message: "Wallet not found" });
      }

      const amountNum = parseFloat(data.amount);
      const walletBalanceNum = parseFloat(wallet.balanceZar);
      
      if (walletBalanceNum < amountNum) {
        return res.status(400).json({ message: "Insufficient balance" });
      }

      // Get or create thread
      let thread = await storage.getMoneyChatThreadByContactId(req.user!.id, data.contactId);
      if (!thread) {
        thread = await storage.createMoneyChatThread({
          userId: req.user!.id,
          contactId: data.contactId,
          lastMessage: null,
          unreadCount: 0,
          lastUpdatedAt: new Date(),
        });
      }

      // Create transaction
      const transaction = await storage.createTransaction({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "send",
        amount: data.amount,
        currency: "ZAR",
        status: "completed",
        description: `Sent to ${contact.name}`,
        metadata: JSON.stringify({ contactId: data.contactId, note: data.note }),
      });

      // Update wallet balance
      await storage.updateWallet(data.walletId, {
        balanceZar: (walletBalanceNum - amountNum).toFixed(2),
      });

      // Create money chat entry
      const entry = await storage.createMoneyChatEntry({
        threadId: thread.id,
        direction: "sent",
        amount: data.amount,
        currency: "ZAR",
        status: "completed",
        note: data.note || null,
        transactionId: transaction.id,
      });

      // Update thread
      await storage.updateMoneyChatThread(thread.id, {
        lastMessage: `Sent R${data.amount}`,
        lastUpdatedAt: new Date(),
      });

      res.status(201).json(entry);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Send money error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Request money
  app.post("/api/money-chat/request", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        contactId: z.string(),
        amount: z.string(),
        note: z.string().optional(),
      });

      const data = schema.parse(req.body);
      
      // Verify contact
      const contact = await storage.getContactById(data.contactId);
      if (!contact || contact.userId !== req.user!.id) {
        return res.status(404).json({ message: "Contact not found" });
      }

      // Get or create thread
      let thread = await storage.getMoneyChatThreadByContactId(req.user!.id, data.contactId);
      if (!thread) {
        thread = await storage.createMoneyChatThread({
          userId: req.user!.id,
          contactId: data.contactId,
          lastMessage: null,
          unreadCount: 0,
          lastUpdatedAt: new Date(),
        });
      }

      // Create money chat entry
      const entry = await storage.createMoneyChatEntry({
        threadId: thread.id,
        direction: "request_out",
        amount: data.amount,
        currency: "ZAR",
        status: "pending",
        note: data.note || null,
        transactionId: null,
      });

      // Update thread
      await storage.updateMoneyChatThread(thread.id, {
        lastMessage: `Requested R${data.amount}`,
        lastUpdatedAt: new Date(),
      });

      res.status(201).json(entry);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Request money error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== EARN ROUTES =====

  // Get all earn threads
  app.get("/api/earn/threads", requireAuth, async (req: Request, res: Response) => {
    try {
      const threads = await storage.getEarnThreads();
      res.json(threads);
    } catch (error) {
      console.error("Get earn threads error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get opportunities for a thread
  app.get("/api/earn/opportunities/:threadId", requireAuth, async (req: Request, res: Response) => {
    try {
      const opportunities = await storage.getEarnOpportunitiesByThreadId(req.params.threadId);
      
      // Filter out already completed opportunities for this user
      const filtered = [];
      for (const opp of opportunities) {
        const completed = await storage.hasUserCompletedOpportunity(req.user!.id, opp.id);
        if (!completed) {
          filtered.push(opp);
        }
      }

      res.json(filtered);
    } catch (error) {
      console.error("Get earn opportunities error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Complete an earn opportunity
  app.post("/api/earn/complete/:opportunityId", requireAuth, async (req: Request, res: Response) => {
    try {
      const opportunity = await storage.getEarnOpportunitiesByThreadId("");
      const opp = opportunity.find(o => o.id === req.params.opportunityId);
      
      if (!opp) {
        return res.status(404).json({ message: "Opportunity not found" });
      }

      // Check if already completed
      const alreadyCompleted = await storage.hasUserCompletedOpportunity(req.user!.id, req.params.opportunityId);
      if (alreadyCompleted) {
        return res.status(400).json({ message: "Opportunity already completed" });
      }

      const tokenReward = opp.tokenReward;
      const tokensToWallet = Math.floor(tokenReward * 0.9); // 90% to wallet
      const tokensToDailyPot = Math.floor(tokenReward * 0.05); // 5% to daily pot
      const tokensToWeeklyPot = tokenReward - tokensToWallet - tokensToDailyPot; // Remaining 5% to weekly pot

      // Get user's main wallet
      const wallets = await storage.getWalletsByUserId(req.user!.id);
      const mainWallet = wallets.find(w => w.type === "main");
      
      if (!mainWallet) {
        return res.status(500).json({ message: "User has no main wallet" });
      }

      // Update wallet balance (tokens)
      const newTokenBalance = mainWallet.balanceTokens + tokensToWallet;
      const zarFromTokens = tokensToWallet / 100; // 100:1 ratio
      const newZarBalance = parseFloat(mainWallet.balanceZar) + zarFromTokens;
      
      await storage.updateWallet(mainWallet.id, {
        balanceTokens: newTokenBalance,
        balanceZar: newZarBalance.toFixed(2),
      });

      // Create transaction
      await storage.createTransaction({
        userId: req.user!.id,
        walletId: mainWallet.id,
        type: "earn",
        amount: zarFromTokens.toFixed(2),
        currency: "ZAR",
        status: "completed",
        description: opp.title,
        metadata: JSON.stringify({ opportunityId: opp.id, tokens: tokensToWallet }),
      });

      // Update user total earnings
      const user = await storage.getUser(req.user!.id);
      if (user) {
        const newTotalEarnings = parseFloat(user.totalEarnings) + zarFromTokens;
        
        // Update streak
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const lastActive = user.lastActiveDate ? new Date(user.lastActiveDate) : null;
        
        let newStreak = user.currentStreak;
        if (lastActive) {
          lastActive.setHours(0, 0, 0, 0);
          const daysDiff = Math.floor((today.getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24));
          
          if (daysDiff === 0) {
            // Same day, keep streak
          } else if (daysDiff === 1) {
            // Consecutive day, increment streak
            newStreak += 1;
          } else {
            // Streak broken, reset to 1
            newStreak = 1;
          }
        } else {
          newStreak = 1;
        }

        await storage.updateUser(req.user!.id, {
          totalEarnings: newTotalEarnings.toFixed(2),
          currentStreak: newStreak,
          lastActiveDate: new Date(),
        });
      }

      // Create completion record
      await storage.createUserEarnCompletion({
        userId: req.user!.id,
        opportunityId: req.params.opportunityId,
        tokensEarned: tokensToWallet,
        scoreEarned: tokensToWallet, // Score equals tokens earned
      });

      // Update leaderboard scores
      const dailyPeriod = getDailyPeriod();
      const weeklyPeriod = getWeeklyPeriod();
      
      const dailyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, dailyPeriod);
      await storage.createOrUpdateLeaderboardScore({
        userId: req.user!.id,
        period: dailyPeriod,
        score: (dailyScore?.score || 0) + tokensToWallet,
        rank: dailyScore?.rank || null,
      });

      const weeklyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, weeklyPeriod);
      await storage.createOrUpdateLeaderboardScore({
        userId: req.user!.id,
        period: weeklyPeriod,
        score: (weeklyScore?.score || 0) + tokensToWallet,
        rank: weeklyScore?.rank || null,
      });

      // Update ranks
      await storage.updateLeaderboardRanks(dailyPeriod);
      await storage.updateLeaderboardRanks(weeklyPeriod);

      // Update prize pots
      const dailyPot = await storage.getPrizePotByPeriod(dailyPeriod);
      const dailyPotZar = tokensToDailyPot / 100;
      const todayEnd = new Date();
      todayEnd.setHours(23, 59, 59, 999);
      
      await storage.createOrUpdatePrizePot({
        period: dailyPeriod,
        totalAmount: ((dailyPot ? parseFloat(dailyPot.totalAmount) : 0) + dailyPotZar).toFixed(2),
        closesAt: todayEnd,
        isDistributed: false,
      });

      const weeklyPot = await storage.getPrizePotByPeriod(weeklyPeriod);
      const weeklyPotZar = tokensToWeeklyPot / 100;
      const weekEnd = new Date();
      weekEnd.setDate(weekEnd.getDate() + (7 - weekEnd.getDay()));
      weekEnd.setHours(23, 59, 59, 999);
      
      await storage.createOrUpdatePrizePot({
        period: weeklyPeriod,
        totalAmount: ((weeklyPot ? parseFloat(weeklyPot.totalAmount) : 0) + weeklyPotZar).toFixed(2),
        closesAt: weekEnd,
        isDistributed: false,
      });

      res.status(201).json({
        tokensEarned: tokensToWallet,
        zarEarned: zarFromTokens.toFixed(2),
        newBalance: newZarBalance.toFixed(2),
      });
    } catch (error) {
      console.error("Complete earn error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== CAMPAIGN DELIVERY ROUTES (Advertiser campaigns for users) =====

  // Get eligible campaigns for current user (waterfall serving)
  app.get("/api/campaigns/eligible", requireAuth, async (req: Request, res: Response) => {
    try {
      const user = await storage.getUser(req.user!.id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      const eligibleCampaigns = await storage.getEligibleCampaignsForUser(user);
      
      // Return campaigns with their creatives and survey questions
      const campaignsWithDetails = await Promise.all(
        eligibleCampaigns.map(async (campaign) => {
          const creatives = await storage.getCampaignCreatives(campaign.id);
          const surveyQuestions = await storage.getCampaignSurveyQuestions(campaign.id);
          
          return {
            id: campaign.id,
            name: campaign.name,
            cpeZar: campaign.cpeZar,
            tokenReward: Math.floor(parseFloat(campaign.cpeZar) * 100 * 0.9), // 90% to user
            creatives: creatives.map(c => ({
              type: c.type,
              fileUrl: c.fileUrl,
              durationSeconds: c.durationSeconds,
            })),
            surveyQuestions: surveyQuestions.map(q => ({
              id: q.id,
              questionText: q.questionText,
              options: q.options,
              isRequired: q.isRequired,
            })),
          };
        })
      );

      res.json(campaignsWithDetails);
    } catch (error) {
      console.error("Get eligible campaigns error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Record campaign impression started
  app.post("/api/campaigns/:campaignId/impression", requireAuth, async (req: Request, res: Response) => {
    try {
      const { campaignId } = req.params;
      
      const campaign = await storage.getCampaignById(campaignId);
      if (!campaign) {
        return res.status(404).json({ message: "Campaign not found" });
      }

      if (campaign.status !== "active") {
        return res.status(400).json({ message: "Campaign is not active" });
      }

      // Record impression started
      await storage.updateCampaignMetrics(campaignId, new Date(), { impressionsStarted: 1 });

      res.json({ success: true });
    } catch (error) {
      console.error("Record impression error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Complete campaign engagement (charge advertiser, reward user)
  app.post("/api/campaigns/:campaignId/complete", requireAuth, async (req: Request, res: Response) => {
    try {
      const { campaignId } = req.params;
      const schema = z.object({
        surveyResponses: z.array(z.object({
          questionId: z.string(),
          selectedOption: z.string(),
        })).optional(),
      });

      const { surveyResponses } = schema.parse(req.body);

      // Build survey response records
      const responseRecords = surveyResponses?.map(r => ({
        campaignId,
        userId: req.user!.id,
        questionId: r.questionId,
        selectedOption: r.selectedOption,
      }));

      // Record engagement and charge advertiser
      const result = await storage.recordCampaignEngagement(campaignId, req.user!.id, responseRecords);

      if (!result.success) {
        return res.status(400).json({ message: result.error });
      }

      // Reward user
      const wallets = await storage.getWalletsByUserId(req.user!.id);
      const mainWallet = wallets.find(w => w.type === "main");
      
      if (mainWallet) {
        const tokensEarned = result.tokensEarned;
        const zarFromTokens = tokensEarned / 100; // 100:1 ratio
        
        const newTokenBalance = mainWallet.balanceTokens + tokensEarned;
        const newZarBalance = parseFloat(mainWallet.balanceZar) + zarFromTokens;
        
        await storage.updateWallet(mainWallet.id, {
          balanceTokens: newTokenBalance,
          balanceZar: newZarBalance.toFixed(2),
        });

        // Create transaction
        const campaign = await storage.getCampaignById(campaignId);
        await storage.createTransaction({
          userId: req.user!.id,
          walletId: mainWallet.id,
          type: "earn",
          amount: zarFromTokens.toFixed(2),
          currency: "ZAR",
          status: "completed",
          description: campaign?.name || "Campaign engagement",
          metadata: JSON.stringify({ campaignId, tokens: tokensEarned }),
        });

        // Update user earnings
        const user = await storage.getUser(req.user!.id);
        if (user) {
          const newTotalEarnings = parseFloat(user.totalEarnings) + zarFromTokens;
          await storage.updateUser(req.user!.id, {
            totalEarnings: newTotalEarnings.toFixed(2),
            lastActiveDate: new Date(),
          });
        }

        // Update leaderboard scores
        const dailyPeriod = getDailyPeriod();
        const weeklyPeriod = getWeeklyPeriod();
        
        const dailyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, dailyPeriod);
        await storage.createOrUpdateLeaderboardScore({
          userId: req.user!.id,
          period: dailyPeriod,
          score: (dailyScore?.score || 0) + tokensEarned,
          rank: dailyScore?.rank || null,
        });

        const weeklyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, weeklyPeriod);
        await storage.createOrUpdateLeaderboardScore({
          userId: req.user!.id,
          period: weeklyPeriod,
          score: (weeklyScore?.score || 0) + tokensEarned,
          rank: weeklyScore?.rank || null,
        });

        await storage.updateLeaderboardRanks(dailyPeriod);
        await storage.updateLeaderboardRanks(weeklyPeriod);

        res.json({
          success: true,
          tokensEarned,
          zarEarned: zarFromTokens.toFixed(2),
          newBalance: newZarBalance.toFixed(2),
        });
      } else {
        res.status(500).json({ message: "User has no main wallet" });
      }
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Complete campaign error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== REFERRAL ROUTES =====

  // Get user's referrals
  app.get("/api/referrals", requireAuth, async (req: Request, res: Response) => {
    try {
      const referrals = await storage.getReferralsByReferrerId(req.user!.id);
      res.json(referrals);
    } catch (error) {
      console.error("Get referrals error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Send referral invite
  app.post("/api/referrals/invite", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        phoneNumber: z.string().min(10),
      });

      const { phoneNumber } = schema.parse(req.body);

      // Check if user is trying to refer themselves
      if (phoneNumber === req.user!.phoneNumber) {
        return res.status(400).json({ message: "Cannot refer yourself" });
      }

      // Check if already referred
      const existing = await storage.getReferralByPhoneNumber(phoneNumber);
      if (existing) {
        return res.status(400).json({ message: "This phone number has already been referred" });
      }

      // Check if user is already registered
      const existingUser = await storage.getUserByPhoneNumber(phoneNumber);
      
      const referral = await storage.createReferral({
        referrerId: req.user!.id,
        referredUserId: existingUser?.id || null,
        referredPhoneNumber: phoneNumber,
        status: existingUser ? "joined" : "invited",
        earningsReferrer: "0",
        earningsReferred: "0",
        assistScore: 0,
      });

      res.status(201).json(referral);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Invite referral error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== LEADERBOARD ROUTES =====

  // Get leaderboard for period
  app.get("/api/leaderboard/:period", requireAuth, async (req: Request, res: Response) => {
    try {
      const { period } = req.params;
      
      let periodString: string;
      if (period === "daily") {
        periodString = getDailyPeriod();
      } else if (period === "weekly") {
        periodString = getWeeklyPeriod();
      } else {
        return res.status(400).json({ message: "Invalid period. Use 'daily' or 'weekly'" });
      }

      const scores = await storage.getLeaderboardScoresByPeriod(periodString);
      res.json(scores);
    } catch (error) {
      console.error("Get leaderboard error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get prize pot for period
  app.get("/api/pots/:period", requireAuth, async (req: Request, res: Response) => {
    try {
      const { period } = req.params;
      
      let periodString: string;
      if (period === "daily") {
        periodString = getDailyPeriod();
      } else if (period === "weekly") {
        periodString = getWeeklyPeriod();
      } else {
        return res.status(400).json({ message: "Invalid period. Use 'daily' or 'weekly'" });
      }

      const pot = await storage.getPrizePotByPeriod(periodString);
      if (!pot) {
        return res.json({
          period: periodString,
          totalAmount: "0",
          closesAt: period === "daily" 
            ? new Date(new Date().setHours(23, 59, 59, 999))
            : (() => {
                const weekEnd = new Date();
                weekEnd.setDate(weekEnd.getDate() + (7 - weekEnd.getDay()));
                weekEnd.setHours(23, 59, 59, 999);
                return weekEnd;
              })(),
          isDistributed: false,
        });
      }

      res.json(pot);
    } catch (error) {
      console.error("Get pot error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== PURCHASE ROUTES =====

  // Purchase airtime
  app.post("/api/purchases/airtime", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        walletId: z.string(),
        provider: z.string(),
        recipientNumber: z.string(),
        amount: z.string(),
      });

      const data = schema.parse(req.body);
      
      // Verify wallet
      const wallet = await storage.getWalletById(data.walletId);
      if (!wallet || wallet.userId !== req.user!.id) {
        return res.status(404).json({ message: "Wallet not found" });
      }

      const amountNum = parseFloat(data.amount);
      const walletBalanceNum = parseFloat(wallet.balanceZar);
      
      if (walletBalanceNum < amountNum) {
        return res.status(400).json({ message: "Insufficient balance" });
      }

      // Create purchase
      const purchase = await storage.createPurchase({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "airtime",
        provider: data.provider,
        recipientNumber: data.recipientNumber,
        meterNumber: null,
        amount: data.amount,
        status: "completed",
        token: null,
        metadata: null,
      });

      // Update wallet balance
      await storage.updateWallet(data.walletId, {
        balanceZar: (walletBalanceNum - amountNum).toFixed(2),
      });

      // Create transaction
      await storage.createTransaction({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "purchase",
        amount: data.amount,
        currency: "ZAR",
        status: "completed",
        description: `Airtime - ${data.provider}`,
        metadata: JSON.stringify({ purchaseId: purchase.id, type: "airtime", provider: data.provider }),
      });

      res.status(201).json(purchase);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Purchase airtime error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Purchase data
  app.post("/api/purchases/data", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        walletId: z.string(),
        provider: z.string(),
        recipientNumber: z.string(),
        amount: z.string(),
        metadata: z.string().optional(),
      });

      const data = schema.parse(req.body);
      
      // Verify wallet
      const wallet = await storage.getWalletById(data.walletId);
      if (!wallet || wallet.userId !== req.user!.id) {
        return res.status(404).json({ message: "Wallet not found" });
      }

      const amountNum = parseFloat(data.amount);
      const walletBalanceNum = parseFloat(wallet.balanceZar);
      
      if (walletBalanceNum < amountNum) {
        return res.status(400).json({ message: "Insufficient balance" });
      }

      // Create purchase
      const purchase = await storage.createPurchase({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "data",
        provider: data.provider,
        recipientNumber: data.recipientNumber,
        meterNumber: null,
        amount: data.amount,
        status: "completed",
        token: null,
        metadata: data.metadata || null,
      });

      // Update wallet balance
      await storage.updateWallet(data.walletId, {
        balanceZar: (walletBalanceNum - amountNum).toFixed(2),
      });

      // Create transaction
      await storage.createTransaction({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "purchase",
        amount: data.amount,
        currency: "ZAR",
        status: "completed",
        description: `Data - ${data.provider}`,
        metadata: JSON.stringify({ purchaseId: purchase.id, type: "data", provider: data.provider }),
      });

      res.status(201).json(purchase);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Purchase data error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Purchase electricity
  app.post("/api/purchases/electricity", requireAuth, async (req: Request, res: Response) => {
    try {
      const schema = z.object({
        walletId: z.string(),
        meterNumber: z.string(),
        amount: z.string(),
      });

      const data = schema.parse(req.body);
      
      // Verify wallet
      const wallet = await storage.getWalletById(data.walletId);
      if (!wallet || wallet.userId !== req.user!.id) {
        return res.status(404).json({ message: "Wallet not found" });
      }

      const amountNum = parseFloat(data.amount);
      const walletBalanceNum = parseFloat(wallet.balanceZar);
      
      if (walletBalanceNum < amountNum) {
        return res.status(400).json({ message: "Insufficient balance" });
      }

      // Generate 20-digit electricity token
      const electricityToken = generateElectricityToken();

      // Create purchase
      const purchase = await storage.createPurchase({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "electricity",
        provider: null,
        recipientNumber: null,
        meterNumber: data.meterNumber,
        amount: data.amount,
        status: "completed",
        token: electricityToken,
        metadata: null,
      });

      // Update wallet balance
      await storage.updateWallet(data.walletId, {
        balanceZar: (walletBalanceNum - amountNum).toFixed(2),
      });

      // Create transaction
      await storage.createTransaction({
        userId: req.user!.id,
        walletId: data.walletId,
        type: "purchase",
        amount: data.amount,
        currency: "ZAR",
        status: "completed",
        description: `Electricity - ${data.meterNumber}`,
        metadata: JSON.stringify({ purchaseId: purchase.id, type: "electricity", meterNumber: data.meterNumber }),
      });

      res.status(201).json(purchase);
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({ message: "Invalid input", errors: error.errors });
      }
      console.error("Purchase electricity error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // Get purchase history
  app.get("/api/purchases/history", requireAuth, async (req: Request, res: Response) => {
    try {
      const limit = req.query.limit ? parseInt(req.query.limit as string) : 50;
      const purchases = await storage.getPurchasesByUserId(req.user!.id, limit);
      res.json(purchases);
    } catch (error) {
      console.error("Get purchase history error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  // ===== HOME SUMMARY ROUTE =====

  // Get home page summary
  app.get("/api/home/summary", requireAuth, async (req: Request, res: Response) => {
    try {
      const user = await storage.getUser(req.user!.id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      // Get wallet totals
      const wallets = await storage.getWalletsByUserId(req.user!.id);
      const totalBalance = wallets.reduce((sum, wallet) => sum + parseFloat(wallet.balanceZar), 0);
      const totalTokens = wallets.reduce((sum, wallet) => sum + wallet.balanceTokens, 0);

      // Get leaderboard rank
      const dailyPeriod = getDailyPeriod();
      const weeklyPeriod = getWeeklyPeriod();
      
      const dailyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, dailyPeriod);
      const weeklyScore = await storage.getLeaderboardScoreByUserAndPeriod(req.user!.id, weeklyPeriod);

      // Get prize pots
      const dailyPot = await storage.getPrizePotByPeriod(dailyPeriod);
      const weeklyPot = await storage.getPrizePotByPeriod(weeklyPeriod);

      const summary = {
        greeting: getGreeting(),
        userName: user.firstName || user.username,
        streak: user.currentStreak,
        dailyRank: dailyScore?.rank || null,
        weeklyRank: weeklyScore?.rank || null,
        totalBalance: totalBalance.toFixed(2),
        totalTokens,
        dailyPot: {
          amount: dailyPot?.totalAmount || "0",
          closesAt: dailyPot?.closesAt || new Date(new Date().setHours(23, 59, 59, 999)),
        },
        weeklyPot: {
          amount: weeklyPot?.totalAmount || "0",
          closesAt: weeklyPot?.closesAt || (() => {
            const weekEnd = new Date();
            weekEnd.setDate(weekEnd.getDate() + (7 - weekEnd.getDay()));
            weekEnd.setHours(23, 59, 59, 999);
            return weekEnd;
          })(),
        },
      };

      res.json(summary);
    } catch (error) {
      console.error("Get home summary error:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  });

  return httpServer;
}
