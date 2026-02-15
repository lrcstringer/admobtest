/**
 * Admin RBAC, Audit Trail, Maker-Checker, and User Management
 *
 * Centralizes all admin authorization logic.
 * Replaces the per-file `requireAdmin()` functions with
 * a single `requireAdminPermission()` that enforces role-based access.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// ─── Types ───────────────────────────────────────────────────────────

export type AdminRole =
  | "platformAdmin"
  | "superAdmin"
  | "financeAdmin"
  | "campaignAdmin"
  | "auditor";

export const ADMIN_ROLES: readonly AdminRole[] = [
  "platformAdmin",
  "superAdmin",
  "financeAdmin",
  "campaignAdmin",
  "auditor",
] as const;

export type AdminPermission =
  // Account management
  | "accounts:createSupplier"
  | "accounts:listSuppliers"
  | "accounts:updateSupplierStatus"
  | "accounts:createClient"
  | "accounts:listClients"
  | "accounts:getClient"
  | "accounts:updateClientStatus"
  | "accounts:updateClient"
  | "accounts:fundClient"
  | "accounts:refundClient"
  | "accounts:createSubAccount"
  | "accounts:fundSubAccount"
  | "accounts:listSubAccounts"
  | "accounts:getSystemStatus"
  | "accounts:runRecon"
  | "accounts:listUsers"
  | "accounts:listUserSubAccounts"
  | "accounts:softDeleteClient"
  | "accounts:initializeLedger"
  // Earn management
  | "earn:createThread"
  | "earn:createOpportunity"
  | "earn:resetBudget"
  | "earn:syncCampaigns"
  | "earn:getTargeting"
  | "earn:getClientStats"
  | "earn:getThreadAnalytics"
  | "earn:deleteOpportunity"
  | "earn:deleteThread"
  | "earn:cleanupOrphaned"
  // Upload review
  | "review:reviewUpload"
  | "review:getQueue"
  // Poll management
  | "poll:create"
  | "poll:update"
  | "poll:open"
  | "poll:close"
  | "poll:getDetails"
  // Reward campaigns
  | "rewards:createCampaign"
  | "rewards:updateCampaign"
  | "rewards:getCampaigns"
  | "rewards:deleteCampaign"
  | "rewards:getAbResults"
  // Reward items
  | "rewards:importItems"
  | "rewards:revokeItem"
  | "rewards:getItems"
  | "rewards:processAllocation"
  // Platform / migration
  | "platform:setup"
  | "platform:runMigration"
  // Pots
  | "pots:distribute"
  | "pots:viewEntries"
  // Cashout
  | "cashout:complete"
  | "cashout:fail"
  // Admin user management
  | "admin:listAdmins"
  | "admin:createAdmin"
  | "admin:updateRole"
  | "admin:revokeSession"
  // Audit
  | "audit:viewLogs"
  // Pending actions (maker-checker)
  | "pending:list"
  | "pending:approve"
  | "pending:reject";

/** Actions that require maker-checker dual approval. */
export const MAKER_CHECKER_ACTIONS: ReadonlySet<AdminPermission> = new Set([
  "accounts:fundClient",
  "accounts:refundClient",
  "cashout:complete",
]);

export interface AdminContext {
  uid: string;
  email: string;
  roles: AdminRole[];    // All assigned roles
  role: AdminRole;       // Primary role (roles[0]) for backwards-compat logging
}

export interface AdminPendingAction {
  id: string;
  actionType: AdminPermission;
  functionName: string;
  payload: Record<string, unknown>;
  description: string;
  makerUid: string;
  makerRole: AdminRole;           // Primary role (backwards compat)
  makerRoles: AdminRole[];        // All roles
  makerEmail: string;
  status: "pending" | "approved" | "rejected" | "expired";
  checkerUid: string | null;
  checkerRole: AdminRole | null;  // Primary role (backwards compat)
  checkerRoles: AdminRole[] | null; // All roles
  checkerEmail: string | null;
  rejectionReason: string | null;
  createdAt: admin.firestore.Timestamp | admin.firestore.FieldValue;
  expiresAt: admin.firestore.Timestamp;
  completedAt: admin.firestore.Timestamp | admin.firestore.FieldValue | null;
  result: Record<string, unknown> | null;
}

// ─── Permission Map ──────────────────────────────────────────────────

