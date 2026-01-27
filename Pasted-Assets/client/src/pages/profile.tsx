import { MobileFrame } from "@/components/layout/mobile-frame";
import { BottomNav } from "@/components/ui/bottom-nav";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { User, Settings as SettingsIcon, Wallet, Trophy, ChevronRight, Users, HelpCircle, Shield, LogOut, Edit2, Loader2 } from "lucide-react";
import { Link } from "wouter";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { userApi, walletApi } from "@/lib/api";

export default function Profile() {
  const { toast } = useToast();

  const { data: profile, isLoading: profileLoading, error: profileError } = useQuery({
    queryKey: ["profile"],
    queryFn: userApi.getProfile,
  });

  const { data: wallets, isLoading: walletsLoading } = useQuery({
    queryKey: ["wallets"],
    queryFn: walletApi.getWallets,
  });

  if (profileError) {
    toast({
      title: "Error loading profile",
      description: "Failed to load profile data",
      variant: "destructive",
    });
  }

  const handleLogout = () => {
    toast({
      title: "Logging out...",
      description: "This is a prototype, so you aren't really logged in.",
    });
  };

  const isLoading = profileLoading || walletsLoading;
  
  if (isLoading) {
    return (
      <MobileFrame>
        <div className="flex items-center justify-center h-screen">
          <Loader2 className="h-8 w-8 animate-spin text-primary" />
        </div>
      </MobileFrame>
    );
  }

  const mainWallet = wallets?.find((w: any) => w.type === 'main');
  const totalBalance = mainWallet?.balance || 0;
  const balanceValue = (totalBalance / 100).toFixed(2);
  const userInitials = profile?.firstName && profile?.lastName 
    ? `${profile.firstName[0]}${profile.lastName[0]}`.toUpperCase()
    : profile?.username?.substring(0, 2).toUpperCase() || '??';

  return (
    <MobileFrame>
      <div className="flex flex-col h-full pb-20 bg-background overflow-y-auto">
        <div className="px-6 pt-12 pb-6">
          {/* Profile Header Card */}
          <div className="bg-card border border-white/10 rounded-3xl p-6 mb-6 text-center relative overflow-hidden">
            <div className="absolute top-0 left-0 w-full h-24 bg-gradient-to-b from-primary/20 to-transparent pointer-events-none" />
            
            <div className="relative z-10 flex flex-col items-center">
              <div className="w-24 h-24 rounded-full bg-primary/20 flex items-center justify-center border-4 border-background mb-4 shadow-lg">
                <span className="text-3xl font-bold text-primary">{userInitials}</span>
              </div>
              
              <h1 className="text-2xl font-bold text-white mb-1">
                {profile?.firstName && profile?.lastName 
                  ? `${profile.firstName} ${profile.lastName}` 
                  : profile?.username || 'User'}
              </h1>
              <p className="text-muted-foreground font-medium mb-1">@{profile?.username || 'user'}</p>
              <p className="text-xs text-white/40 mb-4">{profile?.phoneNumber || '-'}</p>
              
              <Link href="/profile/edit">
                <Button variant="outline" size="sm" className="rounded-full border-white/20 hover:bg-white/10 text-white h-9 px-6 font-bold text-xs gap-2">
                  <Edit2 size={12} />
                  Edit Profile
                </Button>
              </Link>
            </div>
          </div>

          {/* Status / Wallet Card */}
          <Card className="bg-gradient-to-br from-card to-card/50 border-white/10 mb-8 overflow-hidden relative">
            <div className="absolute right-0 top-0 w-32 h-32 bg-secondary/10 blur-[50px] rounded-full -mr-10 -mt-10" />
            <CardContent className="p-5 flex items-center justify-between relative z-10">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-white/5 flex items-center justify-center border border-white/10">
                   <Wallet size={20} className="text-white" />
                </div>
                <div>
                   <p className="text-xs text-muted-foreground uppercase font-bold tracking-wider mb-0.5">Wallet Balance</p>
                   <p className="text-xl font-bold text-white">R {balanceValue}</p>
                   <p className="text-[10px] text-secondary font-bold">{totalBalance.toLocaleString()} Tokens</p>
                </div>
              </div>
              
              <div className="h-10 w-px bg-white/10 mx-2" />
              
              <div className="text-right">
                <p className="text-xs text-muted-foreground uppercase font-bold tracking-wider mb-0.5">Streak</p>
                <div className="flex items-center justify-end gap-1.5">
                   <Trophy size={14} className="text-yellow-500" />
                   <p className="text-lg font-bold text-white">{profile?.currentStreak || 0}</p>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Profile Actions List */}
          <div className="space-y-2">
            <h3 className="text-sm font-bold text-muted-foreground uppercase tracking-wider pl-1 mb-2">Account</h3>
            
            <Link href="/profile/referrals">
              <Button variant="ghost" className="w-full justify-between h-14 px-4 bg-card hover:bg-white/5 border border-white/5 rounded-xl group mb-2">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center">
                    <Users size={16} className="text-blue-400" />
                  </div>
                  <span className="text-white font-medium">My Referrals</span>
                </div>
                <ChevronRight className="text-muted-foreground group-hover:text-white transition-colors" size={18} />
              </Button>
            </Link>

            <Link href="/settings">
              <Button variant="ghost" className="w-full justify-between h-14 px-4 bg-card hover:bg-white/5 border border-white/5 rounded-xl group mb-2">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-white/5 flex items-center justify-center">
                    <SettingsIcon size={16} className="text-white" />
                  </div>
                  <span className="text-white font-medium">Settings</span>
                </div>
                <ChevronRight className="text-muted-foreground group-hover:text-white transition-colors" size={18} />
              </Button>
            </Link>

            <Link href="/profile/help">
              <Button variant="ghost" className="w-full justify-between h-14 px-4 bg-card hover:bg-white/5 border border-white/5 rounded-xl group mb-2">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-white/5 flex items-center justify-center">
                    <HelpCircle size={16} className="text-white" />
                  </div>
                  <span className="text-white font-medium">Help & Support</span>
                </div>
                <ChevronRight className="text-muted-foreground group-hover:text-white transition-colors" size={18} />
              </Button>
            </Link>

            <Link href="/profile/legal">
              <Button variant="ghost" className="w-full justify-between h-14 px-4 bg-card hover:bg-white/5 border border-white/5 rounded-xl group mb-6">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-white/5 flex items-center justify-center">
                    <Shield size={16} className="text-white" />
                  </div>
                  <span className="text-white font-medium">Legal & Privacy</span>
                </div>
                <ChevronRight className="text-muted-foreground group-hover:text-white transition-colors" size={18} />
              </Button>
            </Link>

            <Button 
              variant="ghost" 
              className="w-full h-12 text-red-400 hover:text-red-300 hover:bg-red-500/10 font-bold"
              onClick={handleLogout}
            >
              <LogOut size={18} className="mr-2" />
              Log Out
            </Button>
          </div>
        </div>
      </div>
      <BottomNav />
    </MobileFrame>
  );
}