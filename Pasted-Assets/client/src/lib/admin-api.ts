const API_BASE = "/api/admin";

async function fetchApi(endpoint: string, options?: RequestInit) {
  const res = await fetch(`${API_BASE}${endpoint}`, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      ...options?.headers,
    },
    credentials: "include",
  });

  if (!res.ok) {
    const error = await res.json().catch(() => ({ message: "Request failed" }));
    throw new Error(error.message || "Request failed");
  }

  // Handle CSV responses
  if (res.headers.get("content-type")?.includes("text/csv")) {
    return res.text();
  }

  return res.json();
}

export const adminApi = {
  // Auth
  register: (data: {
    email: string;
    password: string;
    firstName?: string;
    lastName?: string;
    companyName: string;
    brandName: string;
    vatNumber?: string;
    registrationNumber?: string;
    acceptedTerms: boolean;
    acceptedPopia: boolean;
  }) => fetchApi("/auth/register", { method: "POST", body: JSON.stringify(data) }),

  getMe: () => fetchApi("/auth/me"),

  // Organization
  getOrg: (orgId: string) => fetchApi(`/orgs/${orgId}`),
  inviteMember: (orgId: string, data: { email: string; role: string }) =>
    fetchApi(`/orgs/${orgId}/invite`, { method: "POST", body: JSON.stringify(data) }),

  // Wallet
  getWallet: (orgId: string) => fetchApi(`/orgs/${orgId}/wallet`),
  requestTopUp: (orgId: string, data: { amount: number; proofOfPaymentUrl?: string; reference?: string }) =>
    fetchApi(`/orgs/${orgId}/wallet/topup`, { method: "POST", body: JSON.stringify(data) }),

  // Campaigns
  getCampaigns: (orgId: string, status?: string) =>
    fetchApi(`/orgs/${orgId}/campaigns${status ? `?status=${status}` : ""}`),
  getCampaign: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}`),
  createCampaign: (orgId: string, data: any) =>
    fetchApi(`/orgs/${orgId}/campaigns`, { method: "POST", body: JSON.stringify(data) }),
  updateCampaign: (orgId: string, campaignId: string, data: any) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}`, { method: "PUT", body: JSON.stringify(data) }),
  submitCampaign: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/submit`, { method: "POST" }),
  pauseCampaign: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/pause`, { method: "POST" }),
  resumeCampaign: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/resume`, { method: "POST" }),

  // Creatives
  addCreative: (orgId: string, campaignId: string, data: any) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/creatives`, { method: "POST", body: JSON.stringify(data) }),
  deleteCreative: (orgId: string, campaignId: string, creativeId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/creatives/${creativeId}`, { method: "DELETE" }),

  // Survey Questions
  updateQuestions: (orgId: string, campaignId: string, questions: any[]) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/questions`, { method: "POST", body: JSON.stringify({ questions }) }),

  // Analytics
  getCampaignMetrics: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/metrics`),
  exportCampaignMetrics: (orgId: string, campaignId: string) =>
    fetchApi(`/orgs/${orgId}/campaigns/${campaignId}/export`),

  // Super Admin
  superAdmin: {
    getTopUps: (status?: string) => fetchApi(`/super/topups${status ? `?status=${status}` : ""}`),
    approveTopUp: (topUpId: string) => fetchApi(`/super/topups/${topUpId}/approve`, { method: "POST" }),
    rejectTopUp: (topUpId: string, reason: string) =>
      fetchApi(`/super/topups/${topUpId}/reject`, { method: "POST", body: JSON.stringify({ reason }) }),

    getPendingCampaigns: () => fetchApi("/super/campaigns/pending"),
    approveCampaign: (campaignId: string) => fetchApi(`/super/campaigns/${campaignId}/approve`, { method: "POST" }),
    rejectCampaign: (campaignId: string, reason: string) =>
      fetchApi(`/super/campaigns/${campaignId}/reject`, { method: "POST", body: JSON.stringify({ reason }) }),
    activateCampaign: (campaignId: string) => fetchApi(`/super/campaigns/${campaignId}/activate`, { method: "POST" }),

    getUsers: (params?: { search?: string; role?: string; page?: number; limit?: number }) => {
      const searchParams = new URLSearchParams();
      if (params?.search) searchParams.set("search", params.search);
      if (params?.role) searchParams.set("role", params.role);
      if (params?.page) searchParams.set("page", params.page.toString());
      if (params?.limit) searchParams.set("limit", params.limit.toString());
      return fetchApi(`/super/users?${searchParams.toString()}`);
    },
    getUser: (userId: string) => fetchApi(`/super/users/${userId}`),

    getSettings: () => fetchApi("/super/settings"),
    updateSetting: (key: string, value: string, description?: string) =>
      fetchApi(`/super/settings/${key}`, { method: "PUT", body: JSON.stringify({ value, description }) }),

    getOrgs: () => fetchApi("/super/orgs"),
  },
};
