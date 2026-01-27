import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ChatAPI } from "@/lib/fake-api-chat";
import { Contact } from "@/types/money-chat";
import { useToast } from "@/hooks/use-toast";
import { ArrowLeft, Loader2 } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useLocation, useRoute } from "wouter";

export default function ChatRequest() {
  const [, params] = useRoute("/chat/request/:contactId");
  const [, setLocation] = useLocation();
  const contactId = params?.contactId;
  
  const [contact, setContact] = useState<Contact | null>(null);
  const [amount, setAmount] = useState("");
  const [note, setNote] = useState("");
  const [loading, setLoading] = useState(true);
  const [sending, setSending] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    if (contactId) {
      loadContact();
    }
  }, [contactId]);

  const loadContact = async () => {
    setLoading(true);
    const contacts = await ChatAPI.getContacts();
    const c = contacts.find(c => c.id === contactId);
    setContact(c || null);
    setLoading(false);
  };

  const handleRequest = async () => {
    if (!amount || isNaN(Number(amount))) return;
    
    setSending(true);
    await ChatAPI.requestMoney(contactId!, Number(amount), note);
    setSending(false);
    
    toast({
      title: "Request Sent",
      description: `Requested R${amount} from ${contact?.name}`,
      duration: 2000,
    });
    
    setLocation(`/chat/${contactId}`);
  };

  if (loading) return <div className="h-full bg-background" />;

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      <header className="px-4 py-4 flex items-center gap-3 relative z-10">
        <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full" onClick={() => history.back()}>
          <ArrowLeft size={20} />
        </Button>
        <h1 className="text-lg font-bold text-white">Request Money</h1>
      </header>

      <div className="flex-1 px-6 flex flex-col items-center pt-8">
        <Avatar className="h-20 w-20 border-2 border-white/10 mb-4">
          <AvatarFallback className="bg-white/10 text-white text-2xl font-bold">
            {contact?.initials}
          </AvatarFallback>
        </Avatar>
        
        <p className="text-muted-foreground mb-1">Requesting from</p>
        <h2 className="text-2xl font-bold text-white mb-8">{contact?.name}</h2>

        <div className="w-full max-w-xs relative mb-8">
          <span className="absolute left-0 top-1/2 -translate-y-1/2 text-4xl font-bold text-white/50">R</span>
          <Input 
            type="number" 
            autoFocus
            className="text-center text-5xl font-bold bg-transparent border-none text-white focus-visible:ring-0 px-8 h-20 placeholder:text-white/20"
            placeholder="0"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
        </div>

        <Input 
          className="bg-white/5 border-white/10 text-white placeholder:text-muted-foreground mb-4"
          placeholder="What's this for? (optional)"
          value={note}
          onChange={(e) => setNote(e.target.value)}
        />

        <Button 
          variant="outline"
          className="w-full h-14 text-lg font-bold border-white/20 text-white hover:bg-white/10 mt-auto mb-8"
          disabled={!amount || sending}
          onClick={handleRequest}
        >
          {sending ? <Loader2 className="animate-spin" /> : "Send Request"}
        </Button>
      </div>
    </MobileFrame>
  );
}
