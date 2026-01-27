import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ChatAPI } from "@/lib/fake-api-chat";
import { Contact, MoneyChatEntry, MoneyChatThread } from "@/types/money-chat";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";
import { ArrowLeft, Send, ArrowDownLeft, ArrowUpRight, Check, Clock, XCircle, Info, MoreVertical, Ban, Flag } from "lucide-react";
import { useEffect, useState, useRef } from "react";
import { Link, useRoute, useLocation } from "wouter";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export default function ChatThread() {
  const [, params] = useRoute("/chat/:contactId");
  const [, setLocation] = useLocation();
  const contactId = params?.contactId;
  
  const [loading, setLoading] = useState(true);
  const [thread, setThread] = useState<MoneyChatThread | null>(null);
  const [contact, setContact] = useState<Contact | null>(null);
  const [entries, setEntries] = useState<MoneyChatEntry[]>([]);
  const scrollRef = useRef<HTMLDivElement>(null);
  const { toast } = useToast();

  useEffect(() => {
    if (contactId) {
      loadThread();
    }
  }, [contactId]);

  useEffect(() => {
    // Scroll to bottom when entries change
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [entries]);

  const loadThread = async () => {
    setLoading(true);
    const data = await ChatAPI.getThread(contactId!);
    setThread(data.thread);
    setEntries(data.entries);
    setContact(data.contact || null);
    setLoading(false);
  };

  const handleInvite = async () => {
    if (contact) {
      toast({ title: "Invite Sent", description: `Invitation sent to ${contact.name}` });
      await ChatAPI.sendInvite(contact.id);
    }
  };

  const handleReport = () => {
    toast({
      title: "User Reported",
      description: "We've received your report and will review this user's activity.",
      variant: "destructive",
    });
  };

  const handleBlock = async () => {
    if (contact?.blocked) {
      await ChatAPI.unblockContact(contact.id);
      setContact({ ...contact, blocked: false });
      toast({
        title: "User Unblocked",
        description: "You can now receive messages from this user again.",
      });
    } else {
      await ChatAPI.blockContact(contact!.id);
      setContact({ ...contact!, blocked: true });
      toast({
        title: "User Blocked",
        description: "You will no longer receive messages or requests from this user.",
        variant: "destructive",
      });
      // Navigate back to chat list after a short delay
      setTimeout(() => {
        setLocation("/chat");
      }, 1500);
    }
  };

  if (loading) {
    return <div className="h-full bg-background flex items-center justify-center text-white">Loading...</div>;
  }

  if (!contact) {
    return <div className="h-full bg-background flex items-center justify-center text-white">Contact not found</div>;
  }

  return (
    <MobileFrame className="bg-background flex flex-col h-screen">
      {/* Header */}
      <header className="px-4 py-4 flex items-center gap-3 bg-card/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
        <Link href="/chat">
          <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full">
            <ArrowLeft size={20} />
          </Button>
        </Link>
        
        <Avatar className="h-10 w-10 border border-white/10">
          <AvatarFallback className="bg-primary/20 text-primary font-bold">
            {contact.initials}
          </AvatarFallback>
        </Avatar>
        
        <div className="flex-1">
          <h1 className="text-base font-bold text-white leading-tight">{contact.name}</h1>
          <div className="flex items-center gap-1.5 text-xs">
            {contact.blocked ? (
               <span className="text-red-400 font-medium">Blocked</span>
            ) : contact.isOnImaliChat ? (
              <span className="text-secondary font-medium">On iMaliChat</span>
            ) : (
              <span className="text-muted-foreground">Invite pending</span>
            )}
          </div>
        </div>

        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full">
              <MoreVertical size={20} />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-48 bg-card border-white/10 text-white">
            <DropdownMenuItem onClick={handleReport} className="text-red-400 focus:text-red-400 focus:bg-red-400/10 cursor-pointer">
              <Flag className="mr-2 h-4 w-4" />
              <span>Report User</span>
            </DropdownMenuItem>
            <DropdownMenuItem onClick={handleBlock} className={`${contact.blocked ? "text-white focus:text-white" : "text-red-400 focus:text-red-400"} focus:bg-white/10 cursor-pointer`}>
              <Ban className="mr-2 h-4 w-4" />
              <span>{contact.blocked ? "Unblock User" : "Block User"}</span>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </header>

      {/* Chat Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-6 pb-24" ref={scrollRef}>
        {contact.blocked && (
          <div className="flex justify-center mb-4">
            <div className="bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-2 rounded-full text-xs font-bold flex items-center gap-2">
              <Ban size={14} />
              You blocked this user
            </div>
          </div>
        )}
        {!contact.isOnImaliChat && (
          <div className="bg-white/5 border border-white/10 rounded-xl p-4 mb-6 text-center">
            <Info className="mx-auto text-secondary mb-2" size={24} />
            <p className="text-sm text-white font-medium mb-1">{contact.name} isn’t on iMaliChat yet.</p>
            <p className="text-xs text-muted-foreground mb-3">Invite them to start sending and receiving value.</p>
            <Button size="sm" variant="outline" className="border-secondary/50 text-secondary hover:bg-secondary/10" onClick={handleInvite}>
              Invite {contact.name}
            </Button>
          </div>
        )}

        {entries.map((entry, index) => {
          const isSent = entry.direction === "sent" || entry.direction === "request_out";
          const isRequest = entry.direction === "request_out" || entry.direction === "request_in";
          
          return (
            <motion.div
              key={entry.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.05 }}
              className={`flex ${isSent ? 'justify-end' : 'justify-start'}`}
            >
              <div 
                className={`
                  max-w-[80%] rounded-2xl p-4 border relative
                  ${isSent 
                    ? "bg-primary text-white border-primary/50 rounded-tr-sm" 
                    : "bg-card text-white border-white/10 rounded-tl-sm"}
                `}
              >
                <div className="flex flex-col gap-1">
                  <div className="flex items-baseline gap-1">
                    <span className="text-2xl font-bold">
                      {isRequest ? "Requesting" : ""} R{entry.amount}
                    </span>
                  </div>
                  
                  {entry.note && (
                    <p className={`text-sm ${isSent ? "text-white/90" : "text-muted-foreground"}`}>
                      {entry.note}
                    </p>
                  )}

                  <div className={`flex items-center gap-1.5 mt-2 text-[10px] font-bold uppercase tracking-wider ${isSent ? "text-white/70" : "text-white/50"}`}>
                    {entry.status === "completed" && <Check size={12} />}
                    {entry.status === "pending" && <Clock size={12} />}
                    {entry.status === "declined" && <XCircle size={12} />}
                    {entry.status}
                  </div>
                </div>
              </div>
            </motion.div>
          );
        })}
      </div>

      {/* Footer Actions */}
      <div className="p-4 bg-background border-t border-white/5 pb-8">
        <div className="grid grid-cols-2 gap-3">
          <Link href={`/chat/request/${contact.id}`}>
            <Button variant="outline" className="w-full border-white/10 hover:bg-white/5 text-white font-bold h-12">
              <ArrowDownLeft className="mr-2" size={18} />
              Request
            </Button>
          </Link>
          <Link href={`/chat/send/${contact.id}`}>
            <Button className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-12 shadow-[0_0_15px_rgba(255,51,138,0.3)]">
              <ArrowUpRight className="mr-2" size={18} />
              Send
            </Button>
          </Link>
        </div>
      </div>
    </MobileFrame>
  );
}
