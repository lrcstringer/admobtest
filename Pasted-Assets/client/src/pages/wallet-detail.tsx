import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Wallet, ShieldCheck, ShoppingBag, ArrowUpRight, ArrowDownLeft, History, Loader2 } from "lucide-react";
import { Link, useRoute } from "wouter";
import { motion } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";
import { useQuery } from "@tanstack/react-query";
import { walletApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function WalletDetail() {
  const [, params] = useRoute("/wallets/:id");
  const walletId = params?.id;
  const { toast } = useToast();

  const { data: wallets, isLoading, error } = useQuery({
    queryKey: ["wallets"],
    queryFn: walletApi.getWallets,
  });

  if (error) {
    toast({
      title: "Error loading wallet",
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

  const wallet = wallets?.find((w: any) => w.id === walletId) || wallets?.[0];

  if (!wallet) {
    return (
      <MobileFrame>
        <div className="flex items-center justify-center h-screen">
          <div className="text-center">
            <h3 className="text-white font-bold mb-1">Wallet not found</h3>
            <p className="text-muted-foreground text-sm mb-4">
              The requested wallet could not be found.
            </p>
            <Link href="/wallets">
              <Button>Back to Wallets</Button>
            </Link>
          </div>
        </div>
      </MobileFrame>
    );
  }

  const getWalletColor = (type: string) => {
    if (type === "main") return "from-primary to-pink-600";
    return "from-blue-600 to-blue-800";
  };

  const walletColor = getWalletColor(wallet.type);
  const balanceValue = (wallet.balance / 100).toFixed(2);
  const balanceTokens = wallet.balance;

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        {/* Header */}
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/wallets">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">{wallet.name}</h1>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto p-6">
          {/* Main Card */}
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="relative overflow-hidden rounded-3xl bg-card border border-white/10 shadow-xl mb-8"
          >
            <div className={`absolute top-0 left-0 w-full h-1.5 bg-gradient-to-r ${walletColor}`} />
            
            <div className="p-6">
              <div className="flex items-center gap-4 mb-6">
                 <div className={`w-14 h-14 rounded-full flex items-center justify-center bg-white/5 border border-white/10 overflow-hidden`}>
                  {wallet.type === 'main' ? (
                    <div className="bg-white w-full h-full p-1.5 flex items-center justify-center">
                      <img src={appLogo} alt="iMali" className="w-full h-full object-contain" />
                    </div>
                  ) : (
                    <ShoppingBag size={28} className="text-white/80" />
                  )}
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-white">R {balanceValue}</h2>
                  <p className="text-sm text-muted-foreground">{balanceTokens.toLocaleString()} Tokens</p>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <Link href={`/wallets/${wallet.id}/send`}>
                  <Button className="w-full bg-white text-black hover:bg-white/90 font-bold h-12 shadow-lg">
                    <ArrowUpRight size={18} className="mr-2" />
                    Send
                  </Button>
                </Link>
                <Button className="w-full bg-white/5 text-white hover:bg-white/10 font-bold h-12 border border-white/10 opacity-50 cursor-not-allowed">
                  <ArrowDownLeft size={18} className="mr-2" />
                  Withdraw
                </Button>
              </div>
            </div>
          </motion.div>

          {/* Details */}
          <div className="space-y-4">
            <h3 className="text-sm font-bold text-muted-foreground uppercase tracking-wider pl-1">Wallet Details</h3>
            
            <div className="bg-white/5 rounded-2xl p-4 border border-white/5 space-y-4">
               <div className="flex justify-between items-center py-1">
                 <span className="text-sm text-muted-foreground">Type</span>
                 <span className="text-sm font-bold text-white capitalize">{wallet.type}</span>
               </div>
               <div className="h-px bg-white/5" />
               <div className="flex justify-between items-center py-1">
                 <span className="text-sm text-muted-foreground">Description</span>
                 <span className="text-sm font-medium text-white text-right max-w-[60%]">
                   {wallet.type === 'main' ? 'Spend anywhere or withdraw' : 'Use for brand purchases'}
                 </span>
               </div>
               <div className="h-px bg-white/5" />
               <div className="flex justify-between items-center py-1">
                 <span className="text-sm text-muted-foreground">Withdrawal Status</span>
                 <div className="flex items-center gap-2">
                   {wallet.type === 'main' ? (
                     <>
                       <ShieldCheck size={14} className="text-green-400" />
                       <span className="text-sm font-bold text-green-400">Available</span>
                     </>
                   ) : (
                     <span className="text-sm font-bold text-white/50">Restricted</span>
                   )}
                 </div>
               </div>
            </div>
          </div>
        </div>
      </div>
    </MobileFrame>
  );
}