import { Button } from "@/components/ui/button";
import { Clock, Crown, CheckCircle2 } from "lucide-react";
import { Link } from "wouter";

interface EarnMessageCardProps {
  id: number;
  brandName: string;
  brandLogo?: string;
  brandAvatarColor?: string;
  title: string;
  description: string;
  rewardTokens: string;
  expiresInDays?: number; // Optional, can be derived or passed directly
  isExpired?: boolean;
  status: "available" | "in_progress" | "completed" | "expired";
  actionLabel?: string;
  duration?: string;
  type?: string;
  onEarn?: () => void;
}

export function EarnMessageCard({
  id,
  brandName,
  brandLogo,
  brandAvatarColor = "bg-primary",
  title,
  description,
  rewardTokens,
  expiresInDays,
  isExpired = false,
  status,
  actionLabel = "Earn tokens",
  duration,
  type,
  onEarn
}: EarnMessageCardProps) {
  
  const isCompleted = status === "completed";
  const effectivelyExpired = isExpired || status === "expired";

  return (
    <div className={`
      p-4 rounded-2xl rounded-tl-none border 
      ${isCompleted 
        ? "bg-card/50 border-white/5 opacity-70" 
        : "bg-card border-white/10 shadow-md"}
    `}>
      <div className="flex justify-between items-start gap-4 mb-2">
        <h3 className="font-bold text-white text-base">{title}</h3>
        
        {/* Status Pill */}
        {isCompleted ? (
           <div className="flex items-center gap-1 text-green-400 font-bold text-xs bg-green-400/10 px-2 py-1 rounded">
             <CheckCircle2 size={12} />
             <span>Done</span>
           </div>
        ) : effectivelyExpired ? (
           <div className="flex items-center gap-1 text-muted-foreground font-bold text-xs bg-white/5 px-2 py-1 rounded">
             <span>Expired</span>
           </div>
        ) : (
          <div className="flex items-center gap-1 text-secondary font-bold text-xs bg-secondary/10 px-2 py-1 rounded">
            <Crown size={12} fill="currentColor" />
            {rewardTokens}
          </div>
        )}
      </div>
      
      <p className="text-muted-foreground text-sm mb-3 leading-relaxed">
        {description}
      </p>
      
      <div className="flex items-center justify-between mb-4 text-xs text-white/50">
         <div className="flex items-center gap-3">
           {duration && (
             <span className="flex items-center gap-1 bg-white/5 px-2 py-1 rounded">
                <Clock size={10} /> {duration}
             </span>
           )}
           {type && <span className="capitalize text-white/40">• {type}</span>}
         </div>
         
         {!isCompleted && !effectivelyExpired && expiresInDays !== undefined && (
            <span className="text-orange-400/80">Expires in {expiresInDays}d</span>
         )}
      </div>

      {isCompleted ? (
         <Button disabled className="w-full bg-white/10 text-white/50 font-bold border border-white/5">
            Completed
         </Button>
      ) : effectivelyExpired ? (
         <Button disabled className="w-full bg-white/5 text-muted-foreground font-bold border border-white/5">
            Offer Expired
         </Button>
      ) : (
        <Link href={`/earn/detail/${id}`}>
          <Button 
            className="w-full bg-primary hover:bg-primary/90 text-white font-bold shadow-[0_4px_12px_rgba(255,51,138,0.2)]"
            onClick={onEarn}
          >
            {actionLabel.replace("{rewardTokens}", rewardTokens.replace(/\D/g, ''))}
          </Button>
        </Link>
      )}
    </div>
  );
}
