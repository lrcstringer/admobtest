import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { ScrollArea } from "@/components/ui/scroll-area";
import { ArrowLeft, Search, ArrowUpRight, ArrowDownLeft, ShoppingBag, Clock, CheckCircle2, XCircle, ChevronRight, Filter } from "lucide-react";
import { Link } from "wouter";
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";

// Types
type TransactionStatus = "completed" | "pending" | "failed";
type TransactionType = "earned" | "sent" | "received" | "purchase";
type WalletType = "imali" | "nike" | "checkers";

interface Transaction {
  id: string;
  type: TransactionType;
  wallet: WalletType;
  title: string;
  counterpart?: string; // Name or phone number
  amount: number;
  currency: "ZAR" | "TOKENS";
  date: string;
  status: TransactionStatus;
  icon?: any;
}

// Mock Data
const TRANSACTIONS: Transaction[] = [
  {
    id: "tx-1",
    type: "received",
    wallet: "imali",
    title: "Received from Sarah",
    counterpart: "Sarah J.",
    amount: 50.00,
    currency: "ZAR",
    date: "2024-03-10T14:30:00",
    status: "completed"
  },
  {
    id: "tx-2",
    type: "earned",
    wallet: "imali",
    title: "Daily Pot Reward",
    amount: 120,
    currency: "TOKENS",
    date: "2024-03-09T18:00:00",
    status: "completed"
  },
  {
    id: "tx-3",
    type: "purchase",
    wallet: "nike",
    title: "Nike Store Purchase",
    counterpart: "Nike Canal Walk",
    amount: 850.00,
    currency: "ZAR",
    date: "2024-03-08T11:15:00",
    status: "completed"
  },
  {
    id: "tx-4",
    type: "sent",
    wallet: "imali",
    title: "Sent to Thabo",
    counterpart: "Thabo M.",
    amount: 200.00,
    currency: "ZAR",
    date: "2024-03-07T09:45:00",
    status: "pending"
  },
  {
    id: "tx-5",
    type: "earned",
    wallet: "checkers",
    title: "Brand Survey Reward",
    amount: 50,
    currency: "TOKENS",
    date: "2024-03-06T15:20:00",
    status: "completed"
  },
  {
    id: "tx-6",
    type: "sent",
    wallet: "imali",
    title: "Airtime Purchase",
    counterpart: "Vodacom",
    amount: 29.00,
    currency: "ZAR",
    date: "2024-03-05T10:00:00",
    status: "failed"
  },
  {
    id: "tx-7",
    type: "received",
    wallet: "imali",
    title: "Received from Mike",
    counterpart: "Mike D.",
    amount: 150.00,
    currency: "ZAR",
    date: "2024-03-04T16:45:00",
    status: "completed"
  }
];