const platformAdminPerms: AdminPermission[] = [
  "accounts:getSystemStatus",
  "accounts:runRecon",
  "accounts:initializeLedger",
  "pots:distribute",
  "pots:viewEntries",
  "platform:setup",
  "platform:runMigration",
  "audit:viewLogs",
];

const financeAdminPerms: AdminPermission[] = [
  "accounts:createSupplier",
  "accounts:listSuppliers",
  "accounts:updateSupplierStatus",
  "accounts:createClient",
  "accounts:listClients",
  "accounts:getClient",
  "accounts:updateClientStatus",
  "accounts:fundClient",
  "accounts:refundClient",
  "accounts:createSubAccount",
  "accounts:fundSubAccount",
  "accounts:listSubAccounts",
  "accounts:getSystemStatus",
  "accounts:runRecon",
  "accounts:listUsers",
  "accounts:listUserSubAccounts",
  "accounts:softDeleteClient",
  "pots:distribute",
  "pots:viewEntries",
  "cashout:complete",
  "cashout:fail",
  "audit:viewLogs",
  "pending:list",
  "pending:approve",
  "pending:reject",
];

const campaignAdminPerms: AdminPermission[] = [
  "accounts:listClients",
  "accounts:getClient",
  "accounts:updateClient",
  "accounts:listSubAccounts",
  "earn:createThread",
  "earn:createOpportunity",
  "earn:resetBudget",
  "earn:syncCampaigns",
  "earn:getTargeting",
  "earn:getClientStats",
  "earn:getThreadAnalytics",
  "earn:deleteOpportunity",
  "earn:deleteThread",
  "earn:cleanupOrphaned",
  "review:reviewUpload",
  "review:getQueue",
  "poll:create",
  "poll:update",
  "poll:open",
  "poll:close",
  "poll:getDetails",
  "rewards:createCampaign",
  "rewards:updateCampaign",
  "rewards:getCampaigns",
  "rewards:deleteCampaign",
  "rewards:getAbResults",
  "rewards:importItems",
  "rewards:revokeItem",
  "rewards:getItems",
  "rewards:processAllocation",
  "audit:viewLogs",
];

const auditorPerms: AdminPermission[] = [
  "pots:viewEntries",
  "accounts:listSuppliers",
  "accounts:listClients",
  "accounts:getClient",
  "accounts:listSubAccounts",
  "accounts:getSystemStatus",
  "accounts:runRecon",
  "accounts:listUsers",
  "accounts:listUserSubAccounts",
  "earn:getTargeting",
  "earn:getClientStats",
  "earn:getThreadAnalytics",
  "review:getQueue",
  "poll:getDetails",
  "rewards:getCampaigns",
  "rewards:getAbResults",
  "rewards:getItems",
  "audit:viewLogs",
];

export const AdminRolePermissions: Record<AdminRole, Set<AdminPermission>> = {
  platformAdmin: new Set(platformAdminPerms),
  superAdmin: new Set(), // SuperAdmin bypasses — this set is not checked
  financeAdmin: new Set(financeAdminPerms),
  campaignAdmin: new Set(campaignAdminPerms),
  auditor: new Set(auditorPerms),
};

/** Compute the union of permissions from an array of roles. */
export function computeEffectivePermissions(roles: AdminRole[]): Set<AdminPermission> {
  const perms = new Set<AdminPermission>();
  for (const role of roles) {
    const rolePerms = AdminRolePermissions[role];
    if (rolePerms) for (const p of rolePerms) perms.add(p);
  }
  return perms;
}

// ─── Role Display Names ──────────────────────────────────────────────

export const ROLE_DISPLAY_NAMES: Record<AdminRole, string> = {
  platformAdmin: "Platform Admin",
  superAdmin: "Super Admin",
  financeAdmin: "Finance Admin",
  campaignAdmin: "Campaign Admin",
  auditor: "Auditor",
};

// ─── Audit Logging ───────────────────────────────────────────────────

export async function logAdminAction(
  actorUid: string,
  action: string,
  outcome: string,
  details: Record<string, unknown> = {},
): Promise<void> {
  try {
    const adminDoc = await db.collection("adminUsers").doc(actorUid).get();
    const adminData = adminDoc.data();

    const actorRole = adminData?.role || details.actorRole || "unknown";
    const actorRoles = adminData?.roles || (details.actorRoles as string[]) || (actorRole !== "unknown" ? [actorRole] : []);

    await db.collection("adminAuditLog").add({
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      actorUid,
      actorEmail: adminData?.email || details.actorEmail || "",
      actorRole,        // backwards compat
      actorRoles,       // new: full roles array
      action,
      outcome,
      details,
    });
  } catch (err) {
    // Never fail the main operation due to audit logging
    console.error("Failed to write audit log:", err);
  }
}

