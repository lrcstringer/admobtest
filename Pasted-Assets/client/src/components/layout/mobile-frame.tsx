import React from "react";

interface MobileFrameProps {
  children: React.ReactNode;
  className?: string;
}

export function MobileFrame({ children, className = "" }: MobileFrameProps) {
  return (
    <div className="min-h-screen w-full bg-black/10 flex justify-center">
      <div className={`w-full max-w-md bg-background min-h-screen shadow-2xl overflow-hidden relative flex flex-col ${className}`}>
        {children}
      </div>
    </div>
  );
}
