import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, CheckCircle2, Crown, Clock } from "lucide-react";
import { Link, useRoute, useLocation } from "wouter";
import { useState, useEffect } from "react";
import { RewardAnimation } from "@/components/earn/reward-animation";
import { Progress } from "@/components/ui/progress";

// Mock Data for Detail View (in a real app, this would be fetched by ID)
const DETAIL_DATA: Record<string, any> = {
  "1": { // Daily Trivia
    id: 1,
    brandName: "iMaliChat Daily",
    title: "Daily Trivia Pot",
    totalPotentialTokens: 50,
    type: "text", // text, image, video
    content: "Financial literacy is key to building wealth. Today we're learning about compound interest. Compound interest is the interest on a loan or deposit calculated based on both the initial principal and the accumulated interest from previous periods.",
    questions: [
      {
        id: "q1",
        text: "What is compound interest?",
        options: [
          "Interest only on the principal amount",
          "Interest on principal + accumulated interest",
          "Free money from the government"
        ],
        correctIndex: 1,
        reward: 15
      },
      {
        id: "q2",
        text: "How often can interest compound?",
        options: [
          "Only annually",
          "Daily, Monthly, or Annually",
          "Never"
        ],
        correctIndex: 1,
        reward: 15
      },
      {
        id: "q3",
        text: "Which grows money faster?",
        options: [
          "Simple Interest",
          "Compound Interest",
          "Keeping cash under a mattress"
        ],
        correctIndex: 1,
        reward: 20
      }
    ]
  },
  "2": { // Watch & Win
    id: 2,
    brandName: "iMaliChat Daily",
    title: "Watch & Win",
    totalPotentialTokens: 15,
    type: "video",
    content: "https://example.com/video.mp4", // Mock URL
    questions: [
      {
        id: "q1",
        text: "Did you watch the entire video?",
        options: ["Yes", "No"],
        correctIndex: 0,
        reward: 15
      }
    ]
  },
  "3": { // Nike Survey
    id: 3,
    brandName: "Nike SA",
    title: "New Air Max Launch",
    totalPotentialTokens: 120,
    type: "image",
    content: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1000&auto=format&fit=crop",
    questions: [
      { id: "q1", text: "How do you like this design?", options: ["Love it", "It's okay", "Not for me"], correctIndex: 0, reward: 40 },
      { id: "q2", text: "What's your favorite color?", options: ["Red", "Blue", "Black"], correctIndex: 2, reward: 40 },
      { id: "q3", text: "Would you buy this?", options: ["Yes", "Maybe", "No"], correctIndex: 0, reward: 40 }
    ]
  }
};

