import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { InputOTP, InputOTPGroup, InputOTPSlot } from "@/components/ui/input-otp";
import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowRight, ArrowLeft, Phone, Loader2 } from "lucide-react";
import { useLocation } from "wouter";

export default function PhoneVerification() {
  const [, setLocation] = useLocation();
  const [step, setStep] = useState<"phone" | "otp">("phone");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [otp, setOtp] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [timer, setTimer] = useState(30);

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (step === "otp" && timer > 0) {
      interval = setInterval(() => setTimer((t) => t - 1), 1000);
    }
    return () => clearInterval(interval);
  }, [step, timer]);

  const handleSendCode = () => {
    if (phoneNumber.length < 9) return;
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      setIsLoading(false);
      setStep("otp");
      setTimer(30);
    }, 1500);
  };

  const handleVerify = () => {
    // Bypass OTP verification for now - accept any input
    setIsLoading(true);
    // Simulate verification (auto-pass)
    setTimeout(() => {
      setIsLoading(false);
      setLocation("/auth/profile");
    }, 1000);
  };

  return (
    <MobileFrame className="bg-background relative">
      <div className="flex-1 flex flex-col px-6 py-12">
        {/* Header */}
        <div className="mb-12">
          {step === "otp" && (
            <Button 
              variant="ghost" 
              size="icon" 
              className="mb-6 -ml-2 text-muted-foreground hover:text-white"
              onClick={() => setStep("phone")}
            >
              <ArrowLeft />
            </Button>
          )}
          <h1 className="text-3xl font-heading font-bold text-white mb-2">
            {step === "phone" ? "What's your number?" : "Verify it's you"}
          </h1>
          <p className="text-muted-foreground">
            {step === "phone" 
              ? "We'll send you a secure code to verify your identity." 
              : `Enter the 6-digit code sent to ${phoneNumber}`
            }
          </p>
        </div>

        <AnimatePresence mode="wait">
          {step === "phone" ? (
            <motion.div
              key="phone-step"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              className="space-y-6"
            >
              <div className="bg-card border border-white/10 rounded-xl p-4 flex items-center gap-3 shadow-lg focus-within:ring-2 focus-within:ring-primary/50 transition-all">
                <Phone className="text-muted-foreground" size={20} />
                <div className="w-px h-6 bg-white/10" />
                <span className="text-white font-medium">+27</span>
                <Input 
                  autoFocus
                  type="tel" 
                  placeholder="00 000 0000" 
                  className="border-0 bg-transparent p-0 text-lg text-white placeholder:text-muted-foreground/50 focus-visible:ring-0 focus-visible:ring-offset-0 h-auto"
                  value={phoneNumber}
                  onChange={(e) => setPhoneNumber(e.target.value)}
                />
              </div>

              <div className="text-xs text-muted-foreground text-center px-4">
                By tapping "Send Code", you agree to our 
                <span 
                  className="text-primary underline cursor-pointer ml-1" 
                  onClick={() => setLocation("/auth/legal?tab=terms")}
                >
                  Terms
                </span> and 
                <span 
                  className="text-primary underline cursor-pointer ml-1" 
                  onClick={() => setLocation("/auth/legal?tab=privacy")}
                >
                  Privacy Policy
                </span>.
              </div>

              <Button 
                size="lg" 
                className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-[0_4px_20px_rgba(255,51,138,0.3)] transition-all rounded-xl"
                onClick={handleSendCode}
                disabled={phoneNumber.length < 9 || isLoading}
              >
                {isLoading ? <Loader2 className="animate-spin" /> : "Send Code"}
              </Button>
            </motion.div>
          ) : (
            <motion.div
              key="otp-step"
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: 20 }}
              className="space-y-8"
            >
              <div className="flex justify-center">
                <InputOTP maxLength={6} value={otp} onChange={setOtp}>
                  <InputOTPGroup className="gap-2">
                    {[0, 1, 2, 3, 4, 5].map((index) => (
                      <InputOTPSlot 
                        key={index} 
                        index={index} 
                        className="w-12 h-14 bg-card border-white/10 rounded-lg text-2xl text-white font-bold ring-offset-background transition-all focus-within:ring-2 focus-within:ring-primary focus-within:border-primary"
                      />
                    ))}
                  </InputOTPGroup>
                </InputOTP>
              </div>

              <div className="flex flex-col gap-4">
                <Button 
                  size="lg" 
                  className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-[0_4px_20px_rgba(255,51,138,0.3)] transition-all rounded-xl"
                  onClick={handleVerify}
                  disabled={isLoading}
                >
                   {isLoading ? <Loader2 className="animate-spin" /> : "Verify & Continue"}
                </Button>

                <div className="text-center">
                  {timer > 0 ? (
                    <p className="text-sm text-muted-foreground">Resend code in <span className="text-secondary font-bold">00:{timer < 10 ? `0${timer}` : timer}</span></p>
                  ) : (
                    <Button variant="link" className="text-secondary font-bold" onClick={() => setTimer(30)}>
                      Resend Code
                    </Button>
                  )}
                </div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </MobileFrame>
  );
}
