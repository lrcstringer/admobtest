import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { ArrowLeft, ChevronRight, ShoppingBag, Loader2 } from "lucide-react";
import { Link } from "wouter";
import { motion } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";
import { useQuery } from "@tanstack/react-query";
import { walletApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function BuyElectricityWallet() {
  const { toast } = useToast();

  const { data: walletsData, isLoading, error } = useQuery({
    queryKey: ["wallets"],
    queryFn: walletApi.getWallets,
  });

  if (error) {
    toast({
      title: "Error loading wallets",
      description: "Failed to load wallet data",
      variant: "destructive",
    });
  }

  if (isLoading) {
    return (
      <MobileFrame>
        <div className="flex items-center justify-center h-screen">
          <Loader2 className="h-8 w-8 animate-spin text-primary" />
        </div>
      </MobileFrame>
    );
  }

  const wallets = (walletsData || []).map((w: any) => ({
    ...w,
    balanceValue: (w.balance / 100).toFixed(2),
    color: w.type === "main" ? "from-primary to-pink-600" : "from-blue-600 to-blue-800",
    qualifies: w.type === "main"
  }));

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/buy">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <div>
              <h1 className="text-xl font-heading font-bold text-white">Select Wallet</h1>
              <p className="text-xs text-muted-foreground">Which wallet do you want to pay with?</p>
            </div>
          </div>
        </header>

        <div className="p-6 space-y-4">
          {wallets.map((wallet, index) => (
            <div key={wallet.id}>
              {wallet.qualifies ? (
                <Link href={`/buy/electricity/meter/${wallet.id}`}>
                  <motion.div
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                    whileTap={{ scale: 0.98 }}
                    className="relative overflow-hidden rounded-2xl bg-card border border-white/10 hover:border-primary/50 transition-colors cursor-pointer group shadow-lg"
                  >
                    <div className={`absolute top-0 left-0 w-1.5 h-full bg-gradient-to-b ${wallet.color}`} />
                    <div className="p-5 pl-7 flex items-center justify-between">
                      <div className="flex items-center gap-4">
                         <div className={`w-12 h-12 rounded-full flex items-center justify-center bg-white/5 border border-white/10 overflow-hidden`}>
                          {wallet.type === 'main' ? (
                            <div className="bg-white w-full h-full p-1.5 flex items-center justify-center">
                              <img src={appLogo} alt="iMali" className="w-full h-full object-contain" />
                            </div>
                          ) : (
                            <ShoppingBag size={20} className="text-white/80" />
                          )}
                        </div>
                        <div>
                          <h3 className="font-bold text-white text-base">{wallet.name}</h3>
                          <p className="text-sm font-bold text-secondary">R {wallet.balanceValue.toFixed(2)}</p>
                        </div>
                      </div>
                      <ChevronRight size={20} className="text-white/30 group-hover:text-primary transition-colors" />
                    </div>
                  </motion.div>
                </Link>
              ) : (
                <motion.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 0.5, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                  className="relative overflow-hidden rounded-2xl bg-card/50 border border-white/5 grayscale"
                >
                  <div className="p-5 pl-7 flex items-center justify-between">
                    <div className="flex items-center gap-4">
                       <div className={`w-12 h-12 rounded-full flex items-center justify-center bg-white/5 border border-white/10 overflow-hidden`}>
                          <ShoppingBag size={20} className="text-white/80" />
                      </div>
                      <div>
                        <h3 className="font-bold text-white text-base">{wallet.name}</h3>
                        <p className="text-xs text-muted-foreground mt-1">Not eligible for Electricity</p>
                      </div>
                    </div>
                  </div>
                </motion.div>
              )}
            </div>
          ))}
        </div>
      </div>
    </MobileFrame>
  );
}