import { Link, useLocation } from "wouter";
import { Home, Zap, MessageCircle, Wallet, ShoppingCart, Crown } from "lucide-react";
import { cn } from "@/lib/utils";

export function BottomNav() {
  const [location] = useLocation();

  const navItems = [
    { icon: Home, label: "Home", href: "/home" },
    { icon: Crown, label: "Earn", href: "/earn" },
    { icon: MessageCircle, label: "Chat", href: "/chat" },
    { icon: Wallet, label: "Wallets", href: "/wallets" },
    { icon: ShoppingCart, label: "Buy", href: "/buy" },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 z-50 flex justify-center pointer-events-none">
      <div className="w-full max-w-md bg-card/95 backdrop-blur-md border-t border-white/5 pb-6 pt-2 px-2 flex justify-between items-end pointer-events-auto">
        {navItems.map((item) => {
          const isActive = location === item.href;
          return (
            <Link key={item.label} href={item.href}>
              <div className={cn(
                "flex flex-col items-center justify-center w-14 gap-1.5 py-1 transition-all duration-300",
                isActive ? "text-primary" : "text-muted-foreground hover:text-white"
              )}>
                <item.icon 
                  size={28} 
                  strokeWidth={isActive ? 2.5 : 2}
                  className={cn("transition-all", isActive && "scale-110 drop-shadow-[0_0_8px_rgba(255,51,138,0.5)]")} 
                />
                <span className="text-[10px] font-medium">{item.label}</span>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