// ─── Core Permission Check ───────────────────────────────────────────

/**
 * Centralized admin permission check. Replaces all per-file `requireAdmin()`.
 *
 * 1. Verifies authentication
 * 2. Reads role from `token.adminRole` (new) or legacy claims (backwards compat)
 * 3. Checks permission against the role's permission set (superAdmin bypasses)
 * 4. Returns AdminContext for downstream use
 */
export async function requireAdminPermission(
  context: functions.https.CallableContext,
  permission: AdminPermission,
  functionName: string,
): Promise<AdminContext> {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be authenticated",
    );
  }

  const token = context.auth.token;
  const uid = context.auth.uid;

  // Determine roles — new array claim first, then single claim, then legacy
  let roles: AdminRole[];
  if (Array.isArray(token.adminRoles) && token.adminRoles.length > 0) {
    roles = (token.adminRoles as string[]).filter(
      (r) => ADMIN_ROLES.includes(r as AdminRole),
    ) as AdminRole[];
  } else if (token.adminRole && ADMIN_ROLES.includes(token.adminRole as AdminRole)) {
    roles = [token.adminRole as AdminRole];
  } else if (token.superAdmin === true) {
    roles = ["superAdmin"];
  } else if (token.admin === true) {
    roles = ["campaignAdmin"]; // Conservative default for legacy admin claims
  } else {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Admin access required",
    );
  }

  if (roles.length === 0) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Admin access required",
    );
  }

  const isSuperAdmin = roles.includes("superAdmin");

  // SuperAdmin bypasses permission checks; others get union of all roles' permissions
  if (!isSuperAdmin) {
    const effectivePerms = computeEffectivePermissions(roles);
    if (!effectivePerms.has(permission)) {
      logAdminAction(uid, functionName, "denied", {
        actorEmail: (token.email as string) || "",
        actorRoles: roles,
        actorRole: roles[0],
        requiredPermission: permission,
      }).catch(() => {});

      throw new functions.https.HttpsError(
        "permission-denied",
        `Roles [${roles.join(", ")}] do not have permission '${permission}'`,
      );
    }
  }

  // Audit trail: log successful access (fire-and-forget)
  logAdminAction(uid, functionName, "success", {
    actorEmail: (token.email as string) || "",
    actorRoles: roles,
    actorRole: roles[0],
    permission,
  }).catch(() => {});

  return {
    uid,
    email: (token.email as string) || "",
    roles,
    role: roles[0],
  };
}

// ─── Admin User Management Functions ─────────────────────────────────

/** List all admin users from the adminUsers collection. */
export const adminListAdmins = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminListAdmins");
  await requireAdminPermission(context, "admin:listAdmins", "adminListAdmins");

  const snapshot = await db
    .collection("adminUsers")
    .orderBy("email")
    .get();

  const admins = snapshot.docs.map((doc) => {
    const d = doc.data();
    return {
      uid: doc.id,
      ...d,
      createdAt: d.createdAt?.toDate?.()?.toISOString?.() || null,
      updatedAt: d.updatedAt?.toDate?.()?.toISOString?.() || null,
      lastLoginAt: d.lastLoginAt?.toDate?.()?.toISOString?.() || null,
    };
  });

  return { admins };
});

