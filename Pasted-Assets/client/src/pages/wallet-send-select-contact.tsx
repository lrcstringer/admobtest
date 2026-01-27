import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { ChatAPI } from "@/lib/fake-api-chat";
import { Contact } from "@/types/money-chat";
import { ArrowLeft, Search, Loader2, Users, AlertCircle } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useRoute } from "wouter";
import { motion } from "framer-motion";

export default function WalletSendSelectContact() {
  const [, params] = useRoute("/wallets/:id/send");
  const walletId = params?.id;
  
  const [loading, setLoading] = useState(true);
  const [hasSynced, setHasSynced] = useState(false);
  const [contacts, setContacts] = useState<Contact[]>([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [syncing, setSyncing] = useState(false);

  useEffect(() => {
    checkSyncStatus();
  }, []);

  const checkSyncStatus = async () => {
    setLoading(true);
    const synced = await ChatAPI.hasSyncedContacts();
    setHasSynced(synced);
    if (synced) {
      const c = await ChatAPI.getContacts();
      // Only show contacts on iMaliChat for sending money
      setContacts(c.filter(contact => contact.isOnImaliChat));
    }
    setLoading(false);
  };

  const handleSync = async () => {
    setSyncing(true);
    const newContacts = await ChatAPI.syncContacts();
    setContacts(newContacts.filter(c => c.isOnImaliChat));
    setHasSynced(true);
    setSyncing(false);
  };

  const filteredContacts = contacts.filter(c => 
    c.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
    c.phoneNumber.includes(searchQuery)
  );

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
             <Link href={`/wallets/${walletId}`}>
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">Send to...</h1>
          </div>
        </header>

        {loading ? (
          <div className="flex-1 flex items-center justify-center">
            <Loader2 className="animate-spin text-primary" size={32} />
          </div>
        ) : !hasSynced ? (
          <div className="flex-1 flex flex-col items-center justify-center p-8 text-center space-y-6">
            <div className="w-24 h-24 bg-white/5 rounded-full flex items-center justify-center mb-2">
              <Users size={48} className="text-white/50" />
            </div>
            <div className="space-y-2">
              <h2 className="text-xl font-bold text-white">Sync Contacts</h2>
              <p className="text-muted-foreground text-sm leading-relaxed">
                To send money, you need to sync your contacts to see who is available on iMaliChat.
              </p>
            </div>
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
        ) : (
          <div className="flex-1 overflow-y-auto">
             <div className="px-6 py-4 sticky top-0 z-10 bg-background/95 backdrop-blur-md">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
                <Input 
                  placeholder="Search people..." 
                  className="pl-9 bg-white/5 border-white/10 text-white placeholder:text-muted-foreground focus-visible:ring-primary"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
            </div>

            <div className="space-y-1 pb-20">
              {filteredContacts.length > 0 ? (
                filteredContacts.map((contact) => (
                  <Link key={contact.id} href={`/wallets/${walletId}/send/${contact.id}`}>
                    <div className="px-6 py-3 flex items-center gap-4 hover:bg-white/5 transition-colors cursor-pointer group">
                      <Avatar className="h-12 w-12 border border-white/10">
                        <AvatarFallback className="bg-primary/20 text-primary font-bold">
                          {contact.initials}
                        </AvatarFallback>
                      </Avatar>
                      <div className="flex-1 min-w-0">
                        <h3 className="text-white font-bold truncate">{contact.name}</h3>
                        <p className="text-xs text-muted-foreground">{contact.phoneNumber}</p>
                      </div>
                      <Badge variant="secondary" className="bg-secondary/10 text-secondary border-0 text-[10px] uppercase font-bold px-2">
                        Select
                      </Badge>
                    </div>
                  </Link>
                ))
              ) : (
                <div className="text-center py-12 px-6">
                  <p className="text-muted-foreground text-sm">No contacts found on iMaliChat.</p>
                </div>
              )}
            </div>
          </div>
        )}
      </div>
    </MobileFrame>
  );
}