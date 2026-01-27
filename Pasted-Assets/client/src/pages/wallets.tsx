import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";
import { ArrowLeft, Wallet, ChevronRight, History, ArrowUpRight, ShieldCheck, ShoppingBag } from "lucide-react";
import { Link } from "wouter";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

export default function Wallets() {
  const totalValue = 377.00;
  
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

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background pb-20 overflow-y-auto">
        {/* Header */}
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3 mb-6">
            <h1 className="text-2xl font-heading font-bold text-white">My Wallets</h1>
          </div>
          
          <div className="flex justify-between items-end mb-2">
            <div>
              <p className="text-muted-foreground text-sm font-medium mb-1">Total Portfolio Value</p>
              <h2 className="text-4xl font-heading font-bold text-white tracking-tight">
                R {totalValue.toFixed(2)}
              </h2>
            </div>
            <Link href="/transactions">
              <Button variant="outline" size="sm" className="bg-white/5 border-white/10 hover:bg-white/10 text-white gap-2 h-9 rounded-full px-4">
                <History size={14} />
                <span className="text-xs font-bold">History</span>
                <ChevronRight size={12} className="opacity-50" />
              </Button>
            </Link>
          </div>
        </header>

        {/* Wallets List */}
        <div className="px-6 py-4 space-y-4">
          <p className="text-sm text-muted-foreground font-bold uppercase tracking-wider pl-1 mb-2">Your Assets</p>
          
          {wallets.map((wallet, index) => (
            <motion.div
              key={wallet.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              whileTap={{ scale: 0.98 }}
            >
              <Link href={`/wallets/${wallet.id}`}>
                <div className="relative overflow-hidden rounded-2xl bg-card border border-white/5 hover:border-white/10 transition-colors cursor-pointer group shadow-lg">
                  <div className={`absolute top-0 left-0 w-1.5 h-full bg-gradient-to-b ${wallet.color}`} />
                  
                  <div className="p-5 pl-7">
                    <div className="flex justify-between items-start mb-3">
                      <div className="flex items-center gap-3">
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
                          <p className="text-xs text-muted-foreground mt-0.5">{wallet.description}</p>
                        </div>
                      </div>
                      
                      {wallet.canWithdraw && (
                         <div className="bg-green-500/10 text-green-400 p-1.5 rounded-full">
                           <ShieldCheck size={14} />
                         </div>
                      )}
                    </div>
                    
                    <div className="flex justify-between items-end mt-4">
                       <div>
                         <span className="text-2xl font-bold text-white block">
                           {wallet.balanceTokens.toLocaleString()} <span className="text-sm font-medium text-muted-foreground">Tokens</span>
                         </span>
                         <span className="text-xs text-white/50 font-medium">
                           ≈ R {wallet.balanceValue.toFixed(2)}
                         </span>
                       </div>
                       
                       <div className="bg-white/5 rounded-full p-2 text-white/30 group-hover:text-white group-hover:bg-white/10 transition-all">
                         <ArrowUpRight size={18} />
                       </div>
                    </div>
                  </div>
                </div>
              </Link>
            </motion.div>
          ))}
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}
