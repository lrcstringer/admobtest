import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { motion, AnimatePresence } from "framer-motion";
import { Wallet, Trophy, Clock, User, HelpCircle, Loader2, ChevronRight } from "lucide-react";
import { Link, useLocation } from "wouter";
import { useQuery } from "@tanstack/react-query";
import { homeApi } from "@/lib/api";
import { HowItWorksModal } from "@/components/modals/how-it-works";
import { useToast } from "@/hooks/use-toast";
import { formatDistanceToNow } from "date-fns";
import { useEffect } from "react";

export default function Home() {
  const { toast } = useToast();
  const [, setLocation] = useLocation();
  
  const { data, isLoading: loading, error } = useQuery({
    queryKey: ["/api/home/summary"],
    queryFn: homeApi.getSummary,
    retry: false,
  });

  // Handle errors in useEffect to avoid setState during render
  useEffect(() => {
    if (error) {
      // Check if it's a 401 (unauthorized) error
      const errorMessage = error instanceof Error ? error.message : String(error);
      if (errorMessage.includes("Unauthorized") || errorMessage.includes("401")) {
        // Redirect to login
        setLocation("/auth/login");
      } else {
        toast({
          title: "Error loading data",
          description: "Failed to load home page data. Please try again.",
          variant: "destructive",
        });
      }
    }
  }, [error, toast, setLocation]);

  return (
    <MobileFrame>
      <div className="flex flex-col h-full pb-20 bg-background overflow-hidden">
        {loading ? (
           <div className="flex-1 flex items-center justify-center">
             <Loader2 className="animate-spin text-primary" size={40} />
           </div>
        ) : !data ? (
          <div className="flex-1 flex items-center justify-center">
            <Loader2 className="animate-spin text-primary" size={40} />
          </div>
        ) : (
          <div className="flex-1 overflow-y-auto no-scrollbar">
             {/* Header */}
             <header className="px-6 pt-12 pb-6 flex justify-between items-center bg-gradient-to-b from-card/50 to-transparent sticky top-0 z-10 backdrop-blur-sm">
              <div>
                <p className="text-muted-foreground text-sm font-medium mb-1">{data.greeting},</p>
                <h1 className="text-2xl font-heading font-bold text-white">{data.userName}</h1>
                <div className="flex items-center gap-3 mt-2">
                   <div className="bg-secondary/10 border border-secondary/20 rounded-full px-2 py-0.5 flex items-center gap-1.5 w-fit">
                    <div className="w-1.5 h-1.5 rounded-full bg-secondary animate-pulse" />
                    <span className="text-secondary text-[10px] font-bold uppercase tracking-wider">Streak: {data.streak} days</span>
                  </div>
                   {data.dailyRank && <span className="text-muted-foreground text-xs font-medium">Rank #{data.dailyRank} today</span>}
                </div>
              </div>
              <Link href="/profile">
                <div className="relative">
                  <div className="w-16 h-16 rounded-full bg-primary/20 border border-primary/50 flex items-center justify-center cursor-pointer hover:bg-primary/30 transition-colors">
                    <User size={32} className="text-primary" />
                  </div>
                  <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-white text-primary rounded-full flex items-center justify-center border-2 border-background font-bold text-sm shadow-sm">
                    +
                  </div>
                </div>
              </Link>
            </header>

            <div className="px-6 space-y-6 pb-8">
              {/* Wallet Card */}
              <motion.div 
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-[#0B2A55] to-[#05152a] border border-white/10 shadow-lg"
              >
                <div className="absolute top-0 right-0 w-32 h-32 bg-primary/20 blur-[60px] rounded-full -mr-10 -mt-10" />
                <div className="absolute bottom-0 left-0 w-32 h-32 bg-secondary/10 blur-[60px] rounded-full -ml-10 -mb-10" />
                
                <div className="p-5 relative z-10">
                  <div className="flex justify-between items-start mb-4">
                    <div>
                      <p className="text-white/60 text-sm font-medium mb-1">Total Token Balance</p>
                      <h2 className="text-4xl font-heading font-bold text-white tracking-tight">{data.totalTokens.toLocaleString()}</h2>
                    </div>
                    <div className="bg-white/5 p-2 rounded-lg border border-white/5">
                      <Wallet className="text-primary" size={24} />
                    </div>
                  </div>
                  
                  <div className="grid grid-cols-1">
                    <Link href="/earn">
                      <Button className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-10 shadow-md shadow-primary/20">
                        Earn Now
                      </Button>
                    </Link>
                  </div>
                </div>
              </motion.div>

              {/* Pots Section */}
              <div>
                <div className="grid grid-cols-2 gap-4">
                  {/* Daily Pot */}
                  <Link href="/pots">
                    <Card className="bg-card border-white/5 hover:border-secondary/30 transition-colors overflow-hidden relative group cursor-pointer h-full">
                      <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-secondary to-orange-400" />
                      <CardContent className="p-4 relative">
                        <div className="flex justify-between items-start mb-3">
                          <span className="text-[10px] font-bold text-secondary uppercase tracking-wider">Daily</span>
                          <Trophy size={16} className="text-secondary" />
                        </div>
                        <div className="mb-2">
                          <span className="text-[10px] text-muted-foreground block uppercase tracking-wider mb-1">Today's Pot</span>
                          <span className="text-lg font-bold text-white">R {parseFloat(data.dailyPot.amount).toFixed(2)}</span>
                        </div>
                        <div className="flex items-center gap-1.5 text-white/60 text-[10px] bg-black/20 p-1.5 rounded-lg w-fit mb-2">
                          <Clock size={10} />
                          <span>{formatDistanceToNow(new Date(data.dailyPot.closesAt), { addSuffix: false })}</span>
                        </div>
                        <div className="text-[10px] text-muted-foreground border-t border-white/5 pt-2 mt-2">
                           Your Rank: <span className="text-white font-bold">#{data.dailyRank || "—"}</span>
                        </div>
                        <div className="absolute bottom-2 right-2 text-white/20 group-hover:text-secondary transition-colors">
                          <ChevronRight size={16} />
                        </div>
                      </CardContent>
                    </Card>
                  </Link>

                  {/* Weekly Pot */}
                  <Link href="/pots">
                    <Card className="bg-card border-white/5 hover:border-primary/30 transition-colors overflow-hidden relative group cursor-pointer h-full">
                      <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary to-purple-500" />
                      <CardContent className="p-4 relative">
                        <div className="flex justify-between items-start mb-3">
                          <span className="text-[10px] font-bold text-primary uppercase tracking-wider">Weekly</span>
                          <Trophy size={16} className="text-primary" />
                        </div>
                        <div className="mb-2">
                           <span className="text-[10px] text-muted-foreground block uppercase tracking-wider mb-1">This Week's Pot</span>
                          <span className="text-lg font-bold text-white">R {parseFloat(data.weeklyPot.amount).toFixed(2)}</span>
                        </div>
                        <div className="flex items-center gap-1.5 text-white/60 text-[10px] bg-black/20 p-1.5 rounded-lg w-fit">
                          <Clock size={10} />
                          <span>{formatDistanceToNow(new Date(data.weeklyPot.closesAt), { addSuffix: false })}</span>
                        </div>
                        <div className="absolute bottom-2 right-2 text-white/20 group-hover:text-primary transition-colors">
                          <ChevronRight size={16} />
                        </div>
                      </CardContent>
                    </Card>
                  </Link>
                </div>
                
                <div className="mt-4">
                  <Link href="/profile/referrals">
                    <Button className="w-full bg-card hover:bg-white/5 border border-white/10 text-white font-bold h-12 shadow-sm">
                      <User size={16} className="mr-2 text-secondary" />
                      Invite friends & Earn
                    </Button>
                  </Link>
                </div>
              </div>

              {/* How it works */}
              <div className="flex justify-center pt-4">
                <Link href="/how-it-works">
                  <Button variant="link" className="text-primary hover:text-primary/80">
                    How it works
                  </Button>
                </Link>
              </div>
            </div>
          </div>
        )}
      </div>
      <BottomNav />
    </MobileFrame>
  );
}
