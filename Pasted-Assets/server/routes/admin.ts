import { Router, Request, Response } from "express";
import { db } from "../db";
import {
  users, advertiserOrgs, advertiserOrgMembers, advertiserWallets, advertiserTopUps,
  campaigns, campaignCreatives, campaignSurveyQuestions, campaignMetrics, systemSettings,
  insertAdvertiserOrgSchema, insertCampaignSchema, insertCampaignCreativeSchema,
  insertCampaignSurveyQuestionSchema
} from "@shared/schema";
import { eq, and, desc, asc, sql, gte, lte, ilike, or } from "drizzle-orm";
import { requireAuth, requireSuperAdmin, requireAdvertiser, requireOrgRole, requireOrgMembership } from "../middleware/rbac";
import bcrypt from "bcrypt";

const router = Router();

// ============================================
// ADVERTISER AUTHENTICATION
// ============================================

router.post("/auth/register", async (req: Request, res: Response) => {
  try {
    const { email, password, firstName, lastName, companyName, brandName, vatNumber, registrationNumber, acceptedTerms, acceptedPopia } = req.body;
    
    if (!email || !password || !companyName || !brandName) {
      return res.status(400).json({ message: "Email, password, company name, and brand name are required" });
    }
    
    if (!acceptedTerms || !acceptedPopia) {
      return res.status(400).json({ message: "You must accept the terms and POPIA agreement" });
    }
    
    // Check if email already exists
    const existingUser = await db.query.users.findFirst({
      where: eq(users.email, email),
    });
    
    if (existingUser) {
      return res.status(400).json({ message: "Email already registered" });
    }
    
    // Create user with advertiser role
    const hashedPassword = await bcrypt.hash(password, 10);
    const username = email.split("@")[0] + "_" + Date.now().toString(36);
    
    // Generate unique phone placeholder for advertisers (they use email for auth)
    const uniquePhonePlaceholder = `ADV${Date.now()}${Math.random().toString(36).slice(2, 6)}`;
    
    const [newUser] = await db.insert(users).values({
      username,
      password: hashedPassword,
      email,
      phoneNumber: uniquePhonePlaceholder,
      firstName,
      lastName,
      role: "advertiser",
      emailVerified: false,
    }).returning();
    
    // Create advertiser organization
    const [newOrg] = await db.insert(advertiserOrgs).values({
      companyName,
      brandName,
      vatNumber,
      registrationNumber,
      billingEmail: email,
      billingContactName: `${firstName || ""} ${lastName || ""}`.trim(),
      acceptedTerms: true,
      acceptedPopia: true,
    }).returning();
    
    // Create advertiser wallet
    await db.insert(advertiserWallets).values({
      orgId: newOrg.id,
      balanceZar: "0",
      totalSpent: "0",
    });
    
    // Add user as org admin
    await db.insert(advertiserOrgMembers).values({
      orgId: newOrg.id,
      userId: newUser.id,
      role: "org_admin",
    });
    
    res.status(201).json({
      message: "Registration successful. Please check your email for verification.",
      userId: newUser.id,
      orgId: newOrg.id,
    });
  } catch (error: any) {
    console.error("Advertiser registration error:", error);
    res.status(500).json({ message: "Registration failed" });
  }
});

router.get("/auth/me", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const user = await db.query.users.findFirst({
      where: eq(users.id, req.user!.id),
    });
    
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    
    // Get user's organization memberships
    const memberships = await db.query.advertiserOrgMembers.findMany({
      where: eq(advertiserOrgMembers.userId, user.id),
      with: {
        org: true,
      },
    });
    
    res.json({
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      role: user.role,
      emailVerified: user.emailVerified,
      organizations: memberships.map(m => ({
        id: m.org.id,
        companyName: m.org.companyName,
        brandName: m.org.brandName,
        role: m.role,
      })),
    });
  } catch (error: any) {
    console.error("Get advertiser profile error:", error);
    res.status(500).json({ message: "Failed to get profile" });
  }
});

// ============================================
// ORGANIZATION MANAGEMENT
// ============================================

router.get("/orgs/:orgId", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    
    // Check membership (super admins can access all)
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    const org = await db.query.advertiserOrgs.findFirst({
      where: eq(advertiserOrgs.id, orgId),
      with: {
        wallet: true,
        members: {
          with: {
            user: true,
          },
        },
      },
    });
    
    if (!org) {
      return res.status(404).json({ message: "Organization not found" });
    }
    
    res.json(org);
  } catch (error: any) {
    console.error("Get organization error:", error);
    res.status(500).json({ message: "Failed to get organization" });
  }
});