export default function EarnDetail() {
  const [, params] = useRoute("/earn/detail/:id");
  const [, setLocation] = useLocation();
  const id = params?.id || "1";
  const data = DETAIL_DATA[id] || DETAIL_DATA["1"]; // Fallback

  const [step, setStep] = useState<"media" | "survey" | "complete">("media");
  const [mediaUnlocked, setMediaUnlocked] = useState(false);
  const [countdown, setCountdown] = useState(3);
  const [showReward, setShowReward] = useState(false);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [totalEarned, setTotalEarned] = useState(0);
  
  // Media Countdown Logic
  useEffect(() => {
    if (step === "media" && !mediaUnlocked) {
      if (countdown > 0) {
        const timer = setTimeout(() => setCountdown(c => c - 1), 1000);
        return () => clearTimeout(timer);
      } else {
        // Countdown finished
        setMediaUnlocked(true);
        triggerReward();
      }
    }
  }, [step, countdown, mediaUnlocked]);

  const triggerReward = () => {
    setShowReward(true);
    setTimeout(() => setShowReward(false), 1500);
  };

  const handleStartSurvey = () => {
    setStep("survey");
  };

  const handleSubmitAnswer = () => {
    if (selectedOption === null) return;
    
    // Add reward
    const question = data.questions[currentQuestionIndex];
    setTotalEarned(prev => prev + question.reward);
    triggerReward();
    
    // Move to next or complete
    setTimeout(() => {
      if (currentQuestionIndex < data.questions.length - 1) {
        setCurrentQuestionIndex(prev => prev + 1);
        setSelectedOption(null);
      } else {
        setStep("complete");
      }
    }, 1000); // Slight delay to see the reward animation
  };

  return (
    <MobileFrame className="bg-background flex flex-col h-screen relative">
      <RewardAnimation show={showReward} />

      {/* Header */}
      <header className="px-4 py-4 flex items-center gap-3 bg-card/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
        <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full" onClick={() => history.back()}>
          <ArrowLeft size={20} />
        </Button>
        <div className="flex-1">
          <p className="text-xs text-muted-foreground uppercase tracking-wider font-bold">{data.brandName}</p>
          <h1 className="text-base font-heading font-bold text-white truncate">{data.title}</h1>
        </div>
        <div className="flex items-center gap-1 text-secondary font-bold text-xs bg-secondary/10 px-2 py-1 rounded">
           <Crown size={12} fill="currentColor" />
           Up to {data.totalPotentialTokens}
        </div>
      </header>

      <div className="flex-1 overflow-y-auto p-6 pb-24">
        <AnimatePresence mode="wait">
          {step === "media" && (
            <motion.div 
              key="media"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, x: -20 }}
              className="space-y-6"
            >
              {/* Media Content */}
              <div className="bg-card border border-white/10 rounded-2xl overflow-hidden shadow-lg">
                {data.type === "image" && (
                  <div className="relative aspect-video bg-black/50">
                    <img src={data.content} alt="Content" className="w-full h-full object-cover" />
                  </div>
                )}
                
                {data.type === "video" && (
                  <div className="aspect-video bg-black flex items-center justify-center relative">
                    {/* Simulated Video Player */}
                    <div className="w-16 h-16 rounded-full bg-white/20 flex items-center justify-center backdrop-blur-sm">
                       <div className="w-0 h-0 border-t-[10px] border-t-transparent border-l-[20px] border-l-white border-b-[10px] border-b-transparent ml-1" />
                    </div>
                    <div className="absolute bottom-4 left-4 right-4 h-1 bg-white/20 rounded-full overflow-hidden">
                       <motion.div 
                         className="h-full bg-primary"
                         initial={{ width: "0%" }}
                         animate={{ width: "100%" }}
                         transition={{ duration: 3, ease: "linear" }}
                       />
                    </div>
                  </div>
                )}

                {data.type === "text" && (
                  <div className="p-6">
                    <p className="text-white text-lg leading-relaxed font-medium">
                      {data.content}
                    </p>
                  </div>
                )}

                {/* Countdown / Progress Bar */}
                <div className="p-4 bg-white/5 border-t border-white/5">
                  {!mediaUnlocked ? (
                    <div className="space-y-2">
                       <div className="flex justify-between text-xs text-muted-foreground">
                         <span>Reviewing...</span>
                         <span>{countdown}s</span>
                       </div>
                       <Progress value={(3 - countdown) * 33.33} className="h-1" />
                    </div>
                  ) : (
                    <div className="flex items-center gap-2 text-green-400 text-sm font-bold justify-center">
                       <CheckCircle2 size={16} /> Content Unlocked!
                    </div>
                  )}
                </div>
              </div>

              <div className="pt-4">
                <Button 
                  size="lg" 
                  className="w-full h-14 font-bold bg-primary hover:bg-primary/90 text-white shadow-lg disabled:opacity-50"
                  disabled={!mediaUnlocked}
                  onClick={handleStartSurvey}
                >
                  {mediaUnlocked ? "Continue to Questions" : `Wait ${countdown}s`}
                </Button>
              </div>
            </motion.div>
          )}

          {step === "survey" && (
            <motion.div 
              key="survey"
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              className="space-y-6"
            >
              <div className="flex justify-between items-center text-sm text-muted-foreground mb-2">
                 <span>Question {currentQuestionIndex + 1} of {data.questions.length}</span>
                 <span className="text-secondary font-bold">+{data.questions[currentQuestionIndex].reward} tokens</span>
              </div>

              <div className="bg-card border border-white/10 rounded-2xl p-6 shadow-lg">
                <h2 className="text-xl font-bold text-white mb-6">
                  {data.questions[currentQuestionIndex].text}
                </h2>

                <div className="space-y-3">
                  {data.questions[currentQuestionIndex].options.map((option: string, idx: number) => (
                    <div 
                      key={idx}
                      onClick={() => setSelectedOption(idx)}
                      className={`
                        p-4 rounded-xl border cursor-pointer transition-all flex items-center justify-between
                        ${selectedOption === idx 
                          ? "bg-primary/20 border-primary text-white" 
                          : "bg-white/5 border-white/10 text-muted-foreground hover:bg-white/10"}
                      `}
                    >
                      <span className="font-medium">{option}</span>
                      {selectedOption === idx && <CheckCircle2 size={18} className="text-primary" />}
                    </div>
                  ))}
                </div>
              </div>

              <Button 
                size="lg" 
                className="w-full h-14 font-bold bg-primary hover:bg-primary/90 text-white shadow-lg mt-8"
                disabled={selectedOption === null}
                onClick={handleSubmitAnswer}
              >
                Submit Answer
              </Button>
            </motion.div>
          )}

          {step === "complete" && (
            <motion.div 
              key="complete"
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              className="flex flex-col items-center justify-center py-10 text-center space-y-6"
            >
              <div className="w-32 h-32 bg-gradient-to-br from-green-400 to-emerald-600 rounded-full flex items-center justify-center shadow-[0_0_40px_rgba(74,222,128,0.3)] mb-4">
                 <CheckCircle2 size={64} className="text-white" />
              </div>
              
              <div className="space-y-2">
                <h2 className="text-3xl font-heading font-bold text-white">Nice Work!</h2>
                <p className="text-muted-foreground text-lg">You just earned</p>
                <div className="text-5xl font-bold text-secondary drop-shadow-[0_0_10px_rgba(255,193,7,0.5)]">
                  {totalEarned}
                </div>
                <p className="text-sm text-muted-foreground uppercase tracking-widest font-bold">Tokens</p>
              </div>

              <div className="bg-white/5 rounded-xl p-4 w-full max-w-xs border border-white/10 mt-8">
                 <p className="text-sm text-muted-foreground mb-1">Your new balance</p>
                 <p className="text-xl font-bold text-white">3,570 Tokens</p>
              </div>

              <div className="flex flex-col gap-3 w-full pt-8">
                <Link href="/earn">
                  <Button size="lg" className="w-full h-14 font-bold bg-primary hover:bg-primary/90">
                    Back to Earn Offers
                  </Button>
                </Link>
                <Link href="/home">
                  <Button variant="ghost" className="w-full font-bold text-muted-foreground hover:text-white">
                    Go Home
                  </Button>
                </Link>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </MobileFrame>
  );
}
