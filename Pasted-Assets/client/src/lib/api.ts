import { apiRequest } from "./queryClient";

// ===== AUTH API =====

export const authApi = {
  login: async (username: string, password: string) => {
    const res = await apiRequest("POST", "/api/auth/login", { username, password });
    return res.json();
  },

  register: async (data: {
    username: string;
    password: string;
    phoneNumber: string;
    firstName?: string;
    lastName?: string;
  }) => {
    const res = await apiRequest("POST", "/api/auth/register", data);
    return res.json();
  },

  logout: async () => {
    const res = await apiRequest("POST", "/api/auth/logout");
    return res.json();
  },

  getMe: async () => {
    const res = await fetch("/api/auth/me", {
      credentials: "include",
    });
    if (!res.ok) {
      if (res.status === 401) return null;
      throw new Error("Failed to get user");
    }
    return res.json();
  },
};

// ===== USER API =====

export const userApi = {
  getProfile: async () => {
    const res = await fetch("/api/user/profile", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get profile");
    return res.json();
  },

  updateProfile: async (data: { firstName?: string; lastName?: string }) => {
    const res = await apiRequest("PATCH", "/api/user/profile", data);
    return res.json();
  },
};

// ===== WALLET API =====

export const walletApi = {
  getWallets: async () => {
    const res = await fetch("/api/wallets", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get wallets");
    return res.json();
  },

  getWallet: async (id: string) => {
    const res = await fetch(`/api/wallets/${id}`, {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get wallet");
    return res.json();
  },
};

// ===== TRANSACTION API =====

export const transactionApi = {
  getTransactions: async (limit = 50) => {
    const res = await fetch(`/api/transactions?limit=${limit}`, {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get transactions");
    return res.json();
  },
};

// ===== CONTACTS API =====

export const contactsApi = {
  syncContacts: async (contacts: Array<{ name: string; phoneNumber: string }>) => {
    const res = await apiRequest("POST", "/api/contacts/sync", { contacts });
    return res.json();
  },

  getContacts: async () => {
    const res = await fetch("/api/contacts", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get contacts");
    return res.json();
  },

  blockContact: async (contactId: string) => {
    const res = await apiRequest("POST", `/api/contacts/${contactId}/block`);
    return res.json();
  },

  unblockContact: async (contactId: string) => {
    const res = await apiRequest("POST", `/api/contacts/${contactId}/unblock`);
    return res.json();
  },
};

// ===== MONEY CHAT API =====

export const moneyChatApi = {
  getThreads: async () => {
    const res = await fetch("/api/money-chat/threads", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get threads");
    return res.json();
  },

  getThread: async (contactId: string) => {
    const res = await fetch(`/api/money-chat/threads/${contactId}`, {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get thread");
    return res.json();
  },

  sendMoney: async (data: {
    contactId: string;
    amount: string;
    walletId: string;
    note?: string;
  }) => {
    const res = await apiRequest("POST", "/api/money-chat/send", data);
    return res.json();
  },

  requestMoney: async (data: {
    contactId: string;
    amount: string;
    note?: string;
  }) => {
    const res = await apiRequest("POST", "/api/money-chat/request", data);
    return res.json();
  },
};

// ===== EARN API =====

export const earnApi = {
  getThreads: async () => {
    const res = await fetch("/api/earn/threads", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get earn threads");
    return res.json();
  },

  getOpportunities: async (threadId: string) => {
    const res = await fetch(`/api/earn/opportunities/${threadId}`, {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get opportunities");
    return res.json();
  },

  completeOpportunity: async (opportunityId: string) => {
    const res = await apiRequest("POST", `/api/earn/complete/${opportunityId}`);
    return res.json();
  },
};

// ===== REFERRAL API =====

export const referralApi = {
  getReferrals: async () => {
    const res = await fetch("/api/referrals", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get referrals");
    return res.json();
  },

  sendInvite: async (phoneNumber: string) => {
    const res = await apiRequest("POST", "/api/referrals/invite", { phoneNumber });
    return res.json();
  },
};

// ===== LEADERBOARD API =====

export const leaderboardApi = {
  getDaily: async () => {
    const res = await fetch("/api/leaderboard/daily", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get daily leaderboard");
    return res.json();
  },

  getWeekly: async () => {
    const res = await fetch("/api/leaderboard/weekly", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get weekly leaderboard");
    return res.json();
  },
};

// ===== POTS API =====

export const potsApi = {
  getDaily: async () => {
    const res = await fetch("/api/pots/daily", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get daily pot");
    return res.json();
  },

  getWeekly: async () => {
    const res = await fetch("/api/pots/weekly", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get weekly pot");
    return res.json();
  },
};

// ===== PURCHASE API =====

export const purchaseApi = {
  buyAirtime: async (data: {
    walletId: string;
    provider: string;
    recipientNumber: string;
    amount: string;
  }) => {
    const res = await apiRequest("POST", "/api/purchases/airtime", data);
    return res.json();
  },

  buyData: async (data: {
    walletId: string;
    provider: string;
    recipientNumber: string;
    amount: string;
    metadata?: string;
  }) => {
    const res = await apiRequest("POST", "/api/purchases/data", data);
    return res.json();
  },

  buyElectricity: async (data: {
    walletId: string;
    meterNumber: string;
    amount: string;
  }) => {
    const res = await apiRequest("POST", "/api/purchases/electricity", data);
    return res.json();
  },

  getHistory: async (limit = 50) => {
    const res = await fetch(`/api/purchases/history?limit=${limit}`, {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get purchase history");
    return res.json();
  },
};

// ===== HOME API =====

export const homeApi = {
  getSummary: async () => {
    const res = await fetch("/api/home/summary", {
      credentials: "include",
    });
    if (!res.ok) throw new Error("Failed to get home summary");
    return res.json();
  },
};
