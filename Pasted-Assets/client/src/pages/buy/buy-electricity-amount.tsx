import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { ArrowLeft, Zap, Loader2, Home } from "lucide-react";
import { Link, useRoute, useLocation } from "wouter";
import { motion } from "framer-motion";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";

export default function BuyElectricityAmount() {
  const [, params] = useRoute("/buy/electricity/amount/:walletId/:meterNumber");
  const [, setLocation] = useLocation();
  const walletId = params?.walletId;
  const meterNumber = params?.meterNumber;
  
  const [amount, setAmount] = useState("");
  const [buying, setBuying] = useState(false);
  const { toast } = useToast();

  const handleBuy = async () => {
    if (!amount || isNaN(Number(amount))) return;
    
    setBuying(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500));
    setBuying(false);
    
    setLocation(`/buy/electricity/success/${amount}/${meterNumber}`);
  };

  const quickAmounts = [50, 100, 200, 500];

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href={`/buy/electricity/meter/${walletId}`}>
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <div>
              <h1 className="text-xl font-heading font-bold text-white">Buy Electricity</h1>
              <p className="text-xs text-muted-foreground">Enter amount to purchase</p>
            </div>
          </div>
        </header>

        <div className="flex-1 px-6 flex flex-col pt-4">
           {/* Mock Verified Meter Card */}
           <div className="bg-white/5 rounded-xl p-4 border border-white/10 mb-8 flex items-center gap-4">
              <div className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center">
                 <Home size={20} className="text-white/70" />
              </div>
              <div>
                 <p className="text-xs text-muted-foreground uppercase font-bold">Verified Meter</p>
                 <p className="text-white font-mono font-bold">{meterNumber}</p>
                 <p className="text-xs text-green-400">John Doe • Cape Town</p>
              </div>
           </div>

           <div className="w-full max-w-xs relative mb-8 mx-auto">
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

            <div className="grid grid-cols-4 gap-2 mb-8">
               {quickAmounts.map((amt) => (
                 <Button 
                   key={amt}
                   variant="outline" 
                   className="bg-white/5 border-white/10 hover:bg-white/10 text-white font-bold h-10"
                   onClick={() => setAmount(amt.toString())}
                 >
                   R{amt}
                 </Button>
               ))}
            </div>

           <Button 
             className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg mt-auto mb-8"
             disabled={!amount || buying}
             onClick={handleBuy}
           >
             {buying ? <Loader2 className="animate-spin" /> : "Purchase Electricity"}
           </Button>
        </div>
      </div>
    </MobileFrame>
  );
}