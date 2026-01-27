import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { CheckCircle2, Home, ArrowRight } from "lucide-react";
import { Link } from "wouter";
import { motion } from "framer-motion";

export default function BuySuccess() {
  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background items-center justify-center p-8 text-center">
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ type: "spring", stiffness: 200, damping: 20 }}
          className="w-24 h-24 rounded-full bg-green-500/20 flex items-center justify-center mb-8"
        >
          <CheckCircle2 size={48} className="text-green-500" />
        </motion.div>

        <h1 className="text-3xl font-heading font-bold text-white mb-4">Purchase Successful!</h1>
        <p className="text-muted-foreground mb-8 text-lg">
          Your recharge has been processed. You will receive an SMS confirmation shortly.
        </p>

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