router.post("/orgs/:orgId/invite", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    const { email, role } = req.body;
    
    // Only org admins can invite
    if (req.user!.role !== "super_admin") {
      const { isMember, role: memberRole } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || memberRole !== "org_admin") {
        return res.status(403).json({ message: "Only organization admins can invite members" });
      }
    }
    
    // Find or create user
    let user = await db.query.users.findFirst({
      where: eq(users.email, email),
    });
    
    if (!user) {
      // Create pending user with temporary password
      const tempPassword = await bcrypt.hash(Math.random().toString(36), 10);
      const username = email.split("@")[0] + "_" + Date.now().toString(36);
      
      const [newUser] = await db.insert(users).values({
        username,
        password: tempPassword,
        email,
        phoneNumber: "0000000000",
        role: "advertiser",
        emailVerified: false,
      }).returning();
      
      user = newUser;
    }
    
    // Check if already a member
    const existingMembership = await db.query.advertiserOrgMembers.findFirst({
      where: and(
        eq(advertiserOrgMembers.orgId, orgId),
        eq(advertiserOrgMembers.userId, user.id)
      ),
    });
    
    if (existingMembership) {
      return res.status(400).json({ message: "User is already a member of this organization" });
    }
    
    // Add membership
    await db.insert(advertiserOrgMembers).values({
      orgId,
      userId: user.id,
      role: role || "analyst",
      invitedBy: req.user!.id,
    });
    
    res.status(201).json({ message: "Invitation sent", userId: user.id });
  } catch (error: any) {
    console.error("Invite member error:", error);
    res.status(500).json({ message: "Failed to invite member" });
  }
});

// ============================================
// ADVERTISER WALLET
// ============================================

router.get("/orgs/:orgId/wallet", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    const wallet = await db.query.advertiserWallets.findFirst({
      where: eq(advertiserWallets.orgId, orgId),
    });
    
    if (!wallet) {
      return res.status(404).json({ message: "Wallet not found" });
    }
    
    // Get recent top-ups
    const topUps = await db.query.advertiserTopUps.findMany({
      where: eq(advertiserTopUps.orgId, orgId),
      orderBy: [desc(advertiserTopUps.createdAt)],
      limit: 20,
    });
    
    res.json({
      balance: wallet.balanceZar,
      totalSpent: wallet.totalSpent,
      topUps,
    });
  } catch (error: any) {
    console.error("Get wallet error:", error);
    res.status(500).json({ message: "Failed to get wallet" });
  }
});

router.post("/orgs/:orgId/wallet/topup", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    const { amount, proofOfPaymentUrl, reference } = req.body;
    
    // Only org admins can request top-ups
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || role !== "org_admin") {
        return res.status(403).json({ message: "Only organization admins can request top-ups" });
      }
    }
    
    if (!amount || amount <= 0) {
      return res.status(400).json({ message: "Valid amount required" });
    }
    
    const wallet = await db.query.advertiserWallets.findFirst({
      where: eq(advertiserWallets.orgId, orgId),
    });
    
    if (!wallet) {
      return res.status(404).json({ message: "Wallet not found" });
    }
    
    const [topUp] = await db.insert(advertiserTopUps).values({
      walletId: wallet.id,
      orgId,
      amount: amount.toString(),
      status: "pending",
      proofOfPaymentUrl,
      reference,
    }).returning();
    
    res.status(201).json(topUp);
  } catch (error: any) {
    console.error("Request top-up error:", error);
    res.status(500).json({ message: "Failed to request top-up" });
  }
});

// ============================================
// CAMPAIGNS
// ============================================

router.get("/orgs/:orgId/campaigns", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    const { status } = req.query;
    
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    let query = db.query.campaigns.findMany({
      where: status 
        ? and(eq(campaigns.orgId, orgId), eq(campaigns.status, status as any))
        : eq(campaigns.orgId, orgId),
      orderBy: [desc(campaigns.createdAt)],
      with: {
        creatives: true,
      },
    });
    
    const campaignList = await query;
    res.json(campaignList);
  } catch (error: any) {
    console.error("Get campaigns error:", error);
    res.status(500).json({ message: "Failed to get campaigns" });
  }
});

