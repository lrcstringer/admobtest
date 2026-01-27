import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { motion } from "framer-motion";
import { ArrowLeft, Trophy, Crown, Flame, Loader2 } from "lucide-react";
import { Link, useLocation } from "wouter";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { leaderboardApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function Leaderboard() {
  const [location] = useLocation();
  const searchParams = new URLSearchParams(window.location.search);
  const defaultTab = searchParams.get("tab") || "daily";
  const [activeTab, setActiveTab] = useState(defaultTab);
  const { toast } = useToast();

  const { data: dailyData, isLoading: dailyLoading, error: dailyError } = useQuery({
    queryKey: ["leaderboard", "daily"],
    queryFn: leaderboardApi.getDaily,
    enabled: activeTab === "daily",
  });

  const { data: weeklyData, isLoading: weeklyLoading, error: weeklyError } = useQuery({
    queryKey: ["leaderboard", "weekly"],
    queryFn: leaderboardApi.getWeekly,
    enabled: activeTab === "weekly",
  });

  if (dailyError) {
    toast({
      title: "Error loading leaderboard",
      description: "Failed to load daily leaderboard data",
      variant: "destructive",
    });
  }

  if (weeklyError) {
    toast({
      title: "Error loading leaderboard",
      description: "Failed to load weekly leaderboard data",
      variant: "destructive",
    });
  }

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      {/* Header */}
      <header className="px-6 py-4 bg-background/95 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
        <div className="flex items-center gap-3 mb-6">
          <Link href="/pots">
            <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
              <ArrowLeft size={20} />
            </Button>
          </Link>
          <h1 className="text-xl font-heading font-bold text-white">Leaderboard</h1>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="w-full bg-white/5 p-1 rounded-xl mb-4 border border-white/5">
            <TabsTrigger 
              value="daily" 
              className="flex-1 font-bold data-[state=active]:bg-secondary data-[state=active]:text-secondary-foreground rounded-lg transition-all"
            >
              Daily Pot
            </TabsTrigger>
            <TabsTrigger 
              value="weekly" 
              className="flex-1 font-bold data-[state=active]:bg-purple-500 data-[state=active]:text-white rounded-lg transition-all"
            >
              Weekly Pot
            </TabsTrigger>
          </TabsList>

          {/* Info Banner */}
          <div className="bg-gradient-to-r from-secondary/10 to-transparent border-l-4 border-secondary pl-4 py-2 mb-2 rounded-r-lg">
             <h3 className="text-white font-bold text-sm flex items-center gap-2">
               <Trophy size={14} className="text-secondary" fill="currentColor" />
               Top 100 win a share of the pot!
             </h3>
             <p className="text-muted-foreground text-xs mt-0.5">
               Keep earning to climb the ranks.
             </p>
          </div>

          <TabsContent value="daily" className="mt-0">
             {dailyLoading ? (
               <div className="flex items-center justify-center h-[calc(100vh-220px)]">
                 <Loader2 className="h-8 w-8 animate-spin text-primary" />
               </div>
             ) : (
               <LeaderboardList data={dailyData?.entries || []} />
             )}
          </TabsContent>
          <TabsContent value="weekly" className="mt-0">
             {weeklyLoading ? (
               <div className="flex items-center justify-center h-[calc(100vh-220px)]">
                 <Loader2 className="h-8 w-8 animate-spin text-primary" />
               </div>
             ) : (
               <LeaderboardList data={weeklyData?.entries || []} />
             )}
          </TabsContent>
        </Tabs>
      </header>
    </MobileFrame>
  );
}

function LeaderboardList({ data }: { data: any[] }) {
  if (!data || !Array.isArray(data) || data.length === 0) {
    return (
      <div className="flex items-center justify-center h-[calc(100vh-220px)]">
        <div className="text-center py-12 px-6">
          <div className="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-4">
            <Trophy size={24} className="text-white/30" />
          </div>
          <h3 className="text-white font-bold mb-1">No entries yet</h3>
          <p className="text-muted-foreground text-sm">
            Be the first to climb the leaderboard!
          </p>
        </div>
      </div>
    );
  }

  const userEntry = data.find(d => d.isUser);

  return (
    <div className="flex-1 overflow-y-auto pb-24 relative h-[calc(100vh-220px)]">
      <div className="px-1 space-y-2 pt-2">
        {data.map((user, index) => (
          <motion.div
            key={index}
            initial={{ opacity: 0, x: -10 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: index * 0.05 }}
            className={`
              flex items-center gap-4 p-3 rounded-xl border
              ${user.isUser 
                ? "bg-secondary/10 border-secondary/30" 
                : "bg-card border-white/5 hover:bg-white/5"}
            `}
          >
            {/* Rank */}
            <div className={`
              min-w-[2rem] h-8 px-2 flex items-center justify-center font-bold rounded-full text-sm
              ${user.rank <= 3 ? "bg-gradient-to-br from-yellow-400 to-orange-500 text-black shadow-lg" : "text-muted-foreground bg-white/5"}
            `}>
              {user.rank.toLocaleString()}
            </div>

            {/* Avatar */}
            <Avatar className="h-10 w-10 border-2 border-white/10">
              <AvatarFallback className={`font-bold ${user.isUser ? "bg-secondary text-secondary-foreground" : "bg-white/10 text-white"}`}>
                {user.avatar}
              </AvatarFallback>
            </Avatar>

            {/* Name */}
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2">
                <span className={`font-bold truncate ${user.isUser ? "text-secondary" : "text-white"}`}>
                  {user.name}
                </span>
                {user.isUser && <span className="text-[10px] bg-secondary text-secondary-foreground px-1.5 rounded-sm font-bold uppercase">You</span>}
                {user.rank === 1 && <Crown size={12} className="text-yellow-400 fill-yellow-400" />}
              </div>
            </div>

            {/* Score */}
            <div className="flex items-center gap-1.5 bg-black/20 px-3 py-1.5 rounded-full border border-white/5">
              <Flame size={12} className="text-orange-400 fill-orange-400" />
              <span className="font-mono font-bold text-white text-sm">{user.score}</span>
            </div>
          </motion.div>
        ))}
      </div>
      
      {/* Sticky User Row if not visible (simplified logic: always show sticky footer for user context) */}
      <div className="fixed bottom-0 left-0 right-0 bg-background/80 backdrop-blur-xl border-t border-white/10 p-4 pb-8 z-30 shadow-[0_-10px_40px_rgba(0,0,0,0.5)]">
        <div className="max-w-md mx-auto flex items-center justify-between">
           <div className="flex items-center gap-3">
             <div className="flex flex-col">
               <span className="text-[10px] text-muted-foreground uppercase font-bold">Your Rank</span>
               <span className="text-xl font-bold text-white">#{userEntry?.rank ? userEntry.rank.toLocaleString() : "-"}</span>
             </div>
             <div className="h-8 w-px bg-white/10 mx-2" />
             <div className="flex flex-col">
               <span className="text-[10px] text-muted-foreground uppercase font-bold">To Next Rank</span>
               <span className="text-sm font-bold text-secondary">30 pts needed</span>
             </div>
           </div>
           
           <Link href="/earn">
             <Button size="sm" className="font-bold bg-white text-black hover:bg-white/90">
               Earn More
             </Button>
           </Link>
        </div>
      </div>
    </div>
  );
}