/** Set or change an admin user's roles. SuperAdmin only. */
export const adminSetRole = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminSetRole");
  const adminCtx = await requireAdminPermission(
    context,
    "admin:updateRole",
    "adminSetRole",
  );

  const { targetUid, roles: inputRoles, role: inputRole } = data as {
    targetUid: string;
    roles?: AdminRole[];
    role?: AdminRole;     // backwards compat: single role
  };

  // Accept roles array or single role
  const roles: AdminRole[] = inputRoles || (inputRole ? [inputRole] : []);

  if (!targetUid || roles.length === 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "targetUid and at least one role are required",
    );
  }

  for (const r of roles) {
    if (!ADMIN_ROLES.includes(r)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid role: ${r}`,
      );
    }
  }

  // No self-elevation
  if (targetUid === adminCtx.uid) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Cannot change your own roles",
    );
  }

  // Only superAdmin can grant superAdmin
  if (roles.includes("superAdmin") && !adminCtx.roles.includes("superAdmin")) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only superAdmin can grant superAdmin role",
    );
  }

  // Get the target user
  let targetUser: admin.auth.UserRecord;
  try {
    targetUser = await admin.auth().getUser(targetUid);
  } catch {
    throw new functions.https.HttpsError("not-found", "User not found");
  }

  // Set custom claims (preserve existing non-admin claims)
  const existingClaims = targetUser.customClaims || {};
  await admin.auth().setCustomUserClaims(targetUser.uid, {
    ...existingClaims,
    admin: true,
    superAdmin: roles.includes("superAdmin"),
    adminRole: roles[0],      // backwards compat
    adminRoles: roles,         // canonical
  });

  // Upsert adminUsers doc
  const now = admin.firestore.FieldValue.serverTimestamp();
  const isNew = !(await db.collection("adminUsers").doc(targetUser.uid).get()).exists;
  await db
    .collection("adminUsers")
    .doc(targetUser.uid)
    .set(
      {
        uid: targetUser.uid,
        email: targetUser.email || "",
        displayName: targetUser.displayName || "",
        role: roles[0],    // backwards compat
        roles,             // canonical
        updatedAt: now,
        updatedBy: adminCtx.uid,
        ...(isNew
          ? { createdAt: now, createdBy: adminCtx.uid }
          : {}),
      },
      { merge: true },
    );

  // Revoke refresh tokens to force re-auth with new claims
  await admin.auth().revokeRefreshTokens(targetUser.uid);

  await logAdminAction(adminCtx.uid, "adminSetRole", "success", {
    targetUid: targetUser.uid,
    targetEmail: targetUser.email,
    newRoles: roles,
    actorEmail: adminCtx.email,
    actorRoles: adminCtx.roles,
  });

  return { success: true, uid: targetUser.uid, roles };
});

/** Create a new admin user by email. Creates Firebase Auth user if needed. */
export const adminCreateAdmin = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminCreateAdmin");
  const adminCtx = await requireAdminPermission(
    context,
    "admin:createAdmin",
    "adminCreateAdmin",
  );

  const { email, displayName, roles: inputRoles, role: inputRole } = data as {
    email: string;
    displayName: string;
    roles?: AdminRole[];
    role?: AdminRole;
  };

  if (!email || !displayName) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "email and displayName are required",
    );
  }

  const roles: AdminRole[] = inputRoles || (inputRole ? [inputRole] : []);
  if (roles.length === 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "At least one role is required",
    );
  }

  for (const r of roles) {
    if (!ADMIN_ROLES.includes(r)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid role: ${r}`,
      );
    }
  }

  // Only superAdmin can grant superAdmin
  if (roles.includes("superAdmin") && !adminCtx.roles.includes("superAdmin")) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only superAdmin can grant superAdmin role",
    );
  }

  // Find existing user by email, or create a new one
  let targetUser: admin.auth.UserRecord;
  let isNewUser = false;
  try {
    targetUser = await admin.auth().getUserByEmail(email);
  } catch {
    // User doesn't exist — create without password (they'll use "Reset Password")
    targetUser = await admin.auth().createUser({
      email,
      displayName,
    });
    isNewUser = true;
  }

  // Set custom claims
  const existingClaims = targetUser.customClaims || {};
  await admin.auth().setCustomUserClaims(targetUser.uid, {
    ...existingClaims,
    admin: true,
    superAdmin: roles.includes("superAdmin"),
    adminRole: roles[0],
    adminRoles: roles,
  });

  // Create adminUsers doc
  const now = admin.firestore.FieldValue.serverTimestamp();
  await db
    .collection("adminUsers")
    .doc(targetUser.uid)
    .set(
      {
        uid: targetUser.uid,
        email: targetUser.email || email,
        displayName: targetUser.displayName || displayName,
        role: roles[0],
        roles,
        createdAt: now,
        createdBy: adminCtx.uid,
        updatedAt: now,
        updatedBy: adminCtx.uid,
      },
      { merge: true },
    );

  // Generate password reset link for new users
  let passwordResetLink: string | null = null;
  if (isNewUser) {
    try {
      passwordResetLink = await admin.auth().generatePasswordResetLink(email);
    } catch (err) {
      console.error("Failed to generate password reset link:", err);
    }
  }

  await logAdminAction(adminCtx.uid, "adminCreateAdmin", "success", {
    targetUid: targetUser.uid,
    targetEmail: email,
    displayName,
    roles,
    isNewUser,
    actorEmail: adminCtx.email,
    actorRoles: adminCtx.roles,
  });

  return {
    success: true,
    uid: targetUser.uid,
    email: targetUser.email,
    roles,
    isNewUser,
    passwordResetLink,
  };
});

