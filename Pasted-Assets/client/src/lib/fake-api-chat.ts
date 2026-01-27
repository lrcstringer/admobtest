import { Contact, MoneyChatThread, MoneyChatEntry } from "@/types/money-chat";

// Mock Data
const CONTACTS: Contact[] = [
  { id: "c1", name: "Thabo Molefe", phoneNumber: "082 123 4567", isOnImaliChat: true, lastActiveAt: new Date(Date.now() - 1000 * 60 * 60 * 2).toISOString(), initials: "TM", referredByMe: true, referralStatus: "joined" },
  { id: "c2", name: "Sarah James", phoneNumber: "071 987 6543", isOnImaliChat: true, lastActiveAt: new Date(Date.now() - 1000 * 60 * 5).toISOString(), initials: "SJ" },
  { id: "c3", name: "Lerato Khumalo", phoneNumber: "063 555 1234", isOnImaliChat: true, lastActiveAt: new Date(Date.now() - 1000 * 60 * 60 * 24).toISOString(), initials: "LK", referredByMe: true, referralStatus: "joined" },
  { id: "c4", name: "Mike Davis", phoneNumber: "083 222 3333", isOnImaliChat: false, initials: "MD", referredByMe: true, referralStatus: "invited" },
  { id: "c5", name: "Zodwa P", phoneNumber: "072 444 5555", isOnImaliChat: false, initials: "ZP" },
  { id: "c6", name: "John Smith", phoneNumber: "081 111 2222", isOnImaliChat: false, initials: "JS" },
  { id: "c7", name: "Nandi Mthembu", phoneNumber: "076 555 9999", isOnImaliChat: false, initials: "NM", referredByMe: true, referralStatus: "invited" },
];

const THREADS: MoneyChatThread[] = [
  { id: "t1", contactId: "c1", lastUpdatedAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 2).toISOString(), lastMessage: "You sent R50", unreadCount: 0 },
  { id: "t2", contactId: "c2", lastUpdatedAt: new Date(Date.now() - 1000 * 60 * 30).toISOString(), lastMessage: "Sarah requested R20", unreadCount: 2 },
];

const ENTRIES: MoneyChatEntry[] = [
  { id: "e1", threadId: "t1", direction: "sent", amount: 50, currency: "ZAR", status: "completed", createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 2).toISOString(), note: "Lunch money" },
  { id: "e2", threadId: "t2", direction: "request_in", amount: 20, currency: "ZAR", status: "pending", createdAt: new Date(Date.now() - 1000 * 60 * 30).toISOString(), note: "Uber share" },
  { id: "e3", threadId: "t2", direction: "received", amount: 100, currency: "ZAR", status: "completed", createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 5).toISOString(), note: "Refund" },
];

// Simulation State (in-memory for prototype)
let _contacts = [...CONTACTS];
let _threads = [...THREADS];
let _entries = [...ENTRIES];
let _hasSynced = false;

export const ChatAPI = {
  hasSyncedContacts: async () => {
    await new Promise(resolve => setTimeout(resolve, 500));
    return _hasSynced;
  },

  syncContacts: async () => {
    await new Promise(resolve => setTimeout(resolve, 1500));
    _hasSynced = true;
    return _contacts;
  },

  getContacts: async () => {
    await new Promise(resolve => setTimeout(resolve, 200));
    return _contacts;
  },

  getRecentChats: async () => {
    await new Promise(resolve => setTimeout(resolve, 300));
    return _threads.map(t => {
      const contact = _contacts.find(c => c.id === t.contactId);
      return { ...t, contact };
    });
  },

  getThread: async (contactId: string) => {
    await new Promise(resolve => setTimeout(resolve, 200));
    let thread = _threads.find(t => t.contactId === contactId);
    if (!thread) {
      // Auto-create thread if it doesn't exist for UI purposes
      thread = { id: `t_${Date.now()}`, contactId, lastUpdatedAt: new Date().toISOString() };
      _threads.push(thread);
    }
    const entries = _entries.filter(e => e.threadId === thread!.id).sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());
    const contact = _contacts.find(c => c.id === contactId);
    return { thread, entries, contact };
  },

  sendInvite: async (contactId: string) => {
    await new Promise(resolve => setTimeout(resolve, 1000));
    return true;
  },

  blockContact: async (contactId: string) => {
    await new Promise(resolve => setTimeout(resolve, 500));
    const contact = _contacts.find(c => c.id === contactId);
    if (contact) contact.blocked = true;
    return true;
  },

  unblockContact: async (contactId: string) => {
    await new Promise(resolve => setTimeout(resolve, 500));
    const contact = _contacts.find(c => c.id === contactId);
    if (contact) contact.blocked = false;
    return true;
  },

  sendMoney: async (contactId: string, amount: number, note?: string) => {
    await new Promise(resolve => setTimeout(resolve, 1000));
    let thread = _threads.find(t => t.contactId === contactId);
    if (!thread) {
       thread = { id: `t_${Date.now()}`, contactId, lastUpdatedAt: new Date().toISOString() };
       _threads.push(thread);
    }
    
    const newEntry: MoneyChatEntry = {
      id: `e_${Date.now()}`,
      threadId: thread.id,
      direction: "sent",
      amount,
      currency: "ZAR",
      status: "completed",
      createdAt: new Date().toISOString(),
      note
    };
    _entries.push(newEntry);
    
    // Update thread last message
    thread.lastUpdatedAt = newEntry.createdAt;
    thread.lastMessage = `You sent R${amount}`;
    
    return newEntry;
  },

  requestMoney: async (contactId: string, amount: number, note?: string) => {
    await new Promise(resolve => setTimeout(resolve, 1000));
    let thread = _threads.find(t => t.contactId === contactId);
    if (!thread) {
       thread = { id: `t_${Date.now()}`, contactId, lastUpdatedAt: new Date().toISOString() };
       _threads.push(thread);
    }
    
    const newEntry: MoneyChatEntry = {
      id: `e_${Date.now()}`,
      threadId: thread.id,
      direction: "request_out",
      amount,
      currency: "ZAR",
      status: "pending",
      createdAt: new Date().toISOString(),
      note
    };
    _entries.push(newEntry);

    // Update thread last message
    thread.lastUpdatedAt = newEntry.createdAt;
    thread.lastMessage = `You requested R${amount}`;

    return newEntry;
  }
};
