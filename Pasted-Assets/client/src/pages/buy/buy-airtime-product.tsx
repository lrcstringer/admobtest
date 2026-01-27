import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { ArrowLeft, Wifi, Smartphone, Loader2 } from "lucide-react";
import { Link, useRoute, useLocation } from "wouter";
import { motion } from "framer-motion";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";

const PRODUCTS = {
  airtime: [
    { id: "a1", amount: 5, label: "R 5 Airtime" },
    { id: "a2", amount: 10, label: "R 10 Airtime" },
    { id: "a3", amount: 29, label: "R 29 Airtime" },
    { id: "a4", amount: 55, label: "R 55 Airtime" },
    { id: "a5", amount: 110, label: "R 110 Airtime" },
  ],
  data: [
    { id: "d1", amount: 15, label: "20MB Data", valid: "Daily" },
    { id: "d2", amount: 29, label: "100MB Data", valid: "Daily" },
    { id: "d3", amount: 49, label: "500MB Data", valid: "Weekly" },
    { id: "d4", amount: 99, label: "1GB Data", valid: "Monthly" },
    { id: "d5", amount: 149, label: "2GB Data", valid: "Monthly" },
  ]
};

export default function BuyAirtimeProduct() {
  const [, params] = useRoute("/buy/airtime/product/:walletId/:providerId");
  const [, setLocation] = useLocation();
  const walletId = params?.walletId;
  const providerId = params?.providerId;
  
  const [selectedProduct, setSelectedProduct] = useState<any>(null);
  const [buying, setBuying] = useState(false);
  const { toast } = useToast();

  const handleBuy = async () => {
    if (!selectedProduct) return;
    
    setBuying(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500));
    setBuying(false);
    
    setLocation("/buy/success");
  };

  const getProviderName = (id: string) => {
    const map: Record<string, string> = { vodacom: "Vodacom", mtn: "MTN", cellc: "Cell C", telkom: "Telkom" };
    return map[id] || id;
  };

  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href={`/buy/airtime/provider/${walletId}`}>
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <div>
              <h1 className="text-xl font-heading font-bold text-white">{getProviderName(providerId || "")}</h1>
              <p className="text-xs text-muted-foreground">Select a product bundle</p>
            </div>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto px-6 py-4">
          <Tabs defaultValue="airtime" className="w-full">
            <TabsList className="w-full bg-white/5 p-1 rounded-xl mb-6 border border-white/5">
              <TabsTrigger 
                value="airtime" 
                className="flex-1 font-bold data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg transition-all"
              >
                <Smartphone size={16} className="mr-2" />
                Airtime
              </TabsTrigger>
              <TabsTrigger 
                value="data" 
                className="flex-1 font-bold data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg transition-all"
              >
                <Wifi size={16} className="mr-2" />
                Data
              </TabsTrigger>
            </TabsList>

            <TabsContent value="airtime" className="mt-0 space-y-3">
              {PRODUCTS.airtime.map((prod) => (
                <motion.div
                  key={prod.id}
                  whileTap={{ scale: 0.98 }}
                  onClick={() => setSelectedProduct(prod)}
                  className={`p-4 rounded-xl border cursor-pointer transition-all flex items-center justify-between ${
                    selectedProduct?.id === prod.id 
                      ? "bg-primary/20 border-primary" 
                      : "bg-white/5 border-white/10 hover:bg-white/10"
                  }`}
                >
                  <span className="font-bold text-white">{prod.label}</span>
                  <span className="text-sm font-bold text-secondary">R {prod.amount.toFixed(2)}</span>
                </motion.div>
              ))}
            </TabsContent>

            <TabsContent value="data" className="mt-0 space-y-3">
              {PRODUCTS.data.map((prod) => (
                <motion.div
                  key={prod.id}
                  whileTap={{ scale: 0.98 }}
                  onClick={() => setSelectedProduct(prod)}
                  className={`p-4 rounded-xl border cursor-pointer transition-all flex items-center justify-between ${
                    selectedProduct?.id === prod.id 
                      ? "bg-primary/20 border-primary" 
                      : "bg-white/5 border-white/10 hover:bg-white/10"
                  }`}
                >
                  <div>
                    <span className="font-bold text-white block">{prod.label}</span>
                    <span className="text-xs text-muted-foreground uppercase">{prod.valid}</span>
                  </div>
                  <span className="text-sm font-bold text-secondary">R {prod.amount.toFixed(2)}</span>
                </motion.div>
              ))}
            </TabsContent>
          </Tabs>
        </div>

        {/* Footer */}
        <div className="p-6 border-t border-white/10 bg-background/95 backdrop-blur-md sticky bottom-0 z-20">
          <Button 
            className="w-full h-12 text-lg font-bold bg-primary hover:bg-primary/90 text-white shadow-lg"
            disabled={!selectedProduct || buying}
            onClick={handleBuy}
          >
            {buying ? <Loader2 className="animate-spin" /> : selectedProduct ? `Pay R${selectedProduct.amount}` : "Select a Product"}
          </Button>
        </div>
      </div>
    </MobileFrame>
  );
}