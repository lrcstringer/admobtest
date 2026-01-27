import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Check } from "lucide-react";
import { Link, useRoute } from "wouter";
import { motion } from "framer-motion";
import { useState } from "react";

const PROVIDERS = [
  { id: "vodacom", name: "Vodacom", color: "bg-red-600", textColor: "text-white" },
  { id: "mtn", name: "MTN", color: "bg-yellow-400", textColor: "text-black" },
  { id: "cellc", name: "Cell C", color: "bg-orange-500", textColor: "text-white" },
  { id: "telkom", name: "Telkom", color: "bg-blue-500", textColor: "text-white" },
];

export default function BuyAirtimeProvider() {
  const [, params] = useRoute("/buy/airtime/provider/:walletId");
  const walletId = params?.walletId;

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/buy/airtime/wallet">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <div>
              <h1 className="text-xl font-heading font-bold text-white">Select Network</h1>
              <p className="text-xs text-muted-foreground">Who is your service provider?</p>
            </div>
          </div>
        </header>

        <div className="p-6 grid grid-cols-2 gap-4">
          {PROVIDERS.map((provider, index) => (
            <Link key={provider.id} href={`/buy/airtime/product/${walletId}/${provider.id}`}>
              <motion.div
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: index * 0.05 }}
                whileTap={{ scale: 0.95 }}
                className={`${provider.color} aspect-square rounded-2xl flex flex-col items-center justify-center p-4 cursor-pointer shadow-lg relative overflow-hidden group`}
              >
                <div className="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors" />
                <span className={`text-xl font-bold ${provider.textColor} relative z-10`}>{provider.name}</span>
              </motion.div>
            </Link>
          ))}
        </div>
      </div>
    </MobileFrame>
  );
}