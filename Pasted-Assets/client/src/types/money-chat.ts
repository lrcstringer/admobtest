export type Contact = {
  id: string;
  name: string;
  phoneNumber: string;
  isOnImaliChat: boolean;
  lastActiveAt?: string; // ISO string
  avatar?: string;
  initials: string;
  blocked?: boolean;
  referredByMe?: boolean;
  referralStatus?: "invited" | "joined";
};

export type MoneyChatThread = {
  id: string;
  contactId: string;
  lastUpdatedAt: string;
  lastMessage?: string;
  unreadCount?: number;
};

export type MoneyChatEntry = {
  id: string;
  threadId: string;
  direction: "sent" | "received" | "request_out" | "request_in";
  amount: number; // in minor units (e.g. cents) or tokens
  currency: "ZAR" | "TOKENS";
  status: "pending" | "completed" | "declined";
  createdAt: string;
  note?: string;
};