router.post("/orgs/:orgId/campaigns", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions to create campaigns" });
      }
    }
    
    const campaignData = {
      ...req.body,
      orgId,
      createdBy: req.user!.id,
      status: "draft",
    };
    
    const [campaign] = await db.insert(campaigns).values(campaignData).returning();
    res.status(201).json(campaign);
  } catch (error: any) {
    console.error("Create campaign error:", error);
    res.status(500).json({ message: "Failed to create campaign" });
  }
});

router.get("/orgs/:orgId/campaigns/:campaignId", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
      with: {
        creatives: true,
        surveyQuestions: {
          orderBy: [asc(campaignSurveyQuestions.orderIndex)],
        },
      },
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    res.json(campaign);
  } catch (error: any) {
    console.error("Get campaign error:", error);
    res.status(500).json({ message: "Failed to get campaign" });
  }
});

router.put("/orgs/:orgId/campaigns/:campaignId", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    // Only allow editing draft campaigns
    if (campaign.status !== "draft" && campaign.status !== "rejected") {
      return res.status(400).json({ message: "Can only edit draft or rejected campaigns" });
    }
    
    const [updated] = await db.update(campaigns)
      .set({ ...req.body, updatedAt: new Date() })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    res.json(updated);
  } catch (error: any) {
    console.error("Update campaign error:", error);
    res.status(500).json({ message: "Failed to update campaign" });
  }
});

router.post("/orgs/:orgId/campaigns/:campaignId/submit", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
      with: {
        creatives: true,
        surveyQuestions: true,
      },
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    if (campaign.status !== "draft" && campaign.status !== "rejected") {
      return res.status(400).json({ message: "Campaign is not in draft or rejected status" });
    }
    
    // Validate campaign has required fields
    if (!campaign.name || !campaign.cpeZar || !campaign.totalBudget) {
      return res.status(400).json({ message: "Campaign is missing required fields" });
    }
    
    if (campaign.creatives.length === 0) {
      return res.status(400).json({ message: "Campaign must have at least one creative" });
    }
    
    // Check wallet balance
    const wallet = await db.query.advertiserWallets.findFirst({
      where: eq(advertiserWallets.orgId, orgId),
    });
    
    if (!wallet || parseFloat(wallet.balanceZar) < parseFloat(campaign.dailyCap || campaign.totalBudget)) {
      return res.status(400).json({ message: "Insufficient wallet balance" });
    }
    
    const [updated] = await db.update(campaigns)
      .set({ status: "pending_review", updatedAt: new Date() })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    res.json(updated);
  } catch (error: any) {
    console.error("Submit campaign error:", error);
    res.status(500).json({ message: "Failed to submit campaign" });
  }
});

router.post("/orgs/:orgId/campaigns/:campaignId/pause", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const [updated] = await db.update(campaigns)
      .set({ status: "paused", updatedAt: new Date() })
      .where(and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)))
      .returning();
    
    if (!updated) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    res.json(updated);
  } catch (error: any) {
    console.error("Pause campaign error:", error);
    res.status(500).json({ message: "Failed to pause campaign" });
  }
});

router.post("/orgs/:orgId/campaigns/:campaignId/resume", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    if (campaign.status !== "paused") {
      return res.status(400).json({ message: "Campaign is not paused" });
    }
    
    const [updated] = await db.update(campaigns)
      .set({ status: "active", updatedAt: new Date() })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    res.json(updated);
  } catch (error: any) {
    console.error("Resume campaign error:", error);
    res.status(500).json({ message: "Failed to resume campaign" });
  }
});

// ============================================
// CREATIVES
// ============================================

router.post("/orgs/:orgId/campaigns/:campaignId/creatives", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    const [creative] = await db.insert(campaignCreatives).values({
      ...req.body,
      campaignId,
      status: "pending",
    }).returning();
    
    res.status(201).json(creative);
  } catch (error: any) {
    console.error("Add creative error:", error);
    res.status(500).json({ message: "Failed to add creative" });
  }
});

router.delete("/orgs/:orgId/campaigns/:campaignId/creatives/:creativeId", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId, creativeId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    await db.delete(campaignCreatives)
      .where(and(eq(campaignCreatives.id, creativeId), eq(campaignCreatives.campaignId, campaignId)));
    
    res.json({ message: "Creative deleted" });
  } catch (error: any) {
    console.error("Delete creative error:", error);
    res.status(500).json({ message: "Failed to delete creative" });
  }
});