/** Remove admin access from a user entirely. */
export const adminRevokeRole = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminRevokeRole");
  const adminCtx = await requireAdminPermission(
    context,
    "admin:updateRole",
    "adminRevokeRole",
  );

  const { targetUid } = data as { targetUid: string };
  if (!targetUid) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "targetUid is required",
    );
  }

  if (targetUid === adminCtx.uid) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Cannot revoke your own admin access",
    );
  }

  // Remove admin claims
  const targetUser = await admin.auth().getUser(targetUid);
  const existingClaims = targetUser.customClaims || {};
  const { admin: _a, superAdmin: _s, adminRole: _r, adminRoles: _rs, ...otherClaims } = existingClaims;
  await admin.auth().setCustomUserClaims(targetUid, otherClaims);

  // Delete adminUsers doc
  await db.collection("adminUsers").doc(targetUid).delete();

  // Revoke sessions
  await admin.auth().revokeRefreshTokens(targetUid);

  await logAdminAction(adminCtx.uid, "adminRevokeRole", "success", {
    targetUid,
    targetEmail: targetUser.email,
    actorEmail: adminCtx.email,
    actorRoles: adminCtx.roles,
  });

  return { success: true };
});

/** Force sign out a specific admin by revoking their refresh tokens. */
export const adminForceSignOut = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminForceSignOut");
    const adminCtx = await requireAdminPermission(
      context,
      "admin:revokeSession",
      "adminForceSignOut",
    );

    const { targetUid } = data as { targetUid: string };
    if (!targetUid) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "targetUid is required",
      );
    }

    await admin.auth().revokeRefreshTokens(targetUid);

    await logAdminAction(adminCtx.uid, "adminForceSignOut", "success", {
      targetUid,
      actorEmail: adminCtx.email,
      actorRoles: adminCtx.roles,
    });

    return { success: true };
  },
);

// ─── Audit Log Query ─────────────────────────────────────────────────

/** Query the admin audit log with pagination and filters. */
export const adminGetAuditLogs = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminGetAuditLogs");
    await requireAdminPermission(
      context,
      "audit:viewLogs",
      "adminGetAuditLogs",
    );

    const {
      limit: reqLimit = 50,
      startAfterTimestamp,
      actorUid,
      action,
      outcome,
    } = (data || {}) as {
      limit?: number;
      startAfterTimestamp?: string;
      actorUid?: string;
      action?: string;
      outcome?: string;
    };

    const safeLimit = Math.min(Math.max(reqLimit, 1), 200);

    let ref: admin.firestore.Query = db.collection("adminAuditLog");

    if (actorUid) ref = ref.where("actorUid", "==", actorUid);
    if (action) ref = ref.where("action", "==", action);
    if (outcome) ref = ref.where("outcome", "==", outcome);

    let query = ref.orderBy("timestamp", "desc").limit(safeLimit);

    if (startAfterTimestamp) {
      const startDate = new Date(startAfterTimestamp);
      query = query.startAfter(admin.firestore.Timestamp.fromDate(startDate));
    }

    const snapshot = await query.get();
    const logs = snapshot.docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        ...d,
        timestamp: d.timestamp?.toDate?.()?.toISOString?.() || null,
      };
    });

    return { logs, hasMore: logs.length === safeLimit };
  },
);

// ─── Maker-Checker Functions ─────────────────────────────────────────

