import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ChatAPI } from "@/lib/fake-api-chat";
import { Contact } from "@/types/money-chat";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Loader2, Wallet, ShoppingBag } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useLocation, useRoute } from "wouter";
import { motion } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

export default function ChatSend() {
  const [, params] = useRoute("/chat/send/:contactId/:walletId");
  const [, setLocation] = useLocation();
  const contactId = params?.contactId;
  const walletId = params?.walletId;
  
  const [contact, setContact] = useState<Contact | null>(null);
  const [amount, setAmount] = useState("");
  const [note, setNote] = useState("");
  const [loading, setLoading] = useState(true);
  const [sending, setSending] = useState(false);
  const { toast } = useToast();

  // Mock wallets (should be shared or fetched)
  const wallets = [
    {
      id: "imali",
      name: "iMaliChat Wallet",
      balanceValue: 357.00,
      icon: null
    },
    {
      id: "nike",
      name: "Nike SA Wallet",
      balanceValue: 12.00,
      icon: ShoppingBag
    },
    {
      id: "checkers",
      name: "Checkers Wallet",
      balanceValue: 8.00,
      icon: ShoppingBag
    }
  ];

  const selectedWallet = wallets.find(w => w.id === walletId);

  useEffect(() => {
    if (contactId) {
      loadContact();
    }
  }, [contactId]);

  const loadContact = async () => {
    setLoading(true);
    const contacts = await ChatAPI.getContacts();
    const c = contacts.find(c => c.id === contactId);
    setContact(c || null);
    setLoading(false);
  };

  const handleSend = async () => {
    if (!amount || isNaN(Number(amount))) return;
    
    setSending(true);
    await ChatAPI.sendMoney(contactId!, Number(amount), note);
    setSending(false);
    
    toast({
      title: "Money Sent!",
      description: `You sent R${amount} to ${contact?.name}`,
      duration: 2000,
    });
    
    setLocation(`/chat/${contactId}`);
  };

  if (loading) return <div className="h-full bg-background" />;

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      <header className="px-4 py-4 flex items-center gap-3 relative z-10">
        <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full" onClick={() => history.back()}>
          <ArrowLeft size={20} />
        </Button>
        <h1 className="text-lg font-bold text-white">Send Money</h1>
      </header>

      <div className="flex-1 px-6 flex flex-col items-center pt-4">
        <div className="w-full flex items-center justify-between bg-white/5 rounded-xl p-3 mb-6 border border-white/10">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center overflow-hidden">
               {selectedWallet?.id === 'imali' ? (
                  <div className="bg-white w-full h-full p-0.5 flex items-center justify-center">
                    <img src={appLogo} alt="iMali" className="w-full h-full object-contain" />
                  </div>
                ) : (
                  selectedWallet?.icon && <selectedWallet.icon size={14} className="text-white" />
                )}
            </div>
            <div>
              <p className="text-xs text-muted-foreground">From</p>
              <p className="text-sm font-bold text-white">{selectedWallet?.name}</p>
            </div>
          </div>
          <div className="text-right">
             <p className="text-xs text-muted-foreground">Available</p>
             <p className="text-sm font-bold text-secondary">R {selectedWallet?.balanceValue.toFixed(2)}</p>
          </div>
        </div>

        <Avatar className="h-20 w-20 border-2 border-white/10 mb-4">
          <AvatarFallback className="bg-primary/20 text-primary text-2xl font-bold">
            {contact?.initials}
          </AvatarFallback>
        </Avatar>
        
        <p className="text-muted-foreground mb-1">Sending to</p>
        <h2 className="text-2xl font-bold text-white mb-8">{contact?.name}</h2>

        <div className="w-full max-w-xs relative mb-8">
          <span className="absolute left-0 top-1/2 -translate-y-1/2 text-4xl font-bold text-white/50">R</span>
          <Input 
            type="number" 
            autoFocus
            className="text-center text-5xl font-bold bg-transparent border-none text-white focus-visible:ring-0 px-8 h-20 placeholder:text-white/20"
            placeholder="0"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
        </div>

        <Input 
          className="bg-white/5 border-white/10 text-white placeholder:text-muted-foreground mb-4"
          placeholder="Add a note (optional)"
          value={note}
          onChange={(e) => setNote(e.target.value)}
        />

        <Button 
          className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg mt-auto mb-8"
          disabled={!amount || sending}
          onClick={handleSend}
        >
          {sending ? <Loader2 className="animate-spin" /> : "Send Money"}
        </Button>
      </div>
    </MobileFrame>
  );
}
