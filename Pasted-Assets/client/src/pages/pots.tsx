import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { motion } from "framer-motion";
import { ArrowLeft, Trophy, Clock, ChevronRight, Crown, Flame, Target } from "lucide-react";
import { Link } from "wouter";

export default function Pots() {
  const pots = [
    {
      id: "daily",
      title: "Daily Pot",
      amount: "R 2,500",
      timeLeft: "04h 32m",
      userRank: 4566722,
      userScore: 850,
      totalParticipants: 1240,
      winningZone: 100, // Top 100 win
      color: "from-secondary/20 to-orange-500/10",
      iconColor: "text-secondary",
      borderColor: "border-secondary/30"
    },
    {
      id: "weekly",
      title: "Weekly Pot",
      amount: "R 15,000",
      timeLeft: "3d 12h",
      userRank: 156,
      userScore: 3200,
      totalParticipants: 5890,
      winningZone: 500, // Top 500 win
      color: "from-purple-500/20 to-pink-500/10",
      iconColor: "text-purple-400",
      borderColor: "border-purple-500/30"
    }
  ];

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background pb-20 overflow-y-auto">
        {/* Header */}
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3 mb-4">
            <Link href="/home">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-2xl font-heading font-bold text-white">Prize Pots</h1>
          </div>
          
          <div className="bg-white/5 rounded-xl p-4 border border-white/10">
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-secondary to-orange-500 flex items-center justify-center shrink-0">
                <Crown size={20} className="text-white fill-white" />
              </div>
              <div>
                <h3 className="text-white font-bold text-sm">How it works</h3>
                <p className="text-muted-foreground text-xs mt-1 leading-relaxed">
                  Earn tokens to climb the leaderboard. The top users at the end of the timer split the cash pot!
                </p>
              </div>
            </div>
          </div>
        </header>

        {/* Pots List */}
        <div className="px-6 py-4 space-y-6">
          {pots.map((pot, index) => (
            <motion.div
              key={pot.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className={`rounded-3xl border ${pot.borderColor} bg-gradient-to-br ${pot.color} overflow-hidden relative group`}
            >
              <div className="p-6">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <Badge variant="outline" className="bg-background/40 backdrop-blur-md border-white/10 text-white mb-2">
                      {pot.title}
                    </Badge>
                    <div className="text-4xl font-heading font-bold text-white drop-shadow-sm">
                      {pot.amount}
                    </div>
                  </div>
                  <div className={`w-12 h-12 rounded-full bg-background/20 backdrop-blur-md flex items-center justify-center ${pot.iconColor}`}>
                    <Trophy size={24} fill="currentColor" className="opacity-80" />
                  </div>
                </div>

                <div className="flex items-center gap-2 text-white/80 text-sm font-medium mb-6">
                  <Clock size={14} />
                  <span>Ends in {pot.timeLeft}</span>
                </div>

                {/* User Stats Card */}
                <div className="bg-background/40 backdrop-blur-md rounded-xl p-4 border border-white/10 mb-4">
                  <div className="flex justify-between items-center mb-3">
                    <div className="flex flex-col">
                      <span className="text-[10px] text-white/50 uppercase tracking-wider font-bold">Your Rank</span>
                      <span className="text-xl font-bold text-white">#{pot.userRank.toLocaleString()}</span>
                    </div>
                    <div className="h-8 w-px bg-white/10" />
                    <div className="flex flex-col text-right">
                      <span className="text-[10px] text-white/50 uppercase tracking-wider font-bold">Your Score</span>
                      <div className="flex items-center gap-1 justify-end">
                        <Flame size={14} className="text-orange-400 fill-orange-400" />
                        <span className="text-xl font-bold text-white">{pot.userScore}</span>
                      </div>
                    </div>
                  </div>

                  {/* Progress / Status */}
                  <div className="space-y-2">
                    <div className="flex justify-between text-[10px] font-medium">
                      <span className={pot.userRank <= pot.winningZone ? "text-green-400" : "text-white/50"}>
                        {pot.userRank <= pot.winningZone ? "Currently Winning!" : `Reach Top ${pot.winningZone} to win`}
                      </span>
                      <span className="text-white/50">Top {pot.winningZone} get paid</span>
                    </div>
                    <div className="h-1.5 bg-black/20 rounded-full overflow-hidden">
                      <div 
                        className={`h-full rounded-full ${pot.userRank <= pot.winningZone ? "bg-green-400" : "bg-white/30"}`}
                        style={{ width: `${Math.min(100, (pot.winningZone / pot.userRank) * 80)}%` }} // Mock progress logic
                      />
                    </div>
                  </div>
                </div>

                <Link href={`/leaderboard?tab=${pot.id}`}>
                  <Button className="w-full bg-white text-black hover:bg-white/90 font-bold shadow-lg group-hover:shadow-xl transition-all">
                    View Leaderboard
                    <ChevronRight size={16} className="ml-1 opacity-50" />
                  </Button>
                </Link>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}