/** List pending actions awaiting approval. */
export const adminListPendingActions = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminListPendingActions");
    await requireAdminPermission(
      context,
      "pending:list",
      "adminListPendingActions",
    );

    const { status = "pending" } = (data || {}) as { status?: string };

    let query: admin.firestore.Query;

    if (status && status !== "all") {
      query = db
        .collection("adminPendingActions")
        .where("status", "==", status)
        .orderBy("createdAt", "desc")
        .limit(100);
    } else {
      query = db
        .collection("adminPendingActions")
        .orderBy("createdAt", "desc")
        .limit(100);
    }

    const snapshot = await query.get();
    const actions = snapshot.docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        ...d,
        createdAt: d.createdAt?.toDate?.()?.toISOString?.() || null,
        expiresAt: d.expiresAt?.toDate?.()?.toISOString?.() || null,
        completedAt: d.completedAt?.toDate?.()?.toISOString?.() || null,
      };
    });

    return { actions };
  },
);

/** Approve a pending action. Checker must be different from maker. */
export const adminApproveAction = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminApproveAction");
    const adminCtx = await requireAdminPermission(
      context,
      "pending:approve",
      "adminApproveAction",
    );

    const { pendingActionId } = data as { pendingActionId: string };
    if (!pendingActionId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pendingActionId is required",
      );
    }

    const actionRef = db.collection("adminPendingActions").doc(pendingActionId);
    const actionDoc = await actionRef.get();
    if (!actionDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Pending action not found");
    }

    const action = actionDoc.data() as AdminPendingAction;

    if (action.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Action is ${action.status}, not pending`,
      );
    }

    // Check expiry
    const expiresAt = action.expiresAt as admin.firestore.Timestamp;
    if (expiresAt.toDate() < new Date()) {
      await actionRef.update({ status: "expired" });
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Action has expired",
      );
    }

    // Maker !== checker
    if (action.makerUid === adminCtx.uid) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Maker and checker must be different admins",
      );
    }

    // Execute the original action
    let result: Record<string, unknown>;
    try {
      result = await executePendingAction(action);
    } catch (err: unknown) {
      const errorMsg = err instanceof Error ? err.message : String(err);
      await actionRef.update({
        status: "rejected",
        rejectionReason: `Execution failed: ${errorMsg}`,
        checkerUid: adminCtx.uid,
        checkerRole: adminCtx.role,
        checkerRoles: adminCtx.roles,
        checkerEmail: adminCtx.email,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw new functions.https.HttpsError(
        "internal",
        `Failed to execute action: ${errorMsg}`,
      );
    }

    // Mark approved
    await actionRef.update({
      status: "approved",
      checkerUid: adminCtx.uid,
      checkerRole: adminCtx.role,
      checkerRoles: adminCtx.roles,
      checkerEmail: adminCtx.email,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
      result,
    });

    await logAdminAction(adminCtx.uid, "adminApproveAction", "checker_approved", {
      pendingActionId,
      originalAction: action.functionName,
      makerUid: action.makerUid,
      actorEmail: adminCtx.email,
      actorRoles: adminCtx.roles,
    });

    return { success: true, result };
  },
);

/** Reject a pending action with a reason. */
export const adminRejectAction = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminRejectAction");
    const adminCtx = await requireAdminPermission(
      context,
      "pending:reject",
      "adminRejectAction",
    );

    const { pendingActionId, reason } = data as {
      pendingActionId: string;
      reason: string;
    };
    if (!pendingActionId || !reason) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pendingActionId and reason are required",
      );
    }

    const actionRef = db.collection("adminPendingActions").doc(pendingActionId);
    const actionDoc = await actionRef.get();
    if (!actionDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Pending action not found");
    }

    const action = actionDoc.data() as AdminPendingAction;
    if (action.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Action is ${action.status}, not pending`,
      );
    }

    await actionRef.update({
      status: "rejected",
      checkerUid: adminCtx.uid,
      checkerRole: adminCtx.role,
      checkerRoles: adminCtx.roles,
      checkerEmail: adminCtx.email,
      rejectionReason: reason,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminRejectAction", "checker_rejected", {
      pendingActionId,
      originalAction: action.functionName,
      reason,
      makerUid: action.makerUid,
      actorEmail: adminCtx.email,
      actorRoles: adminCtx.roles,
    });

    return { success: true };
  },
);

// ─── Migration ───────────────────────────────────────────────────────

