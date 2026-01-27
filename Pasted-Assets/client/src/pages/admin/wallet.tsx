import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import {
  Wallet,
  Plus,
  Loader2,
  CheckCircle,
  Clock,
  XCircle,
  Copy,
  CreditCard,
} from "lucide-react";
import { format, formatDistanceToNow } from "date-fns";
import { useToast } from "@/hooks/use-toast";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useState, ReactNode } from "react";

const statusIcons: Record<string, ReactNode> = {
  pending: <Clock size={16} className="text-yellow-500" />,
  cleared: <CheckCircle size={16} className="text-green-500" />,
  rejected: <XCircle size={16} className="text-red-500" />,
};

export default function WalletPage() {
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [topUpAmount, setTopUpAmount] = useState("");
  const [topUpReference, setTopUpReference] = useState("");
  const [showTopUpDialog, setShowTopUpDialog] = useState(false);

  const { data: adminProfile } = useQuery({
    queryKey: ["/api/admin/auth/me"],
    queryFn: adminApi.getMe,
  });

  const currentOrg = adminProfile?.organizations?.[0];

  const { data: wallet, isLoading } = useQuery({
    queryKey: ["/api/admin/wallet", currentOrg?.id],
    queryFn: () => adminApi.getWallet(String(currentOrg!.id)),
    enabled: !!currentOrg?.id,
  });

  const topUpMutation = useMutation({
    mutationFn: (data: { amount: number; reference?: string }) =>
      adminApi.requestTopUp(String(currentOrg!.id), { amount: data.amount, reference: data.reference }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/wallet"] });
      toast({ title: "Top-up requested", description: "Your EFT top-up has been submitted for verification" });
      setShowTopUpDialog(false);
      setTopUpAmount("");
      setTopUpReference("");
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const handleTopUp = () => {
    if (!topUpAmount || parseFloat(topUpAmount) < 100) {
      toast({ title: "Error", description: "Minimum top-up amount is R100", variant: "destructive" });
      return;
    }
    topUpMutation.mutate({ amount: parseFloat(topUpAmount), reference: topUpReference || undefined });
  };

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
    toast({ title: "Copied!", description: "Text copied to clipboard" });
  };

  const bankDetails = {
    bankName: "First National Bank",
    accountNumber: "62123456789",
    branchCode: "250655",
    accountName: "iMaliChat Advertising (Pty) Ltd",
    reference: currentOrg?.id ? `IMALI-${currentOrg.id}` : "IMALI-XXX",
  };

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-slate-900">Wallet</h1>
            <p className="text-slate-500">Manage your advertising budget</p>
          </div>
          <Dialog open={showTopUpDialog} onOpenChange={setShowTopUpDialog}>
            <DialogTrigger asChild>
              <Button className="bg-pink-600 hover:bg-pink-700" data-testid="button-add-funds">
                <Plus size={16} className="mr-2" />
                Add Funds
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-md">
              <DialogHeader>
                <DialogTitle>Add Funds via EFT</DialogTitle>
                <DialogDescription>
                  Transfer funds to our bank account and submit your payment details for verification
                </DialogDescription>
              </DialogHeader>
              
              <div className="space-y-4">
                <div className="bg-slate-50 rounded-lg p-4 space-y-3">
                  <p className="font-medium text-sm text-slate-700">Bank Details</p>
                  <div className="grid grid-cols-2 gap-2 text-sm">
                    <p className="text-slate-500">Bank:</p>
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-slate-900">{bankDetails.bankName}</p>
                      <Button variant="ghost" size="icon" className="h-6 w-6 text-slate-600 hover:text-slate-900" onClick={() => copyToClipboard(bankDetails.bankName)}>
                        <Copy size={12} />
                      </Button>
                    </div>
                    <p className="text-slate-500">Account No:</p>
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-slate-900">{bankDetails.accountNumber}</p>
                      <Button variant="ghost" size="icon" className="h-6 w-6 text-slate-600 hover:text-slate-900" onClick={() => copyToClipboard(bankDetails.accountNumber)}>
                        <Copy size={12} />
                      </Button>
                    </div>
                    <p className="text-slate-500">Branch Code:</p>
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-slate-900">{bankDetails.branchCode}</p>
                      <Button variant="ghost" size="icon" className="h-6 w-6 text-slate-600 hover:text-slate-900" onClick={() => copyToClipboard(bankDetails.branchCode)}>
                        <Copy size={12} />
                      </Button>
                    </div>
                    <p className="text-slate-500">Account Name:</p>
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-xs text-slate-900">{bankDetails.accountName}</p>
                    </div>
                    <p className="text-slate-500">Reference:</p>
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-pink-600">{bankDetails.reference}</p>
                      <Button variant="ghost" size="icon" className="h-6 w-6 text-slate-600 hover:text-slate-900" onClick={() => copyToClipboard(bankDetails.reference)}>
                        <Copy size={12} />
                      </Button>
                    </div>
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="amount">Amount (ZAR)</Label>
                  <div className="flex items-center gap-2">
                    <span className="text-slate-500">R</span>
                    <Input
                      id="amount"
                      type="number"
                      min="100"
                      step="100"
                      placeholder="1000"
                      value={topUpAmount}
                      onChange={(e) => setTopUpAmount(e.target.value)}
                      data-testid="input-topup-amount"
                    />
                  </div>
                  <p className="text-xs text-slate-500">Minimum R100</p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="reference">Your Payment Reference (optional)</Label>
                  <Input
                    id="reference"
                    placeholder="e.g., FNB-12345"
                    value={topUpReference}
                    onChange={(e) => setTopUpReference(e.target.value)}
                    data-testid="input-topup-reference"
                  />
                </div>
              </div>

              <DialogFooter>
                <Button variant="outline" onClick={() => setShowTopUpDialog(false)}>
                  Cancel
                </Button>
                <Button
                  onClick={handleTopUp}
                  disabled={topUpMutation.isPending || !topUpAmount}
                  className="bg-pink-600 hover:bg-pink-700"
                  data-testid="button-submit-topup"
                >
                  {topUpMutation.isPending && <Loader2 className="animate-spin mr-2" size={16} />}
                  Submit for Verification
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <Card className="col-span-1 md:col-span-2">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Wallet size={20} />
                Available Balance
              </CardTitle>
            </CardHeader>
            <CardContent>
              {isLoading ? (
                <Loader2 className="animate-spin" size={32} />
              ) : (
                <div className="space-y-4">
                  <p className="text-4xl font-bold text-slate-900" data-testid="text-wallet-balance">
                    R {parseFloat(wallet?.balance || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                  </p>
                  <div className="flex gap-6">
                    <div>
                      <p className="text-sm text-slate-500">Total Spent</p>
                      <p className="text-lg font-semibold">
                        R {parseFloat(wallet?.totalSpent || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                      </p>
                    </div>
                    <div>
                      <p className="text-sm text-slate-500">Total Funded</p>
                      <p className="text-lg font-semibold">
                        R {parseFloat(wallet?.totalFunded || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                      </p>
                    </div>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <CreditCard size={20} />
                Quick Stats
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-slate-500">Pending Top-ups</span>
                  <span className="font-medium">
                    {wallet?.topUps?.filter((t: any) => t.status === "pending").length || 0}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-slate-500">Total Top-ups</span>
                  <span className="font-medium">{wallet?.topUps?.length || 0}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Transaction History</CardTitle>
            <CardDescription>Your top-up requests and their status</CardDescription>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="flex justify-center py-8">
                <Loader2 className="animate-spin" size={24} />
              </div>
            ) : wallet?.topUps?.length === 0 ? (
              <div className="text-center py-8">
                <Wallet size={48} className="mx-auto text-slate-300 mb-4" />
                <p className="text-slate-500">No transactions yet</p>
                <p className="text-sm text-slate-400">Add funds to start advertising</p>
              </div>
            ) : (
              <div className="space-y-3">
                {wallet?.topUps?.map((topUp: any) => (
                  <div
                    key={topUp.id}
                    className="flex items-center justify-between p-4 rounded-lg border border-slate-100"
                  >
                    <div className="flex items-center gap-3">
                      {statusIcons[topUp.status] || statusIcons.pending}
                      <div>
                        <p className="font-medium text-slate-900">
                          + R {parseFloat(topUp.amount).toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                        </p>
                        <p className="text-xs text-slate-500">
                          {format(new Date(topUp.createdAt), "MMM d, yyyy HH:mm")} •{" "}
                          {formatDistanceToNow(new Date(topUp.createdAt), { addSuffix: true })}
                        </p>
                      </div>
                    </div>
                    <div className="text-right">
                      <span
                        className={`text-xs px-2 py-1 rounded-full capitalize ${
                          topUp.status === "cleared"
                            ? "bg-green-100 text-green-700"
                            : topUp.status === "pending"
                            ? "bg-yellow-100 text-yellow-700"
                            : "bg-red-100 text-red-700"
                        }`}
                      >
                        {topUp.status}
                      </span>
                      {topUp.reference && (
                        <p className="text-xs text-slate-400 mt-1">Ref: {topUp.reference}</p>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </AdminLayout>
  );
}