export default function TransactionHistory() {
  const [selectedCategory, setSelectedCategory] = useState<TransactionType | "all">("all");
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTx, setSelectedTx] = useState<Transaction | null>(null);

  const filteredTransactions = TRANSACTIONS.filter(tx => {
    const matchesCategory = selectedCategory === "all" || tx.type === selectedCategory;
    const matchesSearch = tx.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          tx.counterpart?.toLowerCase().includes(searchQuery.toLowerCase());
    
    let matchesDate = true;
    const txDate = new Date(tx.date);
    
    if (fromDate) {
      matchesDate = matchesDate && txDate >= new Date(fromDate);
    }
    
    if (toDate) {
      // Add one day to include the end date fully
      const endDate = new Date(toDate);
      endDate.setHours(23, 59, 59, 999);
      matchesDate = matchesDate && txDate <= endDate;
    }

    return matchesCategory && matchesSearch && matchesDate;
  });

  const getStatusColor = (status: TransactionStatus) => {
    switch (status) {
      case "completed": return "text-green-400";
      case "pending": return "text-yellow-400";
      case "failed": return "text-red-400";
      default: return "text-white";
    }
  };

  const getStatusIcon = (status: TransactionStatus) => {
    switch (status) {
      case "completed": return <CheckCircle2 size={14} className="text-green-400" />;
      case "pending": return <Clock size={14} className="text-yellow-400" />;
      case "failed": return <XCircle size={14} className="text-red-400" />;
    }
  };

  const getTypeIcon = (type: TransactionType) => {
    switch (type) {
      case "earned": return <ArrowDownLeft size={18} className="text-green-400" />;
      case "received": return <ArrowDownLeft size={18} className="text-green-400" />;
      case "sent": return <ArrowUpRight size={18} className="text-white" />;
      case "purchase": return <ShoppingBag size={18} className="text-blue-400" />;
    }
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        {/* Header */}
        <header className="px-6 py-4 bg-background/95 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
          <div className="flex items-center gap-3 mb-4">
            <Link href="/wallets">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">Transaction History</h1>
          </div>

          <div className="relative mb-4">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
            <Input 
              placeholder="Search transactions..." 
              className="pl-9 bg-white/5 border-white/10 text-white placeholder:text-muted-foreground focus-visible:ring-primary h-10 rounded-xl"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>

          {/* Filters */}
          <div className="space-y-3">
            {/* Date Filter */}
            <div className="flex gap-2 items-center">
              <div className="flex-1">
                <label className="text-[10px] text-muted-foreground uppercase font-bold ml-1 mb-1 block">From</label>
                <Input 
                  type="date"
                  className="bg-white/5 border-white/10 text-white h-9 text-xs"
                  value={fromDate}
                  onChange={(e) => setFromDate(e.target.value)}
                />
              </div>
              <div className="flex-1">
                <label className="text-[10px] text-muted-foreground uppercase font-bold ml-1 mb-1 block">To</label>
                <Input 
                  type="date"
                  className="bg-white/5 border-white/10 text-white h-9 text-xs"
                  value={toDate}
                  onChange={(e) => setToDate(e.target.value)}
                />
              </div>
            </div>

            {/* Category Filter */}
            <div className="flex gap-2 overflow-x-auto no-scrollbar pb-1">
               <Badge 
                variant={selectedCategory === "all" ? "secondary" : "outline"} 
                className={`cursor-pointer px-3 h-7 ${selectedCategory === "all" ? "bg-white/10 text-white hover:bg-white/20" : "text-muted-foreground border-transparent hover:text-white"}`}
                onClick={() => setSelectedCategory("all")}
              >
                All
              </Badge>
              <Badge 
                variant={selectedCategory === "earned" ? "secondary" : "outline"} 
                className={`cursor-pointer px-3 h-7 ${selectedCategory === "earned" ? "bg-green-500/20 text-green-400 hover:bg-green-500/30" : "text-muted-foreground border-transparent hover:text-white"}`}
                onClick={() => setSelectedCategory("earned")}
              >
                Earned
              </Badge>
              <Badge 
                variant={selectedCategory === "sent" ? "secondary" : "outline"} 
                className={`cursor-pointer px-3 h-7 ${selectedCategory === "sent" ? "bg-orange-500/20 text-orange-400 hover:bg-orange-500/30" : "text-muted-foreground border-transparent hover:text-white"}`}
                onClick={() => setSelectedCategory("sent")}
              >
                Sent
              </Badge>
               <Badge 
                variant={selectedCategory === "received" ? "secondary" : "outline"} 
                className={`cursor-pointer px-3 h-7 ${selectedCategory === "received" ? "bg-blue-500/20 text-blue-400 hover:bg-blue-500/30" : "text-muted-foreground border-transparent hover:text-white"}`}
                onClick={() => setSelectedCategory("received")}
              >
                Received
              </Badge>
            </div>
          </div>
        </header>

        {/* List */}
        <div className="flex-1 overflow-y-auto p-6 space-y-4">
          {filteredTransactions.length > 0 ? (
            filteredTransactions.map((tx, index) => (
              <motion.div
                key={tx.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
                onClick={() => setSelectedTx(tx)}
                className="group cursor-pointer"
              >
                <div className="flex items-center justify-between p-4 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 hover:border-white/10 transition-all">
                  <div className="flex items-center gap-4">
                    <div className={`w-10 h-10 rounded-full flex items-center justify-center bg-black/20 border border-white/5`}>
                      {getTypeIcon(tx.type)}
                    </div>
                    <div>
                      <h3 className="text-sm font-bold text-white">{tx.title}</h3>
                      <div className="flex items-center gap-2 mt-0.5">
                        <span className="text-xs text-muted-foreground">{new Date(tx.date).toLocaleDateString()}</span>
                        <span className="text-[10px] text-white/20">•</span>
                         <div className="flex items-center gap-1">
                          {getStatusIcon(tx.status)}
                          <span className={`text-[10px] capitalize ${getStatusColor(tx.status)}`}>{tx.status}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className={`block font-mono font-bold ${tx.type === "sent" || tx.type === "purchase" ? "text-white" : "text-green-400"}`}>
                      {tx.type === "sent" || tx.type === "purchase" ? "-" : "+"}
                      {tx.currency === "ZAR" ? "R" : ""} {tx.amount.toFixed(2)}
                      {tx.currency === "TOKENS" ? " T" : ""}
                    </span>
                    <span className="text-[10px] text-muted-foreground uppercase tracking-wider font-medium">
                      {tx.wallet === "imali" ? "iMali" : tx.wallet}
                    </span>
                  </div>
                </div>
              </motion.div>
            ))
          ) : (
            <div className="flex flex-col items-center justify-center py-12 text-center text-muted-foreground">
              <Filter size={48} className="mb-4 opacity-20" />
              <p>No transactions found</p>
            </div>
          )}
        </div>
      </div>

      {/* Detail Dialog */}
      <Dialog open={!!selectedTx} onOpenChange={(open) => !open && setSelectedTx(null)}>
        <DialogContent className="bg-card border-white/10 text-white w-[90%] rounded-3xl p-6">
          {selectedTx && (
            <>
              <DialogHeader className="mb-4">
                <DialogTitle className="text-center text-lg font-bold">Transaction Details</DialogTitle>
                <DialogDescription className="text-center text-muted-foreground">
                  {new Date(selectedTx.date).toLocaleString()}
                </DialogDescription>
              </DialogHeader>
              
              <div className="flex flex-col items-center justify-center mb-8">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center mb-4 border border-white/10">
                   {getTypeIcon(selectedTx.type)}
                </div>
                <h2 className={`text-3xl font-mono font-bold mb-1 ${selectedTx.type === "sent" || selectedTx.type === "purchase" ? "text-white" : "text-green-400"}`}>
                   {selectedTx.type === "sent" || selectedTx.type === "purchase" ? "-" : "+"}
                   {selectedTx.currency === "ZAR" ? "R" : ""} {selectedTx.amount.toFixed(2)}
                   {selectedTx.currency === "TOKENS" ? " T" : ""}
                </h2>
                <Badge variant="outline" className={`capitalize border-white/10 ${getStatusColor(selectedTx.status)} bg-transparent`}>
                  {selectedTx.status}
                </Badge>
              </div>

              <div className="space-y-4 bg-white/5 rounded-xl p-4 border border-white/5">
                <div className="flex justify-between items-center py-2 border-b border-white/5">
                  <span className="text-sm text-muted-foreground">Type</span>
                  <span className="text-sm font-medium capitalize">{selectedTx.type}</span>
                </div>
                <div className="flex justify-between items-center py-2 border-b border-white/5">
                  <span className="text-sm text-muted-foreground">Wallet</span>
                  <span className="text-sm font-medium capitalize flex items-center gap-2">
                    {selectedTx.wallet === "imali" && <img src={appLogo} className="w-4 h-4 object-contain" />}
                    {selectedTx.wallet === "imali" ? "iMaliChat Wallet" : `${selectedTx.wallet} Wallet`}
                  </span>
                </div>
                {selectedTx.counterpart && (
                  <div className="flex justify-between items-center py-2 border-b border-white/5">
                    <span className="text-sm text-muted-foreground">Counterpart</span>
                    <span className="text-sm font-medium">{selectedTx.counterpart}</span>
                  </div>
                )}
                 <div className="flex justify-between items-center py-2">
                  <span className="text-sm text-muted-foreground">Transaction ID</span>
                  <span className="text-xs font-mono text-muted-foreground">{selectedTx.id}</span>
                </div>
              </div>

              <div className="flex gap-3 mt-6">
                <Button variant="outline" className="flex-1 border-white/10 hover:bg-white/5 text-white" onClick={() => setSelectedTx(null)}>
                  Close
                </Button>
                <Button className="flex-1 bg-white text-black hover:bg-white/90">
                  Report Issue
                </Button>
              </div>
            </>
          )}
        </DialogContent>
      </Dialog>
    </MobileFrame>
  );
}