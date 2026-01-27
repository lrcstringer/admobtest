import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { ArrowLeft, Search, ShoppingBag, Clock, CheckCircle2, XCircle, Filter, Zap, Smartphone, Copy, Loader2 } from "lucide-react";
import { Link } from "wouter";
import { useState } from "react";
import { motion } from "framer-motion";
import appLogo from "@assets/iMali_Logo_transp_bg_1765285511027.png";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { purchaseApi } from "@/lib/api";

export default function BuyHistory() {
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTx, setSelectedTx] = useState<any | null>(null);
  const { toast } = useToast();

  const { data: purchases, isLoading, error } = useQuery({
    queryKey: ["purchase-history"],
    queryFn: () => purchaseApi.getHistory(100),
  });

  if (error) {
    toast({
      title: "Error loading purchases",
      description: "Failed to load purchase history",
      variant: "destructive",
    });
  }

  const TRANSACTIONS = purchases || [];

  const filteredTransactions = TRANSACTIONS.filter((tx: any) => {
    const matchesSearch = tx.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          tx.details.toLowerCase().includes(searchQuery.toLowerCase());
    
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

    return matchesSearch && matchesDate;
  });

  const getStatusColor = (status: string) => {
    switch (status) {
      case "completed": return "text-green-400";
      case "pending": return "text-yellow-400";
      case "failed": return "text-red-400";
      default: return "text-white";
    }
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case "completed": return <CheckCircle2 size={14} className="text-green-400" />;
      case "pending": return <Clock size={14} className="text-yellow-400" />;
      case "failed": return <XCircle size={14} className="text-red-400" />;
    }
  };

  const getIcon = (type: string) => {
    switch (type) {
      case "electricity": return <Zap size={18} className="text-yellow-500" />;
      case "airtime": return <Smartphone size={18} className="text-blue-400" />;
      case "data": return <Smartphone size={18} className="text-purple-400" />;
      default: return <ShoppingBag size={18} className="text-white" />;
    }
  };

  const copyToken = (token: string) => {
    navigator.clipboard.writeText(token.replace(/\s/g, ""));
    toast({
      title: "Token Copied",
      description: "Electricity token copied to clipboard",
    });
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        {/* Header */}
        <header className="px-6 py-4 bg-background/95 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
          <div className="flex items-center gap-3 mb-4">
            <Link href="/buy">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">Purchase History</h1>
          </div>

          <div className="relative mb-4">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
            <Input 
              placeholder="Search purchases..." 
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
          </div>
        </header>

        {/* List */}
        <div className="flex-1 overflow-y-auto p-6 space-y-4">
          {isLoading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 className="h-8 w-8 animate-spin text-primary" />
            </div>
          ) : filteredTransactions.length > 0 ? (
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
                      {getIcon(tx.purchaseType)}
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
                    <span className="block font-mono font-bold text-white">
                      R {tx.amount.toFixed(2)}
                    </span>
                    <span className="text-[10px] text-muted-foreground uppercase tracking-wider font-medium">
                      {tx.purchaseType}
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
                   {getIcon(selectedTx.purchaseType)}
                </div>
                <h2 className="text-3xl font-mono font-bold mb-1 text-white">
                   - R {selectedTx.amount.toFixed(2)}
                </h2>
                <Badge variant="outline" className={`capitalize border-white/10 ${getStatusColor(selectedTx.status)} bg-transparent`}>
                  {selectedTx.status}
                </Badge>
              </div>

              <div className="space-y-4 bg-white/5 rounded-xl p-4 border border-white/5">
                <div className="flex justify-between items-center py-2 border-b border-white/5">
                  <span className="text-sm text-muted-foreground">Service</span>
                  <span className="text-sm font-medium capitalize">{selectedTx.purchaseType}</span>
                </div>
                <div className="flex justify-between items-center py-2 border-b border-white/5">
                  <span className="text-sm text-muted-foreground">Paid From</span>
                  <span className="text-sm font-medium capitalize flex items-center gap-2">
                    {selectedTx.wallet === "imali" && <img src={appLogo} className="w-4 h-4 object-contain" />}
                    {selectedTx.wallet === "imali" ? "iMaliChat Wallet" : `${selectedTx.wallet} Wallet`}
                  </span>
                </div>
                <div className="flex justify-between items-center py-2 border-b border-white/5">
                   <span className="text-sm text-muted-foreground">Details</span>
                   <span className="text-sm font-medium">{selectedTx.details}</span>
                </div>
                
                {/* Electricity Token Section */}
                {selectedTx.purchaseType === "electricity" && selectedTx.token && (
                   <div className="bg-yellow-500/10 border border-yellow-500/20 rounded-lg p-3 mt-2">
                     <p className="text-[10px] text-yellow-500 uppercase font-bold mb-1">Token Number</p>
                     <div className="flex items-center justify-between">
                       <span className="font-mono font-bold text-white tracking-wider">{selectedTx.token}</span>
                       <Button 
                         variant="ghost" 
                         size="sm" 
                         className="h-6 w-6 p-0 text-yellow-500 hover:text-white hover:bg-yellow-500/20"
                         onClick={() => copyToken(selectedTx.token!)}
                       >
                         <Copy size={12} />
                       </Button>
                     </div>
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