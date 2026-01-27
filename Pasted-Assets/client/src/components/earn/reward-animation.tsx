import { motion } from "framer-motion";
import { Crown } from "lucide-react";

export function RewardAnimation({ show, onComplete }: { show: boolean, onComplete?: () => void }) {
  if (!show) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center pointer-events-none">
      <motion.div
        initial={{ scale: 0, opacity: 0, y: 0 }}
        animate={{ 
          scale: [0, 1.5, 1], 
          opacity: [0, 1, 0],
          y: [0, -100] 
        }}
        transition={{ duration: 1.5, ease: "easeOut" }}
        onAnimationComplete={onComplete}
        className="relative"
      >
        <div className="w-24 h-24 rounded-full bg-gradient-to-br from-secondary to-orange-400 flex items-center justify-center shadow-[0_0_50px_rgba(255,193,7,0.6)] border-4 border-white/20">
          <Crown size={48} className="text-white fill-white" />
        </div>
        <div className="absolute inset-0 bg-white/30 rounded-full blur-xl animate-pulse" />
      </motion.div>
    </div>
  );
}
