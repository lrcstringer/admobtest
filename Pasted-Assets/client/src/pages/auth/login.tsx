import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useState } from "react";
import { motion } from "framer-motion";
import { ArrowLeft, Loader2, User, Lock } from "lucide-react";
import { useLocation, Link } from "wouter";
import { useMutation } from "@tanstack/react-query";
import { authApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

export default function Login() {
  const [, setLocation] = useLocation();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const { toast } = useToast();

  const loginMutation = useMutation({
    mutationFn: () => authApi.login(username, password),
    onSuccess: () => {
      setLocation("/home");
    },
    onError: (error: any) => {
      toast({
        title: "Login Failed",
        description: error?.message || "Invalid username or password",
        variant: "destructive",
      });
    },
  });

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    if (username && password) {
      loginMutation.mutate();
    }
  };

  return (
    <MobileFrame className="bg-background relative">
      <div className="flex-1 flex flex-col px-6 py-12">
        {/* Header */}
        <div className="mb-10">
          <Link href="/">
            <Button 
              variant="ghost" 
              size="icon" 
              className="mb-6 -ml-2 text-muted-foreground hover:text-white"
            >
              <ArrowLeft />
            </Button>
          </Link>
          
          <div className="flex justify-center mb-8">
             <div className="w-20 h-20 bg-white/5 rounded-full flex items-center justify-center border border-white/10 shadow-lg">
               <img src={appLogo} alt="Logo" className="w-12 h-auto" />
             </div>
          </div>

          <h1 className="text-3xl font-heading font-bold text-white mb-2 text-center">
            Welcome back!
          </h1>
          <p className="text-muted-foreground text-center">
            Sign in to access your wallet and start earning.
          </p>
        </div>

        <motion.form
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="space-y-6"
          onSubmit={handleLogin}
        >
          <div className="space-y-2">
            <Label htmlFor="username" className="text-white/80 text-sm">Username</Label>
            <div className="bg-card border border-white/10 rounded-xl p-4 flex items-center gap-3 shadow-lg focus-within:ring-2 focus-within:ring-primary/50 transition-all">
              <User className="text-muted-foreground" size={20} />
              <div className="w-px h-6 bg-white/10" />
              <Input 
                id="username"
                autoFocus
                type="text" 
                placeholder="Enter username" 
                className="border-0 bg-transparent p-0 text-lg text-white placeholder:text-muted-foreground/50 focus-visible:ring-0 focus-visible:ring-offset-0 h-auto"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
                data-testid="input-username"
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="password" className="text-white/80 text-sm">Password</Label>
            <div className="bg-card border border-white/10 rounded-xl p-4 flex items-center gap-3 shadow-lg focus-within:ring-2 focus-within:ring-primary/50 transition-all">
              <Lock className="text-muted-foreground" size={20} />
              <div className="w-px h-6 bg-white/10" />
              <Input 
                id="password"
                type="password" 
                placeholder="Enter password" 
                className="border-0 bg-transparent p-0 text-lg text-white placeholder:text-muted-foreground/50 focus-visible:ring-0 focus-visible:ring-offset-0 h-auto"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                data-testid="input-password"
              />
            </div>
          </div>

          <Button 
            type="submit"
            size="lg" 
            className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-[0_4px_20px_rgba(255,51,138,0.3)] transition-all rounded-xl"
            disabled={!username || !password || loginMutation.isPending}
            data-testid="button-login"
          >
            {loginMutation.isPending ? <Loader2 className="animate-spin" /> : "Sign In"}
          </Button>

          <div className="text-center pt-4">
            <p className="text-muted-foreground text-sm">
              Don't have an account?{" "}
              <Link href="/auth/phone">
                <span className="text-primary font-bold hover:underline cursor-pointer">
                  Sign Up
                </span>
              </Link>
            </p>
          </div>
        </motion.form>
      </div>
    </MobileFrame>
  );
}