// ============================================
// SURVEY QUESTIONS
// ============================================

router.post("/orgs/:orgId/campaigns/:campaignId/questions", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    const { questions } = req.body; // Array of questions
    
    if (req.user!.role !== "super_admin") {
      const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember || (role !== "org_admin" && role !== "campaign_manager")) {
        return res.status(403).json({ message: "Insufficient permissions" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    // Delete existing questions and insert new ones
    await db.delete(campaignSurveyQuestions).where(eq(campaignSurveyQuestions.campaignId, campaignId));
    
    if (questions && questions.length > 0) {
      const questionValues = questions.map((q: any, index: number) => ({
        campaignId,
        questionText: q.questionText,
        options: q.options,
        orderIndex: index,
        isRequired: q.isRequired ?? true,
      }));
      
      await db.insert(campaignSurveyQuestions).values(questionValues);
    }
    
    const updatedQuestions = await db.query.campaignSurveyQuestions.findMany({
      where: eq(campaignSurveyQuestions.campaignId, campaignId),
      orderBy: [asc(campaignSurveyQuestions.orderIndex)],
    });
    
    res.json(updatedQuestions);
  } catch (error: any) {
    console.error("Update questions error:", error);
    res.status(500).json({ message: "Failed to update questions" });
  }
});

// ============================================
// ANALYTICS
// ============================================

router.get("/orgs/:orgId/campaigns/:campaignId/metrics", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    const { startDate, endDate } = req.query;
    
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    const campaign = await db.query.campaigns.findFirst({
      where: and(eq(campaigns.id, campaignId), eq(campaigns.orgId, orgId)),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    let whereClause = eq(campaignMetrics.campaignId, campaignId);
    
    const metrics = await db.query.campaignMetrics.findMany({
      where: whereClause,
      orderBy: [desc(campaignMetrics.date)],
    });
    
    // Aggregate totals
    const totals = metrics.reduce((acc, m) => ({
      impressionsStarted: acc.impressionsStarted + m.impressionsStarted,
      impressionsCompleted: acc.impressionsCompleted + m.impressionsCompleted,
      surveySubmits: acc.surveySubmits + m.surveySubmits,
      spendZar: acc.spendZar + parseFloat(m.spendZar),
      tokensDistributed: acc.tokensDistributed + m.tokensDistributed,
    }), { impressionsStarted: 0, impressionsCompleted: 0, surveySubmits: 0, spendZar: 0, tokensDistributed: 0 });
    
    res.json({
      campaign: {
        id: campaign.id,
        name: campaign.name,
        status: campaign.status,
        totalBudget: campaign.totalBudget,
        totalSpent: campaign.totalSpent,
        dailyCap: campaign.dailyCap,
        todaySpent: campaign.todaySpent,
      },
      totals: {
        ...totals,
        completionRate: totals.impressionsStarted > 0 
          ? ((totals.impressionsCompleted / totals.impressionsStarted) * 100).toFixed(2)
          : "0",
        realisedCpe: totals.impressionsCompleted > 0
          ? (totals.spendZar / totals.impressionsCompleted).toFixed(4)
          : "0",
      },
      dailyMetrics: metrics,
    });
  } catch (error: any) {
    console.error("Get metrics error:", error);
    res.status(500).json({ message: "Failed to get metrics" });
  }
});

router.get("/orgs/:orgId/campaigns/:campaignId/export", requireAuth, requireAdvertiser, async (req: Request, res: Response) => {
  try {
    const { orgId, campaignId } = req.params;
    
    if (req.user!.role !== "super_admin") {
      const { isMember } = await requireOrgMembership(orgId, req.user!.id);
      if (!isMember) {
        return res.status(403).json({ message: "Access denied" });
      }
    }
    
    const metrics = await db.query.campaignMetrics.findMany({
      where: eq(campaignMetrics.campaignId, campaignId),
      orderBy: [asc(campaignMetrics.date)],
    });
    
    // Generate CSV (no PII)
    const headers = ["Date", "Impressions Started", "Impressions Completed", "Survey Submits", "Spend (ZAR)", "Tokens Distributed", "Completion Rate"];
    const rows = metrics.map(m => [
      new Date(m.date).toISOString().split("T")[0],
      m.impressionsStarted,
      m.impressionsCompleted,
      m.surveySubmits,
      m.spendZar,
      m.tokensDistributed,
      m.impressionsStarted > 0 ? ((m.impressionsCompleted / m.impressionsStarted) * 100).toFixed(2) + "%" : "0%",
    ]);
    
    const csv = [headers.join(","), ...rows.map(r => r.join(","))].join("\n");
    
    res.setHeader("Content-Type", "text/csv");
    res.setHeader("Content-Disposition", `attachment; filename=campaign_${campaignId}_metrics.csv`);
    res.send(csv);
  } catch (error: any) {
    console.error("Export metrics error:", error);
    res.status(500).json({ message: "Failed to export metrics" });
  }
});

// ============================================
// SUPER ADMIN: TOP-UP APPROVAL
// ============================================

router.get("/super/topups", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { status } = req.query;
    
    let whereClause = status ? eq(advertiserTopUps.status, status as any) : undefined;
    
    const topUps = await db.query.advertiserTopUps.findMany({
      where: whereClause,
      orderBy: [desc(advertiserTopUps.createdAt)],
      with: {
        org: true,
      },
    });
    
    res.json(topUps);
  } catch (error: any) {
    console.error("Get top-ups error:", error);
    res.status(500).json({ message: "Failed to get top-ups" });
  }
});

