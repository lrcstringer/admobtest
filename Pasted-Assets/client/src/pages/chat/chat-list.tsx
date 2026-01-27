import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useToast } from "@/hooks/use-toast";
import { Search, UserPlus, Users, ChevronRight, Loader2, ArrowUpRight, Check, X, MessageCircle, Gift } from "lucide-react";
import { useState } from "react";
import { Link, useLocation } from "wouter";
import { motion, AnimatePresence } from "framer-motion";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { contactsApi, moneyChatApi, referralApi } from "@/lib/api";

export default function ChatList() {
  const [searchQuery, setSearchQuery] = useState("");
  const [activeTab, setActiveTab] = useState("chats");
  const [filter, setFilter] = useState<"all" | "on_imali" | "invite">("all");
  
  // Bulk Invite State
  const [isSelectionMode, setIsSelectionMode] = useState(false);
  const [selectedContacts, setSelectedContacts] = useState<string[]>([]);
  const [isInviteMode, setIsInviteMode] = useState(false);
  
  const { toast } = useToast();
  const [location] = useLocation();
  const queryClient = useQueryClient();

  // Fetch contacts
  const { data: contacts = [], isLoading: loadingContacts } = useQuery({
    queryKey: ["/api/contacts"],
    queryFn: contactsApi.getContacts,
  });

  // Fetch threads
  const { data: threads = [], isLoading: loadingThreads } = useQuery({
    queryKey: ["/api/money-chat/threads"],
    queryFn: moneyChatApi.getThreads,
  });

  // Combine threads with contacts
  const recentChats = threads.map((thread: any) => {
    const contact = contacts.find((c: any) => c.id === thread.contactId);
    return { ...thread, contact };
  });

  const loading = loadingContacts || loadingThreads;
  const hasSynced = contacts.length > 0; // Assume synced if we have contacts

  // Sync contacts mutation
  const syncMutation = useMutation({
    mutationFn: contactsApi.syncContacts,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/contacts"] });
      toast({
        title: "Contacts Synced",
        description: "Your contacts have been synced successfully",
      });
    },
  });

  const syncing = syncMutation.isPending;

  // Send invite mutation
  const inviteMutation = useMutation({
    mutationFn: (phoneNumber: string) => referralApi.sendInvite(phoneNumber),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/referrals"] });
      queryClient.invalidateQueries({ queryKey: ["/api/contacts"] });
    },
  });

  const handleSync = async () => {
    try {
      // For now, sync with empty contacts array - in real app, would get from device
      await syncMutation.mutateAsync([]);
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to sync contacts",
        variant: "destructive",
      });
    }
  };

  const handleInvite = async (contact: any) => {
    try {
      await inviteMutation.mutateAsync(contact.phoneNumber);
      toast({
        title: "Invite Sent",
        description: `Invitation sent to ${contact.name}`,
      });
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to send invite",
        variant: "destructive",
      });
    }
  };

  const toggleSelectionMode = () => {
    if (isSelectionMode) {
      setIsSelectionMode(false);
      setSelectedContacts([]);
      setFilter("all");
    } else {
      setIsSelectionMode(true);
      setFilter("invite");
    }
  };

  const toggleContactSelection = (contactId: string) => {
    if (selectedContacts.includes(contactId)) {
      setSelectedContacts(selectedContacts.filter(id => id !== contactId));
    } else {
      setSelectedContacts([...selectedContacts, contactId]);
    }
  };

  const handleBulkInvite = async () => {
    if (selectedContacts.length === 0) return;
    
    const selectedContactObjs = contacts.filter((c: any) => selectedContacts.includes(c.id));
    
    try {
      for (const contact of selectedContactObjs) {
        await inviteMutation.mutateAsync(contact.phoneNumber);
      }
      
      toast({
        title: "Invites Sent",
        description: `Sent invites to ${selectedContacts.length} friends`,
      });
      
      toggleSelectionMode();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to send some invites",
        variant: "destructive",
      });
    }
  };

  const filteredContacts = contacts.filter((c: any) => {
    const matchesSearch = c.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          c.phoneNumber.includes(searchQuery);
    
    if (!matchesSearch) return false;

    if (isSelectionMode) {
      return !c.isOnImaliChat;
    }

    if (filter === "on_imali") return c.isOnImaliChat;
    if (filter === "invite") return !c.isOnImaliChat;
    return true;
  });

  const filteredChats = recentChats.filter((chat: any) => 
    chat.contact?.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
    chat.contact?.phoneNumber.includes(searchQuery)
  );

  const switchToPeople = () => {
    setActiveTab("people");
  };

  if (loading) {
    return (
      <MobileFrame>
        <div className="flex flex-col h-full bg-background items-center justify-center">
          <Loader2 className="animate-spin text-primary" size={32} />
        </div>
        <BottomNav />
      </MobileFrame>
    );
  }

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background pb-20 overflow-hidden">
        {/* Header */}
        <header className="px-6 pt-6 pb-2 bg-background/95 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
          <div className="flex justify-between items-center mb-4">
            <h1 className="text-2xl font-heading font-bold text-white">Money Chat</h1>
            {activeTab === "people" && hasSynced && isSelectionMode ? (
              <Button 
                variant="ghost" 
                size="sm" 
                className="text-primary hover:text-primary hover:bg-primary/10 rounded-full px-3"
                onClick={toggleSelectionMode}
              >
                Cancel
              </Button>
            ) : null}
          </div>
          
          {hasSynced && (
            <Tabs value={activeTab} onValueChange={(val) => {
              if (isSelectionMode && !isInviteMode) toggleSelectionMode(); // Exit selection mode on tab change unless in strict invite mode
              setActiveTab(val);
            }} className="w-full">
              <TabsList className="w-full bg-white/5 p-1 rounded-xl mb-4 border border-white/5">
                <TabsTrigger 
                  value="chats" 
                  className="flex-1 font-bold data-[state=active]:bg-white/10 data-[state=active]:text-white rounded-lg transition-all"
                >
                  Chats
                </TabsTrigger>
                <TabsTrigger 
                  value="people" 
                  className="flex-1 font-bold data-[state=active]:bg-white/10 data-[state=active]:text-white rounded-lg transition-all"
                >
                  People
                </TabsTrigger>
              </TabsList>
            </Tabs>
          )}
        </header>

        <div className="flex-1 overflow-y-auto relative">
          {!hasSynced ? (
            <div className="flex flex-col items-center justify-center h-full px-8 text-center space-y-6">
              <div className="w-24 h-24 bg-primary/10 rounded-full flex items-center justify-center mb-2">
                <Users size={48} className="text-primary" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-white">Send and receive value with your people</h2>
                <p className="text-muted-foreground text-sm leading-relaxed">
                  Sync your contacts to see who’s already on iMaliChat and invite others with one tap.
                </p>
              </div>
              <div className="w-full space-y-3 pt-4">
                <Button 
                  className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-12"
                  onClick={handleSync}
                  disabled={syncing}
                >
                  {syncing ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Syncing...
                    </>
                  ) : (
                    "Sync my contacts"
                  )}
                </Button>
              </div>
            </div>
          ) : (
            <>
              {activeTab === "chats" && (
                <div className="flex flex-col min-h-full pb-20">
                  <div className="px-6 py-4 sticky top-0 z-10 bg-background/95 backdrop-blur-md">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
                      <Input 
                        placeholder="Search chats..." 
                        className="pl-9 bg-white/5 border-white/10 text-white placeholder:text-muted-foreground focus-visible:ring-primary"
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                      />
                    </div>
                  </div>

                  <div className="space-y-1">
                    {filteredChats.length > 0 ? (
                      filteredChats.map((chat: any) => (
                        <Link key={chat.id} href={`/chat/${chat.contactId}`}>
                          <div className="px-6 py-4 flex items-center gap-4 hover:bg-white/5 transition-colors cursor-pointer">
                            <div className="relative">
                              <Avatar className="h-12 w-12 border border-white/10">
                                <AvatarFallback className="bg-secondary text-secondary-foreground font-bold">
                                  {chat.contact?.initials}
                                </AvatarFallback>
                              </Avatar>
                              {chat.contact?.blocked && (
                                <span className="absolute -bottom-1 -right-1 bg-red-500 text-white text-[9px] font-bold px-1.5 py-0.5 rounded-full border border-background">
                                  BLOCKED
                                </span>
                              )}
                            </div>
                            <div className="flex-1 min-w-0">
                              <div className="flex justify-between items-baseline mb-0.5">
                                <h3 className={`font-bold truncate ${chat.unreadCount ? "text-white" : "text-white/80"}`}>
                                  {chat.contact?.name}
                                </h3>
                                <div className="flex items-center gap-2">
                                  <span className={`text-[10px] ${chat.unreadCount ? "text-secondary font-bold" : "text-muted-foreground"}`}>
                                    {new Date(chat.lastUpdatedAt).toLocaleDateString()}
                                  </span>
                                  {chat.unreadCount > 0 && (
                                    <span className="bg-secondary text-secondary-foreground text-[10px] font-bold px-1.5 min-w-[18px] h-[18px] rounded-full flex items-center justify-center">
                                      {chat.unreadCount}
                                    </span>
                                  )}
                                </div>
                              </div>
                              <p className={`text-sm truncate ${chat.unreadCount ? "text-white font-medium" : "text-muted-foreground"}`}>
                                {chat.contact?.blocked ? (
                                  <span className="text-red-400 italic">Blocked</span>
                                ) : (
                                  chat.lastMessage
                                )}
                              </p>
                            </div>
                          </div>
                        </Link>
                      ))
                    ) : (
                      <div className="text-center py-12 px-6">
                        <p className="text-muted-foreground text-sm">No active chats found.</p>
                        <Button variant="link" onClick={switchToPeople} className="text-secondary font-bold mt-2">
                          Start a new chat
                        </Button>
                      </div>
                    )}
                  </div>
                  
                  {/* Sticky Send Button */}
                  <div className="fixed bottom-[110px] left-0 right-0 px-6 pointer-events-none flex justify-center">
                    <Button 
                      onClick={switchToPeople}
                      className="bg-primary hover:bg-primary/90 text-white font-bold h-12 shadow-[0_8px_30px_rgba(255,51,138,0.4)] pointer-events-auto rounded-full px-8 flex items-center gap-2 transform transition-transform active:scale-95"
                    >
                      <ArrowUpRight size={18} />
                      Send / Request Money
                    </Button>
                  </div>
                </div>
              )}

              {activeTab === "people" && (
                <div className="pb-28">
                  {/* Invite Mode Banner */}
                  {isInviteMode && (
                    <div className="bg-gradient-to-r from-secondary/20 to-orange-500/20 px-6 py-3 border-b border-white/5 flex items-start gap-3">
                      <div className="w-8 h-8 rounded-full bg-secondary/20 flex items-center justify-center shrink-0 mt-0.5">
                        <Gift size={16} className="text-secondary" />
                      </div>
                      <div>
                        <p className="text-sm text-white font-bold">Invite friends & earn</p>
                        <p className="text-xs text-muted-foreground">Select contacts to invite. If they sign up, you'll both receive a starter bonus.</p>
                      </div>
                    </div>
                  )}

                  <div className="px-6 py-4 sticky top-0 z-10 bg-background/95 backdrop-blur-md space-y-4">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
                      <Input 
                        placeholder="Search people..." 
                        className="pl-9 bg-white/5 border-white/10 text-white placeholder:text-muted-foreground focus-visible:ring-primary"
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                      />
                    </div>
                    
                    {/* Filters - Hide in Selection Mode */}
                    {!isSelectionMode && (
                      <div className="flex items-center justify-between gap-2 pb-1">
                        <div className="flex gap-2 overflow-x-auto no-scrollbar flex-1">
                          <Badge 
                            variant={filter === "all" ? "default" : "outline"} 
                            className={`cursor-pointer ${filter === "all" ? "bg-white text-black hover:bg-white/90" : "text-muted-foreground hover:text-white border-white/10"}`}
                            onClick={() => setFilter("all")}
                          >
                            All
                          </Badge>
                          <Badge 
                            variant={filter === "on_imali" ? "default" : "outline"} 
                            className={`cursor-pointer ${filter === "on_imali" ? "bg-secondary text-secondary-foreground hover:bg-secondary/90" : "text-muted-foreground hover:text-white border-white/10"}`}
                            onClick={() => setFilter("on_imali")}
                          >
                            On iMaliChat
                          </Badge>
                          <Badge 
                            variant={filter === "invite" ? "default" : "outline"} 
                            className={`cursor-pointer ${filter === "invite" ? "bg-primary text-white hover:bg-primary/90" : "text-muted-foreground hover:text-white border-white/10"}`}
                            onClick={() => setFilter("invite")}
                          >
                            Invite
                          </Badge>
                        </div>
                        <Button 
                          variant="ghost" 
                          size="sm"
                          className="text-xs font-bold text-primary hover:text-primary hover:bg-primary/10 h-7 px-2"
                          onClick={toggleSelectionMode}
                        >
                          Invite Many
                        </Button>
                      </div>
                    )}
                    
                    {isSelectionMode && (
                      <div className="flex items-center justify-between bg-white/5 px-4 py-2 rounded-lg border border-white/5">
                        <span className="text-sm font-medium text-white">{selectedContacts.length} selected</span>
                        <span className="text-xs text-muted-foreground">Select friends to invite</span>
                      </div>
                    )}
                  </div>

                  <div className="space-y-1">
                    {filteredContacts.length > 0 ? (
                      filteredContacts.map((contact: any) => (
                        <div key={contact.id} onClick={() => isSelectionMode && !contact.isOnImaliChat && toggleContactSelection(contact.id)}>
                          {isSelectionMode ? (
                            <div className="px-6 py-3 flex items-center gap-4 hover:bg-white/5 transition-colors cursor-pointer group">
                              <Checkbox 
                                checked={selectedContacts.includes(contact.id)}
                                onCheckedChange={() => toggleContactSelection(contact.id)}
                                disabled={contact.isOnImaliChat} // Disable selection for users already on app
                                className="border-white/20 data-[state=checked]:bg-primary data-[state=checked]:border-primary disabled:opacity-30"
                              />
                              <Avatar className={`h-10 w-10 border border-white/10 ${contact.isOnImaliChat ? "opacity-30" : "opacity-60"}`}>
                                <AvatarFallback className="bg-white/5 text-muted-foreground font-bold">
                                  {contact.initials}
                                </AvatarFallback>
                              </Avatar>
                              <div className={`flex-1 min-w-0 ${contact.isOnImaliChat ? "opacity-30" : "opacity-80"}`}>
                                <h3 className="text-white font-bold truncate">{contact.name}</h3>
                                <p className="text-xs text-muted-foreground">{contact.phoneNumber}</p>
                              </div>
                            </div>
                          ) : (
                            <Link href={contact.isOnImaliChat ? `/chat/${contact.id}` : "#"}>
                              <div className="px-6 py-3 flex items-center gap-4 hover:bg-white/5 transition-colors cursor-pointer group">
                                <Avatar className={`h-10 w-10 border border-white/10 ${!contact.isOnImaliChat && "opacity-60"}`}>
                                  <AvatarFallback className={`${contact.isOnImaliChat ? "bg-primary/20 text-primary" : "bg-white/5 text-muted-foreground"} font-bold`}>
                                    {contact.initials}
                                  </AvatarFallback>
                                </Avatar>
                                <div className={`flex-1 min-w-0 ${!contact.isOnImaliChat && "opacity-80"}`}>
                                  <h3 className="text-white font-bold truncate">{contact.name}</h3>
                                  <p className="text-xs text-muted-foreground">{contact.phoneNumber}</p>
                                </div>
                                
                                {contact.isOnImaliChat ? (
                                  <div className="flex items-center gap-3">
                                    <Badge variant="secondary" className="bg-secondary/10 text-secondary border-0 text-[10px] uppercase font-bold px-1.5 h-5">
                                      iMali
                                    </Badge>
                                    <Button size="sm" variant="ghost" className="h-8 w-8 p-0 rounded-full text-muted-foreground group-hover:text-white group-hover:bg-white/10">
                                      <ChevronRight size={18} />
                                    </Button>
                                  </div>
                                ) : (
                                  <Button 
                                    size="sm" 
                                    variant="outline" 
                                    className="h-8 text-xs border-white/10 hover:bg-white/10 text-white gap-1.5"
                                    onClick={(e) => {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      handleInvite(contact);
                                    }}
                                  >
                                    <MessageCircle size={12} className="text-green-400" />
                                    Invite
                                  </Button>
                                )}
                              </div>
                            </Link>
                          )}
                        </div>
                      ))
                    ) : (
                      <div className="text-center py-12">
                        <p className="text-muted-foreground text-sm">No contacts found.</p>
                      </div>
                    )}
                  </div>
                  
                  {/* Bulk Invite Action Bar */}
                  <AnimatePresence>
                    {isSelectionMode && selectedContacts.length > 0 && (
                      <motion.div 
                        initial={{ y: 100 }}
                        animate={{ y: 0 }}
                        exit={{ y: 100 }}
                        className="fixed bottom-[90px] left-0 right-0 px-6 z-30"
                      >
                        <Button 
                          onClick={handleBulkInvite}
                          className="w-full bg-green-600 hover:bg-green-500 text-white font-bold h-12 shadow-lg rounded-full flex items-center justify-center gap-2"
                        >
                          <MessageCircle size={20} />
                          Invite {selectedContacts.length} via WhatsApp
                        </Button>
                      </motion.div>
                    )}
                  </AnimatePresence>
                </div>
              )}
            </>
          )}
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}