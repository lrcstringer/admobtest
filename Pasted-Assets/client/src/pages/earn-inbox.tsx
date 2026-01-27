import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { motion } from "framer-motion";
import { Pin, Clock, ChevronRight, User, Loader2 } from "lucide-react";
import { Link } from "wouter";
import { useQuery } from "@tanstack/react-query";
import { earnApi } from "@/lib/api";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

export default function EarnInbox() {
  const { data: threads = [], isLoading } = useQuery({
    queryKey: ["/api/earn/threads"],
    queryFn: earnApi.getThreads,
  });

  const totalActiveThreads = threads.filter((t: any) => t.isActive).length;

  return (
    <MobileFrame>
      <div className="flex flex-col h-full pb-20 overflow-y-auto bg-background">
        {/* Header */}
        <header className="px-6 pt-12 pb-4 sticky top-0 bg-background/95 backdrop-blur-md z-20 border-b border-white/5">
          <div className="flex justify-between items-end mb-2">
            <h1 className="text-2xl font-heading font-bold text-white">Earn Chats</h1>
            {!isLoading && (
              <Badge variant="outline" className="border-secondary/30 text-secondary bg-secondary/10">
                {totalActiveThreads} Active Thread{totalActiveThreads !== 1 ? 's' : ''}
              </Badge>
            )}
          </div>
          <p className="text-muted-foreground text-sm">
            Chat with brands, complete tasks, earn money.
          </p>
          <div className="mt-4">
             <Link href="/profile/referrals">
               <Button className="w-full bg-card hover:bg-white/5 border border-white/10 text-white font-bold h-10 shadow-sm text-sm">
                 <User size={14} className="mr-2 text-secondary" />
                 Invite friends & Earn
               </Button>
             </Link>
          </div>
        </header>

        {/* Threads List */}
        <div className="flex-1">
          {isLoading ? (
            <div className="flex items-center justify-center py-20">
              <Loader2 className="animate-spin text-primary" size={40} />
            </div>
          ) : threads.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-20 px-6">
              <p className="text-muted-foreground text-center">No earn opportunities available right now.</p>
              <p className="text-muted-foreground text-center text-sm mt-2">Check back soon for new surveys and tasks!</p>
            </div>
          ) : (
            threads.map((thread: any, index: number) => {
              const avatarImage = thread.brandId === "imalichat" ? appLogo : thread.avatarImage;
              
              return (
                <Link key={thread.id} href={`/earn/${thread.id}`}>
                  <motion.div
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.05 }}
                    className={`
                      relative px-6 py-4 border-b border-white/5 hover:bg-white/[0.02] transition-colors cursor-pointer group
                      ${thread.isPinned ? "bg-primary/[0.02]" : ""}
                    `}
                  >
                    <div className="flex gap-4">
                      {/* Avatar */}
                      <div className="relative">
                        {avatarImage ? (
                           <div className={`w-14 h-14 rounded-full bg-white flex items-center justify-center shadow-lg border-2 border-background overflow-hidden p-1`}>
                             <img src={avatarImage} alt={thread.brandName} className="w-full h-full object-contain" />
                           </div>
                        ) : (
                          <div className={`w-14 h-14 rounded-full ${thread.avatarColor || 'bg-blue-600'} flex items-center justify-center text-xl text-white font-bold shadow-lg border-2 border-background`}>
                            {thread.brandName.charAt(0)}
                          </div>
                        )}
                        
                        {thread.isActive && (
                          <div className="absolute top-0 right-0 w-3.5 h-3.5 bg-green-500 rounded-full border-2 border-background shadow-sm" />
                        )}
                      </div>

                      {/* Content */}
                      <div className="flex-1 min-w-0">
                        <div className="flex justify-between items-start mb-1">
                          <div className="flex items-center gap-2">
                            <h3 className="font-bold text-white text-base truncate">{thread.brandName}</h3>
                            {thread.isPinned && <Pin size={12} className="text-primary rotate-45" fill="currentColor" />}
                          </div>
                        </div>

                        <p className={`text-sm truncate pr-4 ${thread.isActive ? "text-white font-medium" : "text-muted-foreground"}`}>
                          Tap to view earning opportunities
                        </p>

                        <div className="flex items-center gap-3 mt-2">
                          <span className="text-[10px] font-bold bg-secondary text-secondary-foreground px-2 py-0.5 rounded-full">
                            Active
                          </span>
                        </div>
                      </div>
                      
                      {/* Chevron for affordance */}
                      <div className="flex flex-col justify-center text-white/20 group-hover:text-white/50">
                        <ChevronRight size={20} />
                      </div>
                    </div>
                  </motion.div>
                </Link>
              );
            })
          )}
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}
