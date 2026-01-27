import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { motion } from "framer-motion";
import { Smartphone, Zap, ArrowRight, ShoppingCart, History, ChevronRight, Sparkles } from "lucide-react";
import { Link } from "wouter";

export default function BuyHome() {
  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background pb-20 relative overflow-hidden">
         {/* Background Decoration */}
        <div className="absolute top-0 left-0 w-full h-64 bg-gradient-to-b from-primary/10 to-transparent pointer-events-none" />
        
        <header className="px-6 pt-8 pb-4 sticky top-0 z-20 bg-background/80 backdrop-blur-md">
          <div className="flex justify-between items-start">
            <div>
              <h1 className="text-3xl font-heading font-bold text-white mb-1">Buy Services</h1>
              <p className="text-muted-foreground text-sm">Use your earnings for real-world value</p>
            </div>
            <Link href="/buy/history">
              <Button variant="outline" size="icon" className="bg-white/5 border-white/10 hover:bg-white/10 text-white rounded-full h-10 w-10">
                <History size={18} />
              </Button>
            </Link>
          </div>
        </header>

        <div className="p-6 space-y-6 flex-1 overflow-y-auto">
          <div className="grid grid-cols-1 gap-6">
            <Link href="/buy/airtime/wallet">
              <motion.div
                whileTap={{ scale: 0.98 }}
                className="cursor-pointer group"
              >
                <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-blue-900/40 to-slate-900/40 border border-blue-500/20 hover:border-blue-500/50 transition-all h-48 shadow-lg">
                  <div className="absolute top-0 right-0 w-40 h-40 bg-blue-500/20 blur-[60px] rounded-full -mr-10 -mt-10 group-hover:bg-blue-500/30 transition-all" />
                  
                  <div className="absolute bottom-0 left-0 w-full h-1/2 bg-gradient-to-t from-black/50 to-transparent" />

                  <div className="p-6 h-full flex flex-col justify-between relative z-10">
                    <div className="flex justify-between items-start">
                      <div className="w-14 h-14 rounded-2xl bg-blue-500/20 flex items-center justify-center border border-blue-500/20 backdrop-blur-md group-hover:scale-110 transition-transform duration-300">
                        <Smartphone size={28} className="text-blue-400" />
                      </div>
                      <div className="bg-blue-500/20 text-blue-300 text-[10px] font-bold px-2 py-1 rounded-full border border-blue-500/20 uppercase tracking-wider">
                        Instant
                      </div>
                    </div>
                    
                    <div className="flex justify-between items-end">
                      <div>
                        <h3 className="text-xl font-bold text-white mb-1">Airtime & Data</h3>
                        <p className="text-sm text-blue-200/60">Vodacom, MTN, Cell C, Telkom</p>
                      </div>
                      <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center group-hover:bg-blue-500 group-hover:text-white transition-colors">
                        <ArrowRight size={20} />
                      </div>
                    </div>
                  </div>
                </div>
              </motion.div>
            </Link>

            <Link href="/buy/electricity/wallet">
              <motion.div
                whileTap={{ scale: 0.98 }}
                className="cursor-pointer group"
              >
                <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-yellow-900/40 to-amber-900/40 border border-yellow-500/20 hover:border-yellow-500/50 transition-all h-48 shadow-lg">
                  <div className="absolute top-0 right-0 w-40 h-40 bg-yellow-500/20 blur-[60px] rounded-full -mr-10 -mt-10 group-hover:bg-yellow-500/30 transition-all" />
                  
                  <div className="absolute bottom-0 left-0 w-full h-1/2 bg-gradient-to-t from-black/50 to-transparent" />

                  <div className="p-6 h-full flex flex-col justify-between relative z-10">
                    <div className="flex justify-between items-start">
                      <div className="w-14 h-14 rounded-2xl bg-yellow-500/20 flex items-center justify-center border border-yellow-500/20 backdrop-blur-md group-hover:scale-110 transition-transform duration-300">
                        <Zap size={28} className="text-yellow-400" />
                      </div>
                      <div className="bg-yellow-500/20 text-yellow-300 text-[10px] font-bold px-2 py-1 rounded-full border border-yellow-500/20 uppercase tracking-wider">
                        Prepaid
                      </div>
                    </div>
                    
                    <div className="flex justify-between items-end">
                      <div>
                        <h3 className="text-xl font-bold text-white mb-1">Electricity</h3>
                        <p className="text-sm text-yellow-200/60">Buy tokens for any meter</p>
                      </div>
                      <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center group-hover:bg-yellow-500 group-hover:text-black transition-colors">
                        <ArrowRight size={20} />
                      </div>
                    </div>
                  </div>
                </div>
              </motion.div>
            </Link>
          </div>
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}