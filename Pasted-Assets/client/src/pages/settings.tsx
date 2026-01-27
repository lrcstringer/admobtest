import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { ArrowLeft, Bell, Shield, Zap } from "lucide-react";
import { Link } from "wouter";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";

export default function Settings() {
  const { toast } = useToast();
  const [settings, setSettings] = useState({
    access: false,
    background: false,
    notifications: true
  });

  const handleToggle = (key: keyof typeof settings, label: string) => {
    const newValue = !settings[key];
    setSettings(prev => ({ ...prev, [key]: newValue }));
    
    if (newValue) {
      toast({
        title: "Permission Requested",
        description: `System would request ${label} permission here.`,
        duration: 2000,
      });
    }
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-4 py-4 flex items-center gap-3 bg-card/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
          <Link href="/profile">
            <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full">
              <ArrowLeft size={20} />
            </Button>
          </Link>
          <h1 className="text-lg font-heading font-bold text-white">Settings</h1>
        </header>

        <div className="p-6 space-y-6">
          <div className="space-y-4">
            <h2 className="text-sm font-bold text-muted-foreground uppercase tracking-wider">Permissions</h2>
            
            {/* Access Toggle */}
            <div className="flex items-start justify-between gap-4">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <Shield size={16} className="text-white" />
                  <span className="text-white font-medium">Allow Access</span>
                </div>
                <p className="text-xs text-muted-foreground">Required so we can deliver rewards reliably.</p>
              </div>
              <Switch 
                checked={settings.access}
                onCheckedChange={() => handleToggle('access', 'Device Access')}
                className="data-[state=checked]:bg-secondary"
              />
            </div>

            {/* Background Toggle */}
            <div className="flex items-start justify-between gap-4">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <Zap size={16} className="text-white" />
                  <span className="text-white font-medium">Run in Background</span>
                </div>
                <p className="text-xs text-muted-foreground">Running in background helps us update your rank and pots on time.</p>
              </div>
              <Switch 
                checked={settings.background}
                onCheckedChange={() => handleToggle('background', 'Background Usage')}
                className="data-[state=checked]:bg-secondary"
              />
            </div>

            {/* Notifications Toggle */}
            <div className="flex items-start justify-between gap-4">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <Bell size={16} className="text-white" />
                  <span className="text-white font-medium">Notifications</span>
                </div>
                <p className="text-xs text-muted-foreground">Get alerted about new earn opportunities.</p>
              </div>
              <Switch 
                checked={settings.notifications}
                onCheckedChange={() => handleToggle('notifications', 'Notifications')}
                className="data-[state=checked]:bg-secondary"
              />
            </div>
          </div>
          
          <div className="pt-8 border-t border-white/5">
             <Button variant="destructive" className="w-full font-bold">Log Out</Button>
             <p className="text-center text-[10px] text-muted-foreground mt-4">Version 1.0.0 (Build 2405)</p>
          </div>
        </div>
      </div>
    </MobileFrame>
  );
}
