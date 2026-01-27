import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";
import { Link } from "wouter";
import heroImage from "@assets/generated_images/abstract_wave_shape_in_yellow_and_pink_on_dark_navy.png";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";
import { Check, ArrowRight } from "lucide-react";

export default function Onboarding() {
  return (
    <MobileFrame className="bg-background relative">
      {/* Background Hero */}
      <div className="absolute top-0 left-0 w-full h-[55%] overflow-hidden z-0">
        <div className="absolute inset-0 bg-gradient-to-b from-transparent to-background z-10" />
        <img 
          src={heroImage} 
          alt="Abstract Wave" 
          className="w-full h-full object-cover opacity-80"
        />
      </div>

      <div className="flex-1 flex flex-col justify-end px-6 pb-12 z-10 relative">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          <div className="mb-6">
            <div className="flex justify-start mb-6">
              <img src={appLogo} alt="iMaliChat Logo" className="w-24 h-auto drop-shadow-[0_0_15px_rgba(255,255,255,0.3)]" />
            </div>
            
            <h1 className="text-4xl md:text-5xl font-heading font-bold leading-[1.1] text-white mb-4">
              Turn your <br/>
              <span className="text-gradient">attention</span> into <br/>
              earning power.
            </h1>
            <p className="text-muted-foreground text-lg mb-8">
              Join the community where your time pays off. Literally.
            </p>
          </div>

          <div className="space-y-4 mb-10">
            {[
              "Watch short ads to earn tokens",
              "Answer quick surveys for cash",
              "Join daily prize pots & win big"
            ].map((item, i) => (
              <motion.div 
                key={i}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.2 + (i * 0.1) }}
                className="flex items-center gap-3"
              >
                <div className="w-6 h-6 rounded-full bg-primary/20 flex items-center justify-center text-primary">
                  <Check size={14} strokeWidth={3} />
                </div>
                <span className="text-white font-medium">{item}</span>
              </motion.div>
            ))}
          </div>

          <div className="space-y-4">
            <Link href="/auth/phone">
              <Button size="lg" className="w-full h-14 text-lg font-bold bg-primary hover:bg-primary/90 shadow-[0_0_20px_rgba(255,51,138,0.3)] hover:shadow-[0_0_30px_rgba(255,51,138,0.5)] transition-all rounded-xl">
                Get Started
                <ArrowRight className="ml-2 w-5 h-5" />
              </Button>
            </Link>
            
            <Link href="/auth/login">
              <Button variant="ghost" className="w-full text-white/60 hover:text-white hover:bg-white/5 font-medium">
                Already have an account? Log in
              </Button>
            </Link>
          </div>
        </motion.div>
      </div>
    </MobileFrame>
  );
}
