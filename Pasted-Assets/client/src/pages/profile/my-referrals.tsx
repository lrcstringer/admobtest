import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ArrowLeft, Users, Trophy, ChevronRight, Gift, HelpCircle, X, Check, Loader2 } from "lucide-react";
import { Link, useLocation } from "wouter";
import { Dialog, DialogContent } from "@/components/ui/dialog";
import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { useQuery } from "@tanstack/react-query";
import { referralApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function MyReferrals() {
  const [, setLocation] = useLocation();
  const [showExplainer, setShowExplainer] = useState(false);
  const { toast } = useToast();

  const { data: referralData, isLoading, error } = useQuery({
    queryKey: ["referrals"],
    queryFn: referralApi.getReferrals,
  });

  if (error) {
    toast({
      title: "Error loading referrals",
      description: "Failed to load referral data",
      variant: "destructive",
    });
  }

  const referredContacts = referralData?.referrals || [];
  const friendsInvited = referredContacts.length;
  const friendsJoined = referredContacts.filter((c: any) => c.status === "joined").length;
  
  const bonusTokens = referralData?.totalEarnings || 0;
  const assistScore = referralData?.assistScore || 0;

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background relative">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/profile">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">My Referrals</h1>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto pb-24">
          <div className="p-6 space-y-6">
            {isLoading ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 className="h-8 w-8 animate-spin text-primary" />
              </div>
            ) : (
              <>
                {/* Overview / Summary Card */}
                <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-secondary/20 to-orange-500/10 border border-secondary/20 p-6">
              <div className="absolute top-0 right-0 w-32 h-32 bg-secondary/10 blur-[40px] rounded-full -mr-10 -mt-10" />
              
              <div className="relative z-10">
                <div className="flex items-start justify-between mb-4">
                  <div>
                    <h2 className="text-lg font-bold text-white mb-1">Invite friends & earn</h2>
                    <p className="text-xs text-muted-foreground max-w-[200px]">
                      You and your friend both get bonus tokens when they join using your invite.
                    </p>
                  </div>
                  <div className="w-10 h-10 rounded-full bg-secondary/20 flex items-center justify-center">
                    <Gift size={20} className="text-secondary" />
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3 mb-2">
                  <div className="bg-background/40 backdrop-blur-sm rounded-xl p-3 border border-white/5">
                    <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider mb-1">Total Earned</p>
                    <p className="text-xl font-bold text-white">{bonusTokens} Tokens</p>
                  </div>
                  <div className="bg-background/40 backdrop-blur-sm rounded-xl p-3 border border-white/5">
                    <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider mb-1">Assist Score</p>
                    <p className="text-xl font-bold text-secondary">{assistScore}</p>
                  </div>
                </div>

                <div className="flex gap-4 px-1">
                   <div className="flex items-center gap-1.5">
                      <Users size={12} className="text-muted-foreground" />
                      <span className="text-xs text-muted-foreground"><strong className="text-white">{friendsInvited}</strong> Invited</span>
                   </div>
                   <div className="flex items-center gap-1.5">
                      <Check size={12} className="text-green-400" />
                      <span className="text-xs text-muted-foreground"><strong className="text-white">{friendsJoined}</strong> Joined</span>
                   </div>
                </div>
              </div>
            </div>

                <button 
                  onClick={() => setShowExplainer(true)}
                  className="flex items-center gap-2 text-sm text-muted-foreground hover:text-white transition-colors mx-auto"
                >
                  <HelpCircle size={14} />
                  How referrals work
                </button>

                {/* List of People */}
                <div>
                  <h3 className="text-sm font-bold text-white mb-4 pl-1">People you've brought to iMaliChat</h3>
                  
                  <div className="space-y-3">
                    {referredContacts.length > 0 ? (
                      referredContacts.map((contact: any) => (
                        <div key={contact.id} className="bg-card border border-white/5 rounded-2xl p-4 flex items-center justify-between">
                          <div className="flex items-center gap-3">
                             <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-sm ${
                               contact.status === 'joined' ? 'bg-primary/20 text-primary border border-primary/20' : 'bg-white/5 text-muted-foreground border border-white/10'
                             }`}>
                               {contact.name ? contact.name.substring(0, 2).toUpperCase() : '??'}
                             </div>
                             <div>
                               <p className="text-sm font-bold text-white">{contact.name || 'Unknown'}</p>
                               <p className="text-xs text-muted-foreground">{contact.phoneNumber || '-'}</p>
                             </div>
                          </div>
                          
                          <Badge variant="outline" className={`border-0 ${
                            contact.status === 'joined' 
                              ? 'bg-green-500/10 text-green-400' 
                              : 'bg-white/5 text-muted-foreground'
                          }`}>
                            {contact.status === 'joined' ? 'Joined' : 'Invited'}
                          </Badge>
                        </div>
                      ))
                    ) : (
                      <div className="text-center py-12 px-6 bg-card border border-white/5 rounded-3xl">
                        <div className="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-4">
                          <Users size={24} className="text-white/30" />
                        </div>
                        <h3 className="text-white font-bold mb-1">No referrals yet</h3>
                        <p className="text-muted-foreground text-sm">
                          Invite your contacts to start earning bonus tokens.
                        </p>
                      </div>
                    )}
                  </div>
                </div>
              </>
            )}
          </div>
        </div>

        {/* Footer CTA */}
        <div className="p-6 border-t border-white/10 bg-background/95 backdrop-blur-md absolute bottom-0 left-0 right-0 z-20">
          <Button 
            className="w-full h-12 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg"
            onClick={() => window.location.href = "/chat?mode=invite"}
          >
            Invite Friends
          </Button>
        </div>
      </div>

      {/* Explainer Modal */}
      <Dialog open={showExplainer} onOpenChange={setShowExplainer}>
        <DialogContent className="bg-card border-white/10 text-white w-[90%] rounded-3xl p-0 overflow-hidden max-w-sm">
           <div className="bg-gradient-to-br from-secondary/20 to-orange-500/10 p-6 flex justify-center">
             <div className="w-20 h-20 bg-secondary/20 rounded-full flex items-center justify-center border border-secondary/20">
               <Gift size={40} className="text-secondary" />
             </div>
           </div>
           
           <div className="p-6">
             <h2 className="text-xl font-bold text-white mb-4 text-center">How referrals work</h2>
             
             <div className="space-y-4 mb-8">
               <div className="flex gap-3">
                 <div className="w-6 h-6 rounded-full bg-white/10 flex items-center justify-center shrink-0 text-xs font-bold">1</div>
                 <p className="text-sm text-muted-foreground">Invite your contacts directly from iMaliChat.</p>
               </div>
               <div className="flex gap-3">
                 <div className="w-6 h-6 rounded-full bg-white/10 flex items-center justify-center shrink-0 text-xs font-bold">2</div>
                 <p className="text-sm text-muted-foreground">When someone you invited signs up using their mobile number, you both receive a starter bonus.</p>
               </div>
               <div className="flex gap-3">
                 <div className="w-6 h-6 rounded-full bg-white/10 flex items-center justify-center shrink-0 text-xs font-bold">3</div>
                 <p className="text-sm text-muted-foreground">First-touch wins: You are recorded as the referrer only if you were the first person to invite that number.</p>
               </div>
               <div className="flex gap-3">
                 <div className="w-6 h-6 rounded-full bg-white/10 flex items-center justify-center shrink-0 text-xs font-bold">4</div>
                 <p className="text-sm text-muted-foreground">As your friends keep watching ads and completing surveys, your assist score grows.</p>
               </div>
             </div>
             
             <Button className="w-full bg-primary text-white font-bold" onClick={() => setShowExplainer(false)}>
               Got it
             </Button>
           </div>
        </DialogContent>
      </Dialog>
    </MobileFrame>
  );
}