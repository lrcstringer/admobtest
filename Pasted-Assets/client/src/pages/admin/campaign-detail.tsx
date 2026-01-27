import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import { useParams, useLocation } from "wouter";
import {
  ArrowLeft,
  Play,
  Pause,
  Download,
  BarChart3,
  Users,
  Eye,
  CheckCircle,
  DollarSign,
  Calendar,
  Target,
  Loader2,
  Clock,
  AlertCircle,
  PieChart,
} from "lucide-react";
import { format } from "date-fns";
import { useToast } from "@/hooks/use-toast";
import { Progress } from "@/components/ui/progress";

const statusColors: Record<string, { bg: string; text: string; label: string }> = {
  draft: { bg: "bg-slate-100", text: "text-slate-700", label: "Draft" },
  pending_review: { bg: "bg-yellow-100", text: "text-yellow-700", label: "Pending Review" },
  approved: { bg: "bg-blue-100", text: "text-blue-700", label: "Approved" },
  rejected: { bg: "bg-red-100", text: "text-red-700", label: "Rejected" },
  active: { bg: "bg-green-100", text: "text-green-700", label: "Active" },
  paused: { bg: "bg-orange-100", text: "text-orange-700", label: "Paused" },
  completed: { bg: "bg-purple-100", text: "text-purple-700", label: "Completed" },
  cancelled: { bg: "bg-gray-100", text: "text-gray-700", label: "Cancelled" },
};

