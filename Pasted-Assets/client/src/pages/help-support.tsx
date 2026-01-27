import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ArrowLeft, Send, Loader2, CheckCircle2, HelpCircle } from "lucide-react";
import { Link } from "wouter";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";

export default function HelpSupport() {
  const { toast } = useToast();
  const [loading, setLoading] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    setLoading(false);
    setSubmitted(true);
    toast({
      title: "Message Sent",
      description: "We've received your message and will get back to you shortly.",
    });
  };

  if (submitted) {
    return (
      <MobileFrame>
        <div className="flex flex-col h-full bg-background items-center justify-center p-6 text-center">
          <div className="w-20 h-20 rounded-full bg-green-500/20 flex items-center justify-center mb-6">
            <CheckCircle2 size={40} className="text-green-500" />
          </div>
          <h2 className="text-2xl font-bold text-white mb-2">Message Sent!</h2>
          <p className="text-muted-foreground mb-8 max-w-xs">
            Thanks for reaching out. Our support team will review your message and reply via email within 24 hours.
          </p>
          <Link href="/profile">
            <Button className="w-full bg-white text-black hover:bg-white/90 font-bold h-12">
              Back to Profile
            </Button>
          </Link>
        </div>
      </MobileFrame>
    );
  }

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/profile">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">Help & Support</h1>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto p-6">
          <div className="mb-8">
            <div className="flex items-center gap-3 mb-2">
               <div className="w-10 h-10 rounded-full bg-secondary/20 flex items-center justify-center">
                 <HelpCircle size={20} className="text-secondary" />
               </div>
               <h2 className="text-lg font-bold text-white">How can we help?</h2>
            </div>
            <p className="text-muted-foreground text-sm">
              Having trouble with the app? Fill out the form below and our team will assist you.
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Subject</label>
              <Select defaultValue="general">
                <SelectTrigger className="bg-white/5 border-white/10 text-white h-12">
                  <SelectValue placeholder="Select a topic" />
                </SelectTrigger>
                <SelectContent className="bg-card border-white/10 text-white">
                  <SelectItem value="general">General Inquiry</SelectItem>
                  <SelectItem value="earnings">Issue with Earnings</SelectItem>
                  <SelectItem value="wallet">Wallet & Payments</SelectItem>
                  <SelectItem value="technical">Technical Bug</SelectItem>
                  <SelectItem value="account">Account & Security</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Your Name</label>
              <Input 
                placeholder="Enter your name" 
                className="bg-white/5 border-white/10 text-white h-12"
                defaultValue="Fundeka Zulu"
              />
            </div>

            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Email Address</label>
              <Input 
                type="email"
                placeholder="Enter your email" 
                className="bg-white/5 border-white/10 text-white h-12"
              />
              <p className="text-xs text-muted-foreground ml-1">We'll send our response to this email.</p>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-bold text-white ml-1">Message</label>
              <Textarea 
                placeholder="Describe your issue in detail..." 
                className="bg-white/5 border-white/10 text-white min-h-[150px] resize-none"
              />
            </div>

            <div className="pt-4">
              <Button 
                type="submit" 
                className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-12 shadow-lg"
                disabled={loading}
              >
                {loading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Sending...
                  </>
                ) : (
                  <>
                    <Send className="mr-2 h-4 w-4" /> Send Message
                  </>
                )}
              </Button>
            </div>
          </form>
          
          <div className="mt-8 pt-8 border-t border-white/5 text-center">
            <p className="text-xs text-muted-foreground mb-2">Or email us directly at</p>
            <a href="mailto:support@imalichat.com" className="text-secondary font-bold hover:underline">
              support@imalichat.com
            </a>
          </div>
        </div>
      </div>
    </MobileFrame>
  );
}