router.post("/super/topups/:topUpId/approve", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { topUpId } = req.params;
    
    const topUp = await db.query.advertiserTopUps.findFirst({
      where: eq(advertiserTopUps.id, topUpId),
    });
    
    if (!topUp) {
      return res.status(404).json({ message: "Top-up not found" });
    }
    
    if (topUp.status !== "pending" && topUp.status !== "under_review") {
      return res.status(400).json({ message: "Top-up is not pending" });
    }
    
    // Update top-up status
    await db.update(advertiserTopUps)
      .set({ 
        status: "cleared", 
        reviewedBy: req.user!.id,
        reviewedAt: new Date(),
      })
      .where(eq(advertiserTopUps.id, topUpId));
    
    // Update wallet balance
    await db.update(advertiserWallets)
      .set({ 
        balanceZar: sql`${advertiserWallets.balanceZar} + ${topUp.amount}`,
      })
      .where(eq(advertiserWallets.id, topUp.walletId));
    
    res.json({ message: "Top-up approved" });
  } catch (error: any) {
    console.error("Approve top-up error:", error);
    res.status(500).json({ message: "Failed to approve top-up" });
  }
});

router.post("/super/topups/:topUpId/reject", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { topUpId } = req.params;
    const { reason } = req.body;
    
    await db.update(advertiserTopUps)
      .set({ 
        status: "rejected",
        reviewedBy: req.user!.id,
        reviewedAt: new Date(),
        rejectionReason: reason,
      })
      .where(eq(advertiserTopUps.id, topUpId));
    
    res.json({ message: "Top-up rejected" });
  } catch (error: any) {
    console.error("Reject top-up error:", error);
    res.status(500).json({ message: "Failed to reject top-up" });
  }
});

// ============================================
// SUPER ADMIN: CAMPAIGN APPROVAL
// ============================================

router.get("/super/campaigns/pending", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const pendingCampaigns = await db.query.campaigns.findMany({
      where: eq(campaigns.status, "pending_review"),
      orderBy: [asc(campaigns.createdAt)],
      with: {
        org: true,
        creatives: true,
        surveyQuestions: true,
      },
    });
    
    res.json(pendingCampaigns);
  } catch (error: any) {
    console.error("Get pending campaigns error:", error);
    res.status(500).json({ message: "Failed to get pending campaigns" });
  }
});

router.post("/super/campaigns/:campaignId/approve", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { campaignId } = req.params;
    
    const [updated] = await db.update(campaigns)
      .set({ 
        status: "approved",
        reviewedBy: req.user!.id,
        reviewedAt: new Date(),
      })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    if (!updated) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    // Also approve all pending creatives
    await db.update(campaignCreatives)
      .set({
        status: "approved",
        reviewedBy: req.user!.id,
        reviewedAt: new Date(),
      })
      .where(and(eq(campaignCreatives.campaignId, campaignId), eq(campaignCreatives.status, "pending")));
    
    res.json(updated);
  } catch (error: any) {
    console.error("Approve campaign error:", error);
    res.status(500).json({ message: "Failed to approve campaign" });
  }
});

