import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { CheckCircle2, Home, Copy, Zap } from "lucide-react";
import { Link, useRoute } from "wouter";
import { motion } from "framer-motion";
import { useToast } from "@/hooks/use-toast";

export default function BuyElectricitySuccess() {
  const [, params] = useRoute("/buy/electricity/success/:amount/:meterNumber");
  const amount = params?.amount;
  const meterNumber = params?.meterNumber;
  const { toast } = useToast();

  const token = "4452 1102 3365 8894 5521"; // Mock 20-digit token

  const copyToken = () => {
    navigator.clipboard.writeText(token.replace(/\s/g, ""));
    toast({
      title: "Token Copied",
      description: "Electricity token copied to clipboard",
    });
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background items-center justify-center p-6 text-center">
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ type: "spring", stiffness: 200, damping: 20 }}
          className="w-20 h-20 rounded-full bg-green-500/20 flex items-center justify-center mb-6"
        >
          <CheckCircle2 size={40} className="text-green-500" />
        </motion.div>

        <h1 className="text-2xl font-heading font-bold text-white mb-2">Purchase Successful!</h1>
        <p className="text-muted-foreground mb-8 text-sm">
          You bought R{amount} electricity for meter {meterNumber}
        </p>

        {/* Token Card */}
        <div className="w-full bg-card border border-white/10 rounded-2xl p-6 mb-8 relative overflow-hidden">
           <div className="absolute top-0 right-0 w-24 h-24 bg-yellow-500/10 blur-[40px] rounded-full -mr-10 -mt-10" />
           
           <p className="text-xs text-muted-foreground uppercase tracking-widest font-bold mb-2">Your Token</p>
           <p className="text-2xl font-mono font-bold text-white mb-4 tracking-wider">{token}</p>
           
           <div className="flex items-center justify-center gap-2">
             <span className="bg-yellow-500/20 text-yellow-500 px-2 py-1 rounded text-[10px] font-bold uppercase flex items-center gap-1">
               <Zap size={10} fill="currentColor" />
               Units: {Number(amount) * 0.4} kWh
             </span>
           </div>

           <Button 
             variant="outline" 
             size="sm" 
             className="mt-6 border-white/10 hover:bg-white/5 text-white w-full gap-2"
             onClick={copyToken}
           >
             <Copy size={14} />
             Copy Token
           </Button>
        </div>

        <div className="w-full space-y-3">
          <Link href="/buy">
            <Button className="w-full h-12 font-bold bg-primary hover:bg-primary/90 text-white">
              Buy More
            </Button>
          </Link>
          <Link href="/home">
            <Button variant="ghost" className="w-full font-bold text-white hover:bg-white/10">
              <Home size={18} className="mr-2" />
              Back to Home
            </Button>
          </Link>
        </div>
      </div>
    </MobileFrame>
  );
}