import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";
import { ArrowLeft } from "lucide-react";
import { Link, useRoute } from "wouter";
import { useState } from "react";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";
import { EarnMessageCard } from "@/components/earn/earn-message-card";

// Mock Data for Threads (would normally come from an API/State)
const THREAD_DATA: Record<string, any> = {
  "imalichat": {
    id: "imalichat",
    name: "iMaliChat Daily",
    avatarColor: "bg-primary",
    avatarImage: appLogo,
    messages: [
      {
        id: 100,
        type: "system",
        text: "Welcome back! Here are your daily opportunities to earn.",
        time: "09:00 AM"
      },
      {
        id: 1,
        type: "earn",
        title: "Daily Trivia Pot",
        description: "Answer 3 questions to enter the daily prize draw.",
        reward: "50 Tokens",
        duration: "45 sec",
        action: "Play Now {rewardTokens}",
        status: "available",
        expiresInDays: 1
      },
      {
        id: 2,
        type: "earn",
        title: "Watch & Win",
        description: "Watch this short clip about financial literacy.",
        reward: "15 Tokens",
        duration: "30 sec",
        action: "Watch Video {rewardTokens}",
        status: "available",
        expiresInDays: 1
      }
    ]
  },
  "nike": {
    id: "nike",
    name: "Nike SA",
    avatarColor: "bg-blue-600",
    messages: [
      {
        id: 3,
        type: "earn",
        title: "New Air Max Launch",
        description: "Tell us what you think about the new design.",
        reward: "120 Tokens",
        duration: "2 min",
        action: "Start Survey {rewardTokens}",
        status: "available",
        expiresInDays: 3
      }
    ]
  },
  "checkers": {
    id: "checkers",
    name: "Checkers Sixty60",
    avatarColor: "bg-teal-600",
    messages: [
      {
        id: 4,
        type: "earn",
        title: "Delivery Experience",
        description: "Rate your last delivery driver.",
        reward: "80 Tokens",
        duration: "1 min",
        action: "Rate Now {rewardTokens}",
        status: "available",
        expiresInDays: 1
      }
    ]
  }
};

export default function EarnThread() {
  const [, params] = useRoute("/earn/:id");
  const threadId = params?.id || "imalichat";
  const thread = THREAD_DATA[threadId] || THREAD_DATA["imalichat"];
  
  // In a real app, completed state would come from backend/store
  const [completedMessages, setCompletedMessages] = useState<number[]>([]);

  const handleEarn = (id: number) => {
    // Navigate logic is handled by Link wrapper in Card
    console.log("Earn clicked for", id);
  };

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      {/* Chat Header */}
      <header className="px-4 py-4 flex items-center gap-3 bg-card/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
        <Link href="/earn">
          <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full">
            <ArrowLeft size={20} />
          </Button>
        </Link>
        
        <div className={`w-10 h-10 rounded-full ${thread.avatarColor} flex items-center justify-center text-white font-bold shadow-lg overflow-hidden`}>
          {thread.avatarImage ? (
            <div className="bg-white w-full h-full p-1 flex items-center justify-center">
               <img src={thread.avatarImage} alt={thread.name} className="w-full h-full object-contain" />
            </div>
          ) : (
            thread.name.charAt(0)
          )}
        </div>
        
        <div className="flex-1">
          <h1 className="text-lg font-heading font-bold text-white leading-tight">{thread.name}</h1>
          <div className="flex items-center gap-1.5 text-xs text-primary font-medium">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-primary opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-primary"></span>
            </span>
            Active Session
          </div>
        </div>
      </header>

      {/* Chat Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-6 pb-24">
        <div className="text-center text-xs text-muted-foreground my-4">
          Today, {new Date().toLocaleDateString()}
        </div>

        {thread.messages.map((msg: any, index: number) => (
          <motion.div
            key={msg.id}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className={`flex ${msg.type === 'system' ? 'justify-center' : 'justify-start'}`}
          >
            {msg.type === 'system' ? (
              <div className="bg-white/5 text-white/70 text-sm px-4 py-2 rounded-full border border-white/5 text-center max-w-[85%]">
                {msg.text}
              </div>
            ) : (
              <div className="flex gap-3 max-w-[90%] w-full">
                <div className={`w-8 h-8 rounded-full ${thread.avatarColor} flex-shrink-0 flex items-center justify-center text-[10px] text-white font-bold mt-1 overflow-hidden shadow-sm`}>
                   {thread.avatarImage ? (
                    <div className="bg-white w-full h-full p-0.5 flex items-center justify-center">
                       <img src={thread.avatarImage} alt={thread.name} className="w-full h-full object-contain" />
                    </div>
                  ) : (
                    thread.name.charAt(0)
                  )}
                </div>
                
                <div className="flex-1 min-w-0">
                  <EarnMessageCard 
                    id={msg.id}
                    brandName={thread.name}
                    title={msg.title}
                    description={msg.description}
                    rewardTokens={msg.reward}
                    expiresInDays={msg.expiresInDays}
                    status={completedMessages.includes(msg.id) ? "completed" : msg.status}
                    duration={msg.duration}
                    type="Survey" // In real app, derive from msg type
                    actionLabel={msg.action}
                    onEarn={() => handleEarn(msg.id)}
                  />
                </div>
              </div>
            )}
          </motion.div>
        ))}
      </div>
    </MobileFrame>
  );
}