router.post("/super/campaigns/:campaignId/reject", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { campaignId } = req.params;
    const { reason } = req.body;
    
    const [updated] = await db.update(campaigns)
      .set({ 
        status: "rejected",
        reviewedBy: req.user!.id,
        reviewedAt: new Date(),
        rejectionReason: reason,
      })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    if (!updated) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    res.json(updated);
  } catch (error: any) {
    console.error("Reject campaign error:", error);
    res.status(500).json({ message: "Failed to reject campaign" });
  }
});

router.post("/super/campaigns/:campaignId/activate", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { campaignId } = req.params;
    
    const campaign = await db.query.campaigns.findFirst({
      where: eq(campaigns.id, campaignId),
    });
    
    if (!campaign) {
      return res.status(404).json({ message: "Campaign not found" });
    }
    
    if (campaign.status !== "approved") {
      return res.status(400).json({ message: "Campaign must be approved before activation" });
    }
    
    const [updated] = await db.update(campaigns)
      .set({ status: "active", updatedAt: new Date() })
      .where(eq(campaigns.id, campaignId))
      .returning();
    
    res.json(updated);
  } catch (error: any) {
    console.error("Activate campaign error:", error);
    res.status(500).json({ message: "Failed to activate campaign" });
  }
});

// ============================================
// SUPER ADMIN: USER MANAGEMENT
// ============================================

router.get("/super/users", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { search, role, page = "1", limit = "50" } = req.query;
    
    let whereClause;
    if (search) {
      whereClause = or(
        ilike(users.username, `%${search}%`),
        ilike(users.email, `%${search}%`),
        ilike(users.firstName, `%${search}%`),
        ilike(users.lastName, `%${search}%`)
      );
    }
    if (role) {
      whereClause = whereClause 
        ? and(whereClause, eq(users.role, role as any))
        : eq(users.role, role as any);
    }
    
    const usersList = await db.query.users.findMany({
      where: whereClause,
      orderBy: [desc(users.createdAt)],
      limit: parseInt(limit as string),
      offset: (parseInt(page as string) - 1) * parseInt(limit as string),
    });
    
    // Don't return passwords
    const safeUsers = usersList.map(u => ({
      ...u,
      password: undefined,
    }));
    
    res.json(safeUsers);
  } catch (error: any) {
    console.error("Get users error:", error);
    res.status(500).json({ message: "Failed to get users" });
  }
});

router.get("/super/users/:userId", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;
    
    const user = await db.query.users.findFirst({
      where: eq(users.id, userId),
      with: {
        wallets: true,
        transactions: {
          limit: 20,
          orderBy: [desc(sql`created_at`)],
        },
      },
    });
    
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    
    res.json({
      ...user,
      password: undefined,
    });
  } catch (error: any) {
    console.error("Get user error:", error);
    res.status(500).json({ message: "Failed to get user" });
  }
});

// ============================================
// SUPER ADMIN: SYSTEM SETTINGS
// ============================================

router.get("/super/settings", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const settings = await db.query.systemSettings.findMany();
    res.json(settings);
  } catch (error: any) {
    console.error("Get settings error:", error);
    res.status(500).json({ message: "Failed to get settings" });
  }
});

router.put("/super/settings/:key", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const { key } = req.params;
    const { value, description } = req.body;
    
    const existing = await db.query.systemSettings.findFirst({
      where: eq(systemSettings.key, key),
    });
    
    if (existing) {
      const [updated] = await db.update(systemSettings)
        .set({ value, description, updatedBy: req.user!.id, updatedAt: new Date() })
        .where(eq(systemSettings.key, key))
        .returning();
      res.json(updated);
    } else {
      const [created] = await db.insert(systemSettings)
        .values({ key, value, description, updatedBy: req.user!.id })
        .returning();
      res.status(201).json(created);
    }
  } catch (error: any) {
    console.error("Update setting error:", error);
    res.status(500).json({ message: "Failed to update setting" });
  }
});

// ============================================
// SUPER ADMIN: ADVERTISER ORGS
// ============================================

router.get("/super/orgs", requireAuth, requireSuperAdmin, async (req: Request, res: Response) => {
  try {
    const orgs = await db.query.advertiserOrgs.findMany({
      orderBy: [desc(advertiserOrgs.createdAt)],
      with: {
        wallet: true,
        members: {
          with: {
            user: true,
          },
        },
      },
    });
    
    res.json(orgs);
  } catch (error: any) {
    console.error("Get orgs error:", error);
    res.status(500).json({ message: "Failed to get organizations" });
  }
});

export default router;