export default function CampaignDetail() {
  const { id } = useParams<{ id: string }>();
  const [, setLocation] = useLocation();
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const { data: adminProfile } = useQuery({
    queryKey: ["/api/admin/auth/me"],
    queryFn: adminApi.getMe,
  });

  const currentOrg = adminProfile?.organizations?.[0];

  const { data: campaign, isLoading } = useQuery({
    queryKey: ["/api/admin/campaign", currentOrg?.id, id],
    queryFn: () => adminApi.getCampaign(String(currentOrg!.id), id!),
    enabled: !!currentOrg?.id && !!id,
  });

  const { data: analytics, isLoading: analyticsLoading } = useQuery({
    queryKey: ["/api/admin/campaign/analytics", currentOrg?.id, id],
    queryFn: () => adminApi.getCampaignMetrics(String(currentOrg!.id), id!),
    enabled: !!currentOrg?.id && !!id,
  });

  const pauseMutation = useMutation({
    mutationFn: () => adminApi.pauseCampaign(String(currentOrg!.id), id!),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaign", currentOrg?.id, id] });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaigns"] });
      toast({ title: "Campaign paused", description: "Your campaign has been paused" });
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const resumeMutation = useMutation({
    mutationFn: () => adminApi.resumeCampaign(String(currentOrg!.id), id!),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaign", currentOrg?.id, id] });
      queryClient.invalidateQueries({ queryKey: ["/api/admin/campaigns"] });
      toast({ title: "Campaign resumed", description: "Your campaign is now active" });
    },
    onError: (error: Error) => {
      toast({ title: "Error", description: error.message, variant: "destructive" });
    },
  });

  const handleExportCSV = async () => {
    try {
      const csvText = await adminApi.exportCampaignMetrics(String(currentOrg!.id), id!);
      if (!csvText || typeof csvText !== "string") {
        throw new Error("Failed to export CSV");
      }
      const blob = new Blob([csvText], { type: "text/csv" });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = `campaign-${id}-analytics.csv`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      toast({ title: "Export complete", description: "CSV downloaded successfully" });
    } catch (error: any) {
      toast({ title: "Export failed", description: error.message, variant: "destructive" });
    }
  };

  if (isLoading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="animate-spin" size={32} />
        </div>
      </AdminLayout>
    );
  }

  if (!campaign) {
    return (
      <AdminLayout>
        <div className="text-center py-12">
          <AlertCircle size={48} className="mx-auto text-slate-300 mb-4" />
          <h2 className="text-xl font-semibold text-slate-900">Campaign not found</h2>
          <Button variant="outline" className="mt-4" onClick={() => setLocation("/admin/campaigns")}>
            Back to Campaigns
          </Button>
        </div>
      </AdminLayout>
    );
  }

  const statusInfo = statusColors[campaign.status] || statusColors.draft;
  const budgetUsed = campaign.totalBudget ? (parseFloat(campaign.totalSpent || "0") / parseFloat(campaign.totalBudget)) * 100 : 0;

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="flex items-start justify-between">
          <div>
            <Button variant="ghost" size="sm" onClick={() => setLocation("/admin/campaigns")} className="mb-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100">
              <ArrowLeft size={16} className="mr-2" />
              Back to Campaigns
            </Button>
            <div className="flex items-center gap-3">
              <h1 className="text-2xl font-bold text-slate-900">{campaign.name}</h1>
              <span className={`text-xs px-3 py-1 rounded-full ${statusInfo.bg} ${statusInfo.text}`}>
                {statusInfo.label}
              </span>
            </div>
          </div>

          <div className="flex gap-2">
            {campaign.status === "active" && (
              <Button
                variant="outline"
                onClick={() => pauseMutation.mutate()}
                disabled={pauseMutation.isPending}
                data-testid="button-pause-campaign"
              >
                {pauseMutation.isPending ? <Loader2 className="animate-spin mr-2" size={16} /> : <Pause size={16} className="mr-2" />}
                Pause Campaign
              </Button>
            )}
            {campaign.status === "paused" && (
              <Button
                onClick={() => resumeMutation.mutate()}
                disabled={resumeMutation.isPending}
                className="bg-pink-600 hover:bg-pink-700"
                data-testid="button-resume-campaign"
              >
                {resumeMutation.isPending ? <Loader2 className="animate-spin mr-2" size={16} /> : <Play size={16} className="mr-2" />}
                Resume Campaign
              </Button>
            )}
            <Button variant="outline" onClick={handleExportCSV} data-testid="button-export-csv">
              <Download size={16} className="mr-2" />
              Export CSV
            </Button>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Eye size={16} />
                Impressions
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900" data-testid="stat-impressions">
                {analyticsLoading ? "-" : (analytics?.impressions || 0).toLocaleString()}
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <CheckCircle size={16} className="text-green-500" />
                Engagements
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900" data-testid="stat-engagements">
                {analyticsLoading ? "-" : (analytics?.engagements || 0).toLocaleString()}
              </p>
              <p className="text-xs text-slate-500">
                {analytics?.engagementRate ? `${analytics.engagementRate.toFixed(1)}% rate` : "-"}
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Users size={16} />
                Unique Users
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900" data-testid="stat-unique-users">
                {analyticsLoading ? "-" : (analytics?.uniqueUsers || 0).toLocaleString()}
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <DollarSign size={16} />
                Total Spent
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900" data-testid="stat-spent">
                R {parseFloat(campaign.totalSpent || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
              </p>
              <p className="text-xs text-slate-500">
                of R {parseFloat(campaign.totalBudget || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })} budget
              </p>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <Card className="lg:col-span-2">
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <BarChart3 size={20} />
                Budget Progress
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm text-slate-500">Budget Used</span>
                  <span className="text-sm font-medium">{budgetUsed.toFixed(1)}%</span>
                </div>
                <Progress value={budgetUsed} className="h-3" />
              </div>

              <div className="grid grid-cols-2 gap-4 pt-4">
                <div>
                  <p className="text-sm text-slate-500">Cost Per Engagement</p>
                  <p className="text-lg font-semibold">R {parseFloat(campaign.cpeZar || "0").toFixed(2)}</p>
                </div>
                <div>
                  <p className="text-sm text-slate-500">Actual eCPE</p>
                  <p className="text-lg font-semibold">
                    R {analytics?.engagements && analytics.engagements > 0
                      ? (parseFloat(campaign.totalSpent || "0") / analytics.engagements).toFixed(2)
                      : "0.00"}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-slate-500">Daily Cap</p>
                  <p className="text-lg font-semibold">
                    {campaign.dailyCap ? `R ${parseFloat(campaign.dailyCap).toLocaleString("en-ZA", { minimumFractionDigits: 2 })}` : "No limit"}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-slate-500">Frequency Cap</p>
                  <p className="text-lg font-semibold">{campaign.frequencyCapPerUser || 2}x per user/day</p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <Calendar size={20} />
                Campaign Details
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <p className="text-sm text-slate-500">Start Date</p>
                <p className="font-medium">
                  {campaign.startDate ? format(new Date(campaign.startDate), "MMM d, yyyy") : "Not set"}
                </p>
              </div>
              <div>
                <p className="text-sm text-slate-500">End Date</p>
                <p className="font-medium">
                  {campaign.endDate ? format(new Date(campaign.endDate), "MMM d, yyyy") : "Not set"}
                </p>
              </div>
              <div>
                <p className="text-sm text-slate-500">Created</p>
                <p className="font-medium">{format(new Date(campaign.createdAt), "MMM d, yyyy HH:mm")}</p>
              </div>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <Target size={20} />
                Targeting
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div>
                <p className="text-sm text-slate-500">Age Range</p>
                <p className="font-medium">
                  {campaign.targetAgeMin && campaign.targetAgeMax
                    ? `${campaign.targetAgeMin} - ${campaign.targetAgeMax}`
                    : "All ages"}
                </p>
              </div>
              <div>
                <p className="text-sm text-slate-500">Genders</p>
                <p className="font-medium capitalize">
                  {campaign.targetGenders && campaign.targetGenders.length > 0
                    ? campaign.targetGenders.join(", ")
                    : "All genders"}
                </p>
              </div>
              <div>
                <p className="text-sm text-slate-500">Provinces</p>
                <p className="font-medium">
                  {campaign.targetProvinces && campaign.targetProvinces.length > 0
                    ? campaign.targetProvinces.join(", ")
                    : "All provinces"}
                </p>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <PieChart size={20} />
                Demographic Breakdown
              </CardTitle>
              <CardDescription>Aggregated audience data (no PII)</CardDescription>
            </CardHeader>
            <CardContent>
              {analyticsLoading ? (
                <div className="flex justify-center py-8">
                  <Loader2 className="animate-spin" size={24} />
                </div>
              ) : analytics?.demographics ? (
                <div className="space-y-4">
                  <div>
                    <p className="text-sm text-slate-500 mb-2">By Age Group</p>
                    <div className="flex flex-wrap gap-2">
                      {analytics.demographics.byAge?.map((item: any) => (
                        <span key={item.range} className="text-xs px-2 py-1 bg-blue-50 text-blue-700 rounded">
                          {item.range}: {item.percentage}%
                        </span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <p className="text-sm text-slate-500 mb-2">By Gender</p>
                    <div className="flex flex-wrap gap-2">
                      {analytics.demographics.byGender?.map((item: any) => (
                        <span key={item.gender} className="text-xs px-2 py-1 bg-pink-50 text-pink-700 rounded capitalize">
                          {item.gender}: {item.percentage}%
                        </span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <p className="text-sm text-slate-500 mb-2">Top Provinces</p>
                    <div className="flex flex-wrap gap-2">
                      {analytics.demographics.byProvince?.slice(0, 5).map((item: any) => (
                        <span key={item.province} className="text-xs px-2 py-1 bg-green-50 text-green-700 rounded">
                          {item.province}: {item.percentage}%
                        </span>
                      ))}
                    </div>
                  </div>
                </div>
              ) : (
                <p className="text-center text-slate-500 py-4">No demographic data available yet</p>
              )}
            </CardContent>
          </Card>
        </div>

        {campaign.questions && campaign.questions.length > 0 && (
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">Survey Questions</CardTitle>
              <CardDescription>{campaign.questions.length} question(s)</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {campaign.questions.map((q: any, index: number) => (
                  <div key={q.id} className="p-4 bg-slate-50 rounded-lg">
                    <p className="font-medium mb-2">{index + 1}. {q.questionText}</p>
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
                      {q.options?.map((option: string, optIndex: number) => (
                        <span key={optIndex} className="text-sm text-slate-600 px-2 py-1 bg-white rounded border">
                          {option}
                        </span>
                      ))}
                    </div>
                    {q.responses && (
                      <p className="text-sm text-slate-500 mt-2">
                        {q.responses} responses
                      </p>
                    )}
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </AdminLayout>
  );
}
