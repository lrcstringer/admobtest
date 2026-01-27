import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { useState } from "react";
import { motion } from "framer-motion";
import { ShieldCheck, Bell, Zap, Check, AlertTriangle, RotateCcw } from "lucide-react";
import { useLocation } from "wouter";
import { useQuery } from "@tanstack/react-query";
import { authApi } from "@/lib/api";

export default function Permissions() {
  const [, setLocation] = useLocation();
  const [permissions, setPermissions] = useState({
    contacts: true,
    background: true,
    notifications: true
  });
  const [showAuthError, setShowAuthError] = useState(false);

  const { data: user, isLoading } = useQuery({
    queryKey: ["/api/auth/me"],
    queryFn: authApi.getMe,
    retry: false,
  });

  const handleContinue = () => {
    // Check if user is authenticated
    if (user) {
      setLocation("/home");
    } else {
      // Show authentication failed screen
      setShowAuthError(true);
    }
  };

  const handleBackToStart = () => {
    setLocation("/");
  };

  const togglePermission = (key: keyof typeof permissions) => {
    setPermissions(prev => ({ ...prev, [key]: !prev[key] }));
  };

  // Show authentication error screen
  if (showAuthError) {
    return (
      <MobileFrame className="bg-background relative">
        <div className="flex-1 flex flex-col items-center justify-center px-6 py-12 text-center">
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="space-y-6"
          >
            <div className="w-24 h-24 bg-red-500/10 rounded-full flex items-center justify-center mx-auto">
              <AlertTriangle size={48} className="text-red-500" />
            </div>
            
            <div className="space-y-2">
              <h1 className="text-2xl font-heading font-bold text-white">
                Authentication Failed
              </h1>
              <p className="text-muted-foreground text-sm max-w-xs mx-auto">
                We couldn't verify your account. Please try signing up again or contact support if this issue persists.
              </p>
            </div>

            <Button 
              size="lg" 
              className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-[0_4px_20px_rgba(255,51,138,0.3)] transition-all rounded-xl"
              onClick={handleBackToStart}
              data-testid="button-back-to-start"
            >
              <RotateCcw size={20} className="mr-2" />
              Back to Start
            </Button>
          </motion.div>
        </div>
      </MobileFrame>
    );
  }

  return (
    <MobileFrame className="bg-background relative">
      <div className="flex-1 flex flex-col px-6 py-12">
        <div className="mb-8 text-center">
          <div className="w-20 h-20 bg-secondary/10 rounded-full flex items-center justify-center mx-auto mb-6">
            <ShieldCheck size={40} className="text-secondary" />
          </div>
          <h1 className="text-2xl font-heading font-bold text-white mb-2">Enable Permissions</h1>
          <p className="text-muted-foreground text-sm max-w-xs mx-auto">
            To give you the best earning experience, we need access to a few things.
          </p>
        </div>

        <div className="space-y-6 flex-1">
          {/* Permission 1 */}
          <div className="bg-card border border-white/5 rounded-xl p-5 flex items-start justify-between gap-4">
            <div>
              <h3 className="text-white font-bold mb-1">Allow Access</h3>
              <p className="text-muted-foreground text-xs leading-relaxed">
                To help us give you a great chat experience, allow iMaliChat to have access to contacts and media.
              </p>
            </div>
            <Switch 
              checked={permissions.contacts}
              onCheckedChange={() => togglePermission('contacts')}
              className="mt-1 data-[state=checked]:bg-secondary"
              data-testid="switch-contacts"
            />
          </div>

          {/* Permission 2 */}
          <div className="bg-card border border-white/5 rounded-xl p-5 flex items-start justify-between gap-4">
            <div>
              <h3 className="text-white font-bold mb-1">Run in Background</h3>
              <p className="text-muted-foreground text-xs leading-relaxed">
                iMaliChat will operate in the background on your phone with unconstructed battery usage.
              </p>
            </div>
            <Switch 
              checked={permissions.background}
              onCheckedChange={() => togglePermission('background')}
              className="mt-1 data-[state=checked]:bg-secondary"
              data-testid="switch-background"
            />
          </div>

          {/* Permission 3 */}
          <div className="bg-card border border-white/5 rounded-xl p-5 flex items-start justify-between gap-4">
            <div>
              <h3 className="text-white font-bold mb-1 flex items-center gap-2">
                Notifications
                <span className="bg-primary/20 text-primary text-[10px] px-2 py-0.5 rounded-full uppercase">Recommended</span>
              </h3>
              <p className="text-muted-foreground text-xs leading-relaxed">
                This will allow us to notify you when you have earning offers so you never miss out.
              </p>
            </div>
            <Switch 
              checked={permissions.notifications}
              onCheckedChange={() => togglePermission('notifications')}
              className="mt-1 data-[state=checked]:bg-secondary"
              data-testid="switch-notifications"
            />
          </div>
        </div>

        <div className="pt-6">
          <Button 
            size="lg" 
            className="w-full h-14 text-lg font-bold bg-white text-background hover:bg-white/90 shadow-lg transition-all rounded-xl"
            onClick={handleContinue}
            disabled={isLoading}
            data-testid="button-continue"
          >
            All Set! Let's Earn
          </Button>
        </div>
      </div>
    </MobileFrame>
  );
}
