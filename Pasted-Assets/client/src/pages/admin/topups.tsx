import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import {
  Check,
  X,
  Loader2,
  Wallet,
  Building,
  FileText,
  ExternalLink,
  AlertCircle,
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
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

const statusColors: Record<string, { bg: string; text: string }> = {
  pending: { bg: "bg-yellow-100", text: "text-yellow-700" },
  cleared: { bg: "bg-green-100", text: "text-green-700" },
  rejected: { bg: "bg-red-100", text: "text-red-700" },
};

export default function TopUpsPage() {
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [statusFilter, setStatusFilter] = useState<"pending" | "cleared" | "rejected">("pending");
  const [selectedTopUp, setSelectedTopUp] = useState<any>(null);
  const [rejectionReason, setRejectionReason] = useState("");
  const [showRejectDialog, setShowRejectDialog] = useState(false);

  const { data: topUps, isLoading } = useQuery({
    queryKey: ["/api/admin/super/topups", statusFilter],
    queryFn: () => adminApi.superAdmin.getTopUps(statusFilter),
  });

  const approveMutation = useMutation({
    mutationFn: (topUpId: string) => adminApi.superAdmin.approveTopUp(topUpId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/super/topups"] });
      toast({ title: "Top-up approved", description: "The funds have been added to the advertiser's wallet" });
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const rejectMutation = useMutation({
    mutationFn: ({ topUpId, reason }: { topUpId: string; reason: string }) =>
      adminApi.superAdmin.rejectTopUp(topUpId, reason),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/super/topups"] });
      toast({ title: "Top-up rejected", description: "The advertiser has been notified" });
      setShowRejectDialog(false);
      setRejectionReason("");
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const handleApprove = (topUp: any) => {
    approveMutation.mutate(String(topUp.id));
  };

  const handleReject = () => {
    if (selectedTopUp) {
      rejectMutation.mutate({ topUpId: String(selectedTopUp.id), reason: rejectionReason });
    }
  };

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Top-up Approvals</h1>
          <p className="text-slate-500">Verify EFT payments and credit advertiser wallets</p>
        </div>

        <Tabs value={statusFilter} onValueChange={(v) => setStatusFilter(v as typeof statusFilter)}>
          <TabsList>
            <TabsTrigger value="pending" data-testid="tab-pending">Pending</TabsTrigger>
            <TabsTrigger value="cleared" data-testid="tab-cleared">Approved</TabsTrigger>
            <TabsTrigger value="rejected" data-testid="tab-rejected">Rejected</TabsTrigger>
          </TabsList>

          <TabsContent value={statusFilter} className="mt-6">
            {isLoading ? (
              <div className="flex justify-center py-12">
                <Loader2 className="animate-spin" size={32} />
              </div>
            ) : topUps?.length === 0 ? (
              <Card>
                <CardContent className="flex flex-col items-center justify-center py-12">
                  <Wallet size={48} className="text-slate-300 mb-4" />
                  <h3 className="text-lg font-medium text-slate-900 mb-2">No {statusFilter} top-ups</h3>
                  <p className="text-slate-500">
                    {statusFilter === "pending"
                      ? "All EFT payments have been verified"
                      : `No ${statusFilter} top-ups found`}
                  </p>
                </CardContent>
              </Card>
            ) : (
              <div className="space-y-4">
                {topUps?.map((topUp: any) => {
                  const colors = statusColors[topUp.status] || statusColors.pending;
                  return (
                    <Card key={topUp.id}>
                      <CardContent className="p-6">
                        <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4">
                          <div className="flex-1 space-y-3">
                            <div className="flex items-center gap-3">
                              <p className="text-2xl font-bold text-slate-900">
                                R {parseFloat(topUp.amount).toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                              </p>
                              <span className={`text-xs px-2 py-1 rounded-full capitalize ${colors.bg} ${colors.text}`}>
                                {topUp.status}
                              </span>
                            </div>

                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                              <div className="flex items-start gap-2">
                                <Building size={16} className="text-slate-400 mt-1" />
                                <div>
                                  <p className="text-xs text-slate-500">Organization</p>
                                  <p className="font-medium">{topUp.org?.brandName || "Unknown"}</p>
                                  <p className="text-xs text-slate-500">{topUp.org?.companyName}</p>
                                </div>
                              </div>
                              <div className="flex items-start gap-2">
                                <FileText size={16} className="text-slate-400 mt-1" />
                                <div>
                                  <p className="text-xs text-slate-500">Reference</p>
                                  <p className="font-medium">{topUp.reference || "N/A"}</p>
                                </div>
                              </div>
                              <div>
                                <p className="text-xs text-slate-500">Submitted</p>
                                <p className="font-medium">{format(new Date(topUp.createdAt), "MMM d, yyyy HH:mm")}</p>
                                <p className="text-xs text-slate-400">
                                  {formatDistanceToNow(new Date(topUp.createdAt), { addSuffix: true })}
                                </p>
                              </div>
                            </div>

                            {topUp.proofUrl && (
                              <a
                                href={topUp.proofUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="inline-flex items-center gap-1 text-sm text-pink-600 hover:underline"
                              >
                                <ExternalLink size={14} />
                                View Proof of Payment
                              </a>
                            )}

                            {topUp.status === "rejected" && topUp.rejectionReason && (
                              <div className="bg-red-50 border border-red-100 rounded-lg p-3">
                                <p className="text-sm text-red-700">
                                  <strong>Rejection reason:</strong> {topUp.rejectionReason}
                                </p>
                              </div>
                            )}

                            {topUp.status === "cleared" && topUp.clearedAt && (
                              <p className="text-sm text-green-600">
                                Approved on {format(new Date(topUp.clearedAt), "MMM d, yyyy HH:mm")}
                              </p>
                            )}
                          </div>

                          {topUp.status === "pending" && (
                            <div className="flex flex-row lg:flex-col gap-2 lg:min-w-[140px]">
                              <Button
                                onClick={() => handleApprove(topUp)}
                                disabled={approveMutation.isPending}
                                className="flex-1 lg:flex-none bg-green-600 hover:bg-green-700"
                                data-testid={`button-approve-topup-${topUp.id}`}
                              >
                                {approveMutation.isPending ? (
                                  <Loader2 className="animate-spin mr-2" size={16} />
                                ) : (
                                  <Check size={16} className="mr-2" />
                                )}
                                Approve
                              </Button>
                              <Button
                                variant="outline"
                                onClick={() => {
                                  setSelectedTopUp(topUp);
                                  setShowRejectDialog(true);
                                }}
                                className="flex-1 lg:flex-none border-red-200 text-red-600 hover:bg-red-50"
                                data-testid={`button-reject-topup-${topUp.id}`}
                              >
                                <X size={16} className="mr-2" />
                                Reject
                              </Button>
                            </div>
                          )}
                        </div>
                      </CardContent>
                    </Card>
                  );
                })}
              </div>
            )}
          </TabsContent>
        </Tabs>

        <Dialog open={showRejectDialog} onOpenChange={setShowRejectDialog}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Reject Top-up</DialogTitle>
              <DialogDescription>
                Provide a reason for rejecting this R{selectedTopUp ? parseFloat(selectedTopUp.amount).toLocaleString("en-ZA", { minimumFractionDigits: 2 }) : "0"} payment.
              </DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="reason">Rejection Reason</Label>
                <Textarea
                  id="reason"
                  placeholder="e.g., Payment not found in bank statement, reference mismatch..."
                  value={rejectionReason}
                  onChange={(e) => setRejectionReason(e.target.value)}
                  rows={4}
                  data-testid="textarea-topup-rejection-reason"
                />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setShowRejectDialog(false)}>
                Cancel
              </Button>
              <Button
                onClick={handleReject}
                disabled={rejectMutation.isPending || !rejectionReason.trim()}
                className="bg-red-600 hover:bg-red-700"
                data-testid="button-confirm-reject-topup"
              >
                {rejectMutation.isPending && <Loader2 className="animate-spin mr-2" size={16} />}
                Reject Top-up
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </AdminLayout>
  );
}
