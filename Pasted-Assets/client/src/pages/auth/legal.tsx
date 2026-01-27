import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ScrollArea } from "@/components/ui/scroll-area";
import { ArrowLeft, Shield, FileText, Lock } from "lucide-react";
import { Link, useLocation } from "wouter";
import { useEffect, useState } from "react";

export default function AuthLegalPrivacy() {
  const [location, setLocation] = useLocation();
  const [activeTab, setActiveTab] = useState("privacy");

  useEffect(() => {
    const searchParams = new URLSearchParams(window.location.search);
    const tab = searchParams.get("tab");
    if (tab === "terms" || tab === "privacy") {
      setActiveTab(tab);
    }
  }, [location]);

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <div onClick={() => window.history.back()}>
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </div>
            <h1 className="text-xl font-heading font-bold text-white">Legal & Privacy</h1>
          </div>
        </header>

        <div className="flex-1 overflow-hidden flex flex-col">
          <Tabs value={activeTab} onValueChange={setActiveTab} className="flex-1 flex flex-col">
            <div className="px-6 py-4">
              <TabsList className="w-full bg-white/5 p-1 rounded-xl border border-white/5">
                <TabsTrigger 
                  value="privacy" 
                  className="flex-1 font-bold data-[state=active]:bg-white/10 data-[state=active]:text-white rounded-lg transition-all"
                >
                  Privacy Policy
                </TabsTrigger>
                <TabsTrigger 
                  value="terms" 
                  className="flex-1 font-bold data-[state=active]:bg-white/10 data-[state=active]:text-white rounded-lg transition-all"
                >
                  Terms of Service
                </TabsTrigger>
              </TabsList>
            </div>

            <div className="flex-1 overflow-hidden relative">
              <TabsContent value="privacy" className="h-full m-0">
                <ScrollArea className="h-full px-6 pb-6">
                  <div className="space-y-6 pb-20">
                    <div className="flex items-center gap-3 mb-6">
                      <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center">
                        <Lock size={24} className="text-primary" />
                      </div>
                      <div>
                        <h2 className="text-lg font-bold text-white">Privacy Policy</h2>
                        <p className="text-xs text-muted-foreground">Last updated: December 12, 2025</p>
                      </div>
                    </div>

                    <div className="space-y-4 text-sm text-muted-foreground leading-relaxed">
                      <h3 className="text-white font-bold text-base">1. Introduction</h3>
                      <p>
                        Welcome to iMaliChat. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you as to how we look after your personal data when you visit our application and tell you about your privacy rights and how the law protects you.
                      </p>

                      <h3 className="text-white font-bold text-base">2. Data We Collect</h3>
                      <p>
                        We may collect, use, store and transfer different kinds of personal data about you which we have grouped together follows:
                      </p>
                      <ul className="list-disc pl-5 space-y-2">
                        <li><strong className="text-white">Identity Data:</strong> includes first name, last name, username or similar identifier.</li>
                        <li><strong className="text-white">Contact Data:</strong> includes mobile number and email address.</li>
                        <li><strong className="text-white">Financial Data:</strong> includes wallet balance and transaction history within the app.</li>
                        <li><strong className="text-white">Usage Data:</strong> includes information about how you use our app, ads viewed, and surveys completed.</li>
                      </ul>

                      <h3 className="text-white font-bold text-base">3. How We Use Your Data</h3>
                      <p>
                        We will only use your personal data when the law allows us to. Most commonly, we will use your personal data in the following circumstances:
                      </p>
                      <ul className="list-disc pl-5 space-y-2">
                        <li>To register you as a new user.</li>
                        <li>To process your earnings and rewards.</li>
                        <li>To manage our relationship with you.</li>
                        <li>To improve our website, products/services, marketing or customer relationships.</li>
                      </ul>

                      <h3 className="text-white font-bold text-base">4. Data Security</h3>
                      <p>
                        We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorised way, altered or disclosed. In addition, we limit access to your personal data to those employees, agents, contractors and other third parties who have a business need to know.
                      </p>
                    </div>
                  </div>
                </ScrollArea>
              </TabsContent>

              <TabsContent value="terms" className="h-full m-0">
                <ScrollArea className="h-full px-6 pb-6">
                  <div className="space-y-6 pb-20">
                    <div className="flex items-center gap-3 mb-6">
                      <div className="w-12 h-12 rounded-full bg-secondary/20 flex items-center justify-center">
                        <FileText size={24} className="text-secondary" />
                      </div>
                      <div>
                        <h2 className="text-lg font-bold text-white">Terms of Service</h2>
                        <p className="text-xs text-muted-foreground">Last updated: December 12, 2025</p>
                      </div>
                    </div>

                    <div className="space-y-4 text-sm text-muted-foreground leading-relaxed">
                      <h3 className="text-white font-bold text-base">1. Acceptance of Terms</h3>
                      <p>
                        By accessing and using iMaliChat, you accept and agree to be bound by the terms and provision of this agreement. In addition, when using these particular services, you shall be subject to any posted guidelines or rules applicable to such services.
                      </p>

                      <h3 className="text-white font-bold text-base">2. User Eligibility</h3>
                      <p>
                        You must be at least 18 years of age to use this Service. By using the Service, you represent and warrant that you have the right, authority, and capacity to enter into this Agreement and to abide by all of the terms and conditions of this Agreement.
                      </p>

                      <h3 className="text-white font-bold text-base">3. Earning & Rewards</h3>
                      <p>
                        iMaliChat provides users the opportunity to earn tokens by engaging with content. Tokens have no cash value outside of the iMaliChat platform until redeemed for specific services or products offered within the app.
                      </p>
                      <p>
                        We reserve the right to change the earning rates, redemption options, and token value at any time without prior notice. Fraudulent activity, including but not limited to automated bots or fake accounts, will result in immediate termination of your account and forfeiture of all earnings.
                      </p>

                      <h3 className="text-white font-bold text-base">4. User Conduct</h3>
                      <p>
                        You agree to use the Service only for purposes that are legal, proper and in accordance with these Terms and any applicable policies or guidelines.
                      </p>

                      <h3 className="text-white font-bold text-base">5. Termination</h3>
                      <p>
                        We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.
                      </p>
                    </div>
                  </div>
                </ScrollArea>
              </TabsContent>
            </div>
          </Tabs>
        </div>
      </div>
    </MobileFrame>
  );
}