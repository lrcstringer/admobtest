import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ChatAPI } from "@/lib/fake-api-chat";
import { Contact } from "@/types/money-chat";
import { ArrowLeft, Wallet, ShoppingBag, ChevronRight } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useLocation, useRoute } from "wouter";
import { motion } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

export default function ChatSendSelectWallet() {
  const [, params] = useRoute("/chat/send/:contactId");
  const contactId = params?.contactId;
  const [contact, setContact] = useState<Contact | null>(null);
  const [loading, setLoading] = useState(true);

  // Mock wallets data
  const wallets = [
    {
      id: "imali",
      name: "iMaliChat Wallet",
      type: "General",
      balanceTokens: 3570,
      balanceValue: 357.00,
      color: "from-primary to-pink-600",
      icon: null, // Use app logo
      description: "Spend anywhere or withdraw",
      canWithdraw: true
    },
    {
      id: "nike",
      name: "Nike SA Wallet",
      type: "Brand",
      balanceTokens: 120,
      balanceValue: 12.00,
      color: "from-blue-600 to-blue-800",
      icon: ShoppingBag,
      description: "Use for Nike purchases",
      canWithdraw: false
    },
    {
      id: "checkers",
      name: "Checkers Wallet",
      type: "Brand",
      balanceTokens: 80,
      balanceValue: 8.00,
      color: "from-teal-600 to-teal-800",
      icon: ShoppingBag,
      description: "Use for Sixty60 coupons",
      canWithdraw: false
    }
  ];

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

  if (loading) return <div className="h-full bg-background" />;

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      <header className="px-4 py-4 flex items-center gap-3 relative z-10">
        <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full" onClick={() => history.back()}>
          <ArrowLeft size={20} />
        </Button>
        <h1 className="text-lg font-bold text-white">Select Wallet</h1>
      </header>

      <div className="flex-1 px-6 pt-4">
        <div className="flex flex-col items-center mb-8">
          <Avatar className="h-16 w-16 border-2 border-white/10 mb-3">
            <AvatarFallback className="bg-primary/20 text-primary text-xl font-bold">
              {contact?.initials}
            </AvatarFallback>
          </Avatar>
          <p className="text-muted-foreground text-sm">Sending to</p>
          <h2 className="text-xl font-bold text-white">{contact?.name}</h2>
        </div>

        <p className="text-sm text-muted-foreground font-bold uppercase tracking-wider mb-4">Choose Source Wallet</p>

        <div className="space-y-4">
          {wallets.map((wallet, index) => (
            <Link key={wallet.id} href={`/chat/send/${contactId}/${wallet.id}`}>
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className="relative overflow-hidden rounded-2xl bg-card border border-white/5 hover:border-white/10 transition-colors cursor-pointer group shadow-lg mb-4"
              >
                <div className={`absolute top-0 left-0 w-1.5 h-full bg-gradient-to-b ${wallet.color}`} />
                
                <div className="p-4 pl-6 flex items-center justify-between">
                  <div className="flex items-center gap-4">
                    <div className={`w-10 h-10 rounded-full flex items-center justify-center bg-white/5 border border-white/10 overflow-hidden`}>
                      {wallet.id === 'imali' ? (
                        <div className="bg-white w-full h-full p-1 flex items-center justify-center">
                          <img src={appLogo} alt="iMali" className="w-full h-full object-contain" />
                        </div>
                      ) : (
                        wallet.icon && <wallet.icon size={18} className="text-white/80" />
                      )}
                    </div>
                    <div>
                      <h3 className="font-bold text-white text-base leading-tight">{wallet.name}</h3>
                      <div className="text-sm text-white/70">
                        R {wallet.balanceValue.toFixed(2)} <span className="text-white/30">•</span> {wallet.balanceTokens} Tokens
                      </div>
                    </div>
                  </div>
                  <ChevronRight size={20} className="text-white/30 group-hover:text-white transition-colors" />
                </div>
              </motion.div>
            </Link>
          ))}
        </div>
      </div>
    </MobileFrame>
  );
}