/** One-time migration: backfill adminRole claims and create adminUsers docs. */
export const adminMigrateExistingClaims = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminMigrateExistingClaims");
    const adminCtx = await requireAdminPermission(
      context,
      "admin:updateRole",
      "adminMigrateExistingClaims",
    );

    const migrated: string[] = [];
    let nextPageToken: string | undefined;

    do {
      const listResult = await admin.auth().listUsers(1000, nextPageToken);

      for (const user of listResult.users) {
        const claims = user.customClaims || {};
        if ((claims.admin === true || claims.superAdmin === true) && !claims.adminRole) {
          const role: AdminRole =
            claims.superAdmin === true ? "superAdmin" : "campaignAdmin";

          await admin.auth().setCustomUserClaims(user.uid, {
            ...claims,
            adminRole: role,
            adminRoles: [role],
          });

          const now = admin.firestore.FieldValue.serverTimestamp();
          await db
            .collection("adminUsers")
            .doc(user.uid)
            .set(
              {
                uid: user.uid,
                email: user.email || "",
                displayName: user.displayName || "",
                role,
                roles: [role],
                createdAt: now,
                createdBy: adminCtx.uid,
                updatedAt: now,
                updatedBy: adminCtx.uid,
              },
              { merge: true },
            );

          migrated.push(user.uid);
        }
      }

      nextPageToken = listResult.pageToken;
    } while (nextPageToken);

    await logAdminAction(adminCtx.uid, "adminMigrateExistingClaims", "success", {
      migratedCount: migrated.length,
      migratedUids: migrated,
      actorEmail: adminCtx.email,
      actorRoles: adminCtx.roles,
    });

    return { success: true, migratedCount: migrated.length, migratedUids: migrated };
  },
);

// ─── Pending Action Expiry Cleanup ───────────────────────────────────

/** Clean up expired pending actions. Call from scheduled jobs. */
export async function cleanupExpiredPendingActions(): Promise<number> {
  const now = admin.firestore.Timestamp.now();
  const expired = await db
    .collection("adminPendingActions")
    .where("status", "==", "pending")
    .where("expiresAt", "<", now)
    .get();

  const batch = db.batch();
  for (const doc of expired.docs) {
    batch.update(doc.ref, { status: "expired" });
  }
  if (expired.size > 0) {
    await batch.commit();
  }
  return expired.size;
}

// ─── Maker-Checker Helpers ───────────────────────────────────────────

/**
 * Create a pending action for maker-checker approval.
 * Called by the modified fund/refund/cashout functions.
 */
export async function createPendingAction(
  adminCtx: AdminContext,
  actionType: AdminPermission,
  functionName: string,
  payload: Record<string, unknown>,
  description: string,
): Promise<{ pendingActionId: string }> {
  const pendingRef = db.collection("adminPendingActions").doc();
  const expiresAt = admin.firestore.Timestamp.fromDate(
    new Date(Date.now() + 72 * 60 * 60 * 1000),
  );

  const pendingAction: AdminPendingAction = {
    id: pendingRef.id,
    actionType,
    functionName,
    payload,
    description,
    makerUid: adminCtx.uid,
    makerRole: adminCtx.role,
    makerRoles: adminCtx.roles,
    makerEmail: adminCtx.email,
    status: "pending",
    checkerUid: null,
    checkerRole: null,
    checkerRoles: null,
    checkerEmail: null,
    rejectionReason: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt,
    completedAt: null,
    result: null,
  };

  await pendingRef.set(pendingAction);

  await logAdminAction(adminCtx.uid, functionName, "maker_created", {
    pendingActionId: pendingRef.id,
    actorEmail: adminCtx.email,
    actorRoles: adminCtx.roles,
    ...payload,
  });

  return { pendingActionId: pendingRef.id };
}

/**
 * Execute a pending action after approval.
 * This is a dispatch function — each action type imports and calls
 * its specific executor. We use dynamic imports to avoid circular deps.
 */
async function executePendingAction(
  action: AdminPendingAction,
): Promise<Record<string, unknown>> {
  switch (action.functionName) {
    case "adminFundClientAccount": {
      const { executeFundClient } = await import("./adminAccountsExecutors");
      return executeFundClient(action.payload);
    }
    case "adminRefundClient": {
      const { executeRefundClient } = await import("./adminAccountsExecutors");
      return executeRefundClient(action.payload);
    }
    case "completeCashoutRequest": {
      const { executeCompleteCashout } = await import("./adminAccountsExecutors");
      return executeCompleteCashout(action.payload);
    }
    default:
      throw new Error(`Unknown pending action: ${action.functionName}`);
  }
}
