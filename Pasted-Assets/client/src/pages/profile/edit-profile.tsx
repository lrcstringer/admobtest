import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { ArrowLeft, Camera, Loader2, CheckCircle2 } from "lucide-react";
import { Link, useLocation } from "wouter";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent } from "@/components/ui/dialog";

export default function EditProfile() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  
  const [name, setName] = useState("Fundeka Zulu");
  const [username, setUsername] = useState("@fundeka_z");
  const [saving, setSaving] = useState(false);
  const [showSuccess, setShowSuccess] = useState(false);

  const handleSave = async () => {
    if (!name || !username) {
      toast({
        title: "Missing Information",
        description: "Please fill in all required fields.",
        variant: "destructive"
      });
      return;
    }

    setSaving(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500));
    setSaving(false);
    setShowSuccess(true);
  };

  const handleDone = () => {
    setShowSuccess(false);
    setLocation("/profile");
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        {/* Header */}
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/profile">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">Edit Profile</h1>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto p-6">
          {/* Avatar Section */}
          <div className="flex flex-col items-center mb-8">
            <div className="relative mb-3">
              <Avatar className="h-24 w-24 border-2 border-white/10">
                <AvatarFallback className="bg-primary/20 text-primary text-2xl font-bold">
                  FZ
                </AvatarFallback>
              </Avatar>
              <div className="absolute bottom-0 right-0 bg-secondary text-secondary-foreground p-1.5 rounded-full border-2 border-background cursor-pointer hover:bg-secondary/90 transition-colors">
                <Camera size={14} />
              </div>
            </div>
            <Button variant="ghost" size="sm" className="text-secondary font-bold hover:text-secondary/80 hover:bg-secondary/10">
              Change Photo
            </Button>
          </div>

          {/* Form Fields */}
          <div className="space-y-6">
            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Display Name</label>
              <Input 
                value={name}
                onChange={(e) => setName(e.target.value)}
                className="bg-white/5 border-white/10 text-white h-12"
                placeholder="Enter your name"
              />
            </div>

            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Username</label>
              <Input 
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="bg-white/5 border-white/10 text-white h-12"
                placeholder="@username"
              />
            </div>

            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Phone Number</label>
              <Input 
                value="082 123 4567"
                disabled
                className="bg-white/5 border-white/10 text-muted-foreground h-12 opacity-50 cursor-not-allowed"
              />
              <p className="text-xs text-muted-foreground ml-1">Phone number cannot be changed</p>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="p-6 border-t border-white/10 bg-background/95 backdrop-blur-md sticky bottom-0 z-20">
          <Button 
            className="w-full h-12 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg"
            disabled={saving}
            onClick={handleSave}
          >
            {saving ? <Loader2 className="animate-spin" /> : "Save Changes"}
          </Button>
        </div>
      </div>

      {/* Success Dialog */}
      <Dialog open={showSuccess} onOpenChange={(open) => !open && handleDone()}>
        <DialogContent className="bg-card border-white/10 text-white w-[90%] rounded-3xl p-8 flex flex-col items-center justify-center">
           <div className="w-20 h-20 rounded-full bg-green-500/20 flex items-center justify-center mb-6">
             <CheckCircle2 size={40} className="text-green-500" />
           </div>
           
           <h2 className="text-2xl font-bold text-white mb-2 text-center">Profile Updated!</h2>
           <p className="text-muted-foreground text-center mb-6">
             Your profile changes have been saved successfully.
           </p>
           
           <Button className="w-full bg-white text-black hover:bg-white/90 font-bold" onClick={handleDone}>
             Done
           </Button>
        </DialogContent>
      </Dialog>
    </MobileFrame>
  );
}