import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { useEffect, useState } from "react";
import { FAKE_API } from "@/lib/fake-api";
import { Loader2, Info } from "lucide-react";

export function HowItWorksModal({ trigger }: { trigger?: React.ReactNode }) {
  const [content, setContent] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    FAKE_API.getHowItWorks().then((data) => {
      setContent(data);
      setLoading(false);
    });
  }, []);

  return (
    <Dialog>
      <DialogTrigger asChild>
        {trigger || (
          <Button variant="link" className="text-primary hover:text-primary/80">
            How it works
          </Button>
        )}
      </DialogTrigger>
      <DialogContent className="max-w-md w-[90%] rounded-xl bg-card border-white/10 text-white p-0 overflow-hidden">
        <DialogHeader className="p-6 pb-2 border-b border-white/5 bg-background/50 backdrop-blur-sm">
          <DialogTitle className="text-xl font-heading font-bold flex items-center gap-2">
            <Info className="text-secondary" size={24} />
            How Earning Works
          </DialogTitle>
        </DialogHeader>
        
        <ScrollArea className="h-[60vh] p-6">
          {loading ? (
            <div className="flex justify-center py-10">
              <Loader2 className="animate-spin text-primary" size={32} />
            </div>
          ) : (
            <div className="space-y-6">
              {content?.sections.map((section: any, index: number) => (
                <div key={index} className="space-y-3">
                  <h3 className="text-lg font-bold text-secondary">{section.title}</h3>
                  <ul className="space-y-2">
                    {section.points.map((point: string, pIndex: number) => (
                      <li key={pIndex} className="text-sm text-muted-foreground flex gap-2">
                        <span className="w-1.5 h-1.5 rounded-full bg-primary/50 mt-1.5 flex-shrink-0" />
                        <span>{point}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>

        <div className="p-4 border-t border-white/5 bg-background/50 backdrop-blur-sm">
          <DialogTrigger asChild>
            <Button className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-12 shadow-md">
              Got it
            </Button>
          </DialogTrigger>
        </div>
      </DialogContent>
    </Dialog>
  );
}
