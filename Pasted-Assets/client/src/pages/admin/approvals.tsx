import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import {
  Check,
  X,
  Eye,
  Loader2,
  Megaphone,
  Calendar,
  DollarSign,
  Target,
  AlertCircle,
} from "lucide-react";
import { format } from "date-fns";
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

export default function ApprovalsPage() {
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [selectedCampaign, setSelectedCampaign] = useState<any>(null);
  const [rejectionReason, setRejectionReason] = useState("");
  const [showRejectDialog, setShowRejectDialog] = useState(false);

  const { data: pendingCampaigns, isLoading } = useQuery({
    queryKey: ["/api/admin/super/campaigns/pending"],
    queryFn: adminApi.superAdmin.getPendingCampaigns,
  });

  const approveMutation = useMutation({
    mutationFn: (campaignId: string) => adminApi.superAdmin.approveCampaign(campaignId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/super/campaigns/pending"] });
      toast({ title: "Campaign approved", description: "The campaign has been approved and is now active" });
      setSelectedCampaign(null);
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const rejectMutation = useMutation({
    mutationFn: ({ campaignId, reason }: { campaignId: string; reason: string }) =>
      adminApi.superAdmin.rejectCampaign(campaignId, reason),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/super/campaigns/pending"] });
      toast({ title: "Campaign rejected", description: "The campaign has been rejected" });
      setSelectedCampaign(null);
      setShowRejectDialog(false);
      setRejectionReason("");
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const handleApprove = (campaign: any) => {
    approveMutation.mutate(String(campaign.id));
  };

  const handleReject = () => {
    if (selectedCampaign) {
      rejectMutation.mutate({ campaignId: String(selectedCampaign.id), reason: rejectionReason });
    }
  };

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Campaign Approvals</h1>
          <p className="text-slate-500">Review and approve pending campaigns</p>
        </div>

        {isLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="animate-spin" size={32} />
          </div>
        ) : pendingCampaigns?.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Megaphone size={48} className="text-slate-300 mb-4" />
              <h3 className="text-lg font-medium text-slate-900 mb-2">No pending campaigns</h3>
              <p className="text-slate-500">All campaigns have been reviewed</p>
            </CardContent>
          </Card>
        ) : (
          <div className="space-y-4">
            {pendingCampaigns?.map((campaign: any) => (
              <Card key={campaign.id} className="overflow-hidden">
                <CardContent className="p-6">
                  <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4">
                    <div className="flex-1 space-y-4">
                      <div>
                        <div className="flex items-center gap-3 mb-1">
                          <h3 className="text-lg font-semibold text-slate-900">{campaign.name}</h3>
                          <span className="text-xs px-2 py-1 rounded-full bg-yellow-100 text-yellow-700">
                            Pending Review
                          </span>
                        </div>
                        <p className="text-sm text-slate-500">
                          by <span className="font-medium">{campaign.org?.brandName || "Unknown"}</span> ({campaign.org?.companyName})
                        </p>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div className="flex items-start gap-2">
                          <DollarSign size={16} className="text-slate-400 mt-1" />
                          <div>
                            <p className="text-xs text-slate-500">Budget</p>
                            <p className="font-medium">
                              R {parseFloat(campaign.totalBudget || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                            </p>
                          </div>
                        </div>
                        <div className="flex items-start gap-2">
                          <DollarSign size={16} className="text-slate-400 mt-1" />
                          <div>
                            <p className="text-xs text-slate-500">CPE</p>
                            <p className="font-medium">R {parseFloat(campaign.cpeZar || "0").toFixed(2)}</p>
                          </div>
                        </div>
                        <div className="flex items-start gap-2">
                          <Calendar size={16} className="text-slate-400 mt-1" />
                          <div>
                            <p className="text-xs text-slate-500">Dates</p>
                            <p className="font-medium text-sm">
                              {campaign.startDate ? format(new Date(campaign.startDate), "MMM d") : "Open"} -
                              {campaign.endDate ? format(new Date(campaign.endDate), " MMM d") : " Open"}
                            </p>
                          </div>
                        </div>
                        <div className="flex items-start gap-2">
                          <Target size={16} className="text-slate-400 mt-1" />
                          <div>
                            <p className="text-xs text-slate-500">Targeting</p>
                            <p className="font-medium text-sm">
                              {campaign.targetAgeMin
                                ? `${campaign.targetAgeMin}-${campaign.targetAgeMax}`
                                : "All ages"}
                            </p>
                          </div>
                        </div>
                      </div>

                      {campaign.creatives?.length > 0 && (
                        <div>
                          <p className="text-sm text-slate-500 mb-2">Creatives: {campaign.creatives.length} asset(s)</p>
                        </div>
                      )}

                      {campaign.questions?.length > 0 && (
                        <div>
                          <p className="text-sm text-slate-500 mb-2">Survey: {campaign.questions.length} question(s)</p>
                          <div className="text-sm bg-slate-50 rounded-lg p-3">
                            {campaign.questions.slice(0, 2).map((q: any, idx: number) => (
                              <p key={idx} className="text-slate-600">
                                {idx + 1}. {q.questionText}
                              </p>
                            ))}
                            {campaign.questions.length > 2 && (
                              <p className="text-slate-400">... and {campaign.questions.length - 2} more</p>
                            )}
                          </div>
                        </div>
                      )}
                    </div>

                    <div className="flex flex-row lg:flex-col gap-2 lg:min-w-[140px]">
                      <Button
                        onClick={() => handleApprove(campaign)}
                        disabled={approveMutation.isPending}
                        className="flex-1 lg:flex-none bg-green-600 hover:bg-green-700"
                        data-testid={`button-approve-${campaign.id}`}
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
                          setSelectedCampaign(campaign);
                          setShowRejectDialog(true);
                        }}
                        className="flex-1 lg:flex-none border-red-200 text-red-600 hover:bg-red-50"
                        data-testid={`button-reject-${campaign.id}`}
                      >
                        <X size={16} className="mr-2" />
                        Reject
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        <Dialog open={showRejectDialog} onOpenChange={setShowRejectDialog}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Reject Campaign</DialogTitle>
              <DialogDescription>
                Provide a reason for rejecting "{selectedCampaign?.name}". This will be sent to the advertiser.
              </DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="reason">Rejection Reason</Label>
                <Textarea
                  id="reason"
                  placeholder="e.g., Creative content does not meet policy guidelines..."
                  value={rejectionReason}
                  onChange={(e) => setRejectionReason(e.target.value)}
                  rows={4}
                  data-testid="textarea-rejection-reason"
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
                data-testid="button-confirm-reject"
              >
                {rejectMutation.isPending && <Loader2 className="animate-spin mr-2" size={16} />}
                Reject Campaign
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </AdminLayout>
  );
}
