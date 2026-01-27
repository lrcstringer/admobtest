import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { ArrowLeft, Zap, Loader2 } from "lucide-react";
import { Link, useRoute, useLocation } from "wouter";
import { motion } from "framer-motion";
import { useState } from "react";

export default function BuyElectricityMeter() {
  const [, params] = useRoute("/buy/electricity/meter/:walletId");
  const [, setLocation] = useLocation();
  const walletId = params?.walletId;
  
  const [meterNumber, setMeterNumber] = useState("");
  const [verifying, setVerifying] = useState(false);

  const handleVerify = async () => {
    if (meterNumber.length < 11) return;
    
    setVerifying(true);
    // Simulate verification delay
    await new Promise(resolve => setTimeout(resolve, 1000));
    setVerifying(false);
    
    setLocation(`/buy/electricity/amount/${walletId}/${meterNumber}`);
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/buy/electricity/wallet">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <div>
              <h1 className="text-xl font-heading font-bold text-white">Meter Number</h1>
              <p className="text-xs text-muted-foreground">Enter your prepaid meter number</p>
            </div>
          </div>
        </header>

        <div className="flex-1 px-6 flex flex-col pt-8">
           <div className="w-20 h-20 rounded-full bg-yellow-500/10 flex items-center justify-center border border-yellow-500/20 mx-auto mb-8">
             <Zap size={40} className="text-yellow-500" />
           </div>

           <div className="space-y-4">
             <label className="text-sm font-bold text-white ml-1">Meter Number</label>
             <Input 
               type="number" 
               className="bg-white/5 border-white/10 text-white h-14 text-lg font-mono placeholder:text-muted-foreground"
               placeholder="Enter 11-13 digit number"
               value={meterNumber}
               onChange={(e) => setMeterNumber(e.target.value)}
               autoFocus
             />
             <p className="text-xs text-muted-foreground ml-1">
               Usually found on the front of your meter or on previous receipts.
             </p>
           </div>

           <Button 
             className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg mt-auto mb-8"
             disabled={meterNumber.length < 11 || verifying}
             onClick={handleVerify}
           >
             {verifying ? <Loader2 className="animate-spin" /> : "Verify Meter"}
           </Button>
        </div>
      </div>
    </MobileFrame>
  );
}