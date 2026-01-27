import { Request, Response, NextFunction } from "express";
import { db } from "../db";
import { advertiserOrgMembers } from "@shared/schema";
import { eq, and } from "drizzle-orm";

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.isAuthenticated()) {
    return res.status(401).json({ message: "Unauthorized" });
  }
  next();
}

export function requireRole(...roles: ("user" | "advertiser" | "super_admin")[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.isAuthenticated()) {
      return res.status(401).json({ message: "Unauthorized" });
    }
    
    if (!roles.includes(req.user!.role)) {
      return res.status(403).json({ message: "Forbidden: Insufficient permissions" });
    }
    
    next();
  };
}

export function requireSuperAdmin(req: Request, res: Response, next: NextFunction) {
  if (!req.isAuthenticated()) {
    return res.status(401).json({ message: "Unauthorized" });
  }
  
  if (req.user!.role !== "super_admin") {
    return res.status(403).json({ message: "Forbidden: Super admin access required" });
  }
  
  next();
}

export function requireAdvertiser(req: Request, res: Response, next: NextFunction) {
  if (!req.isAuthenticated()) {
    return res.status(401).json({ message: "Unauthorized" });
  }
  
  if (req.user!.role !== "advertiser" && req.user!.role !== "super_admin") {
    return res.status(403).json({ message: "Forbidden: Advertiser access required" });
  }
  
  next();
}

export async function requireOrgMembership(orgId: string, userId: string): Promise<{ isMember: boolean; role?: "org_admin" | "campaign_manager" | "analyst" }> {
  const membership = await db.query.advertiserOrgMembers.findFirst({
    where: and(
      eq(advertiserOrgMembers.orgId, orgId),
      eq(advertiserOrgMembers.userId, userId)
    ),
  });
  
  if (!membership) {
    return { isMember: false };
  }
  
  return { isMember: true, role: membership.role };
}

export function requireOrgRole(...allowedRoles: ("org_admin" | "campaign_manager" | "analyst")[]) {
  return async (req: Request, res: Response, next: NextFunction) => {
    if (!req.isAuthenticated()) {
      return res.status(401).json({ message: "Unauthorized" });
    }
    
    // Super admins bypass org role checks
    if (req.user!.role === "super_admin") {
      return next();
    }
    
    const orgId = req.params.orgId || req.body.orgId;
    if (!orgId) {
      return res.status(400).json({ message: "Organization ID required" });
    }
    
    const { isMember, role } = await requireOrgMembership(orgId, req.user!.id);
    
    if (!isMember) {
      return res.status(403).json({ message: "Forbidden: Not a member of this organization" });
    }
    
    if (!allowedRoles.includes(role!)) {
      return res.status(403).json({ message: "Forbidden: Insufficient organization permissions" });
    }
    
    // Attach org info to request for downstream use
    (req as any).orgMembership = { orgId, role };
    
    next();
  };
}

export function canEditCampaigns(req: Request, res: Response, next: NextFunction) {
  return requireOrgRole("org_admin", "campaign_manager")(req, res, next);
}

export function canViewAnalytics(req: Request, res: Response, next: NextFunction) {
  return requireOrgRole("org_admin", "campaign_manager", "analyst")(req, res, next);
}

export function canManageOrg(req: Request, res: Response, next: NextFunction) {
  return requireOrgRole("org_admin")(req, res, next);
}
