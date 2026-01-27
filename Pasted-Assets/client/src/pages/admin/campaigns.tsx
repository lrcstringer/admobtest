import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useQuery } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import { authApi } from "@/lib/api";
import { Link } from "wouter";
import {
  Plus,
  Search,
  Filter,
  Megaphone,
  ArrowRight,
  MoreVertical,
  Play,
  Pause,
  Edit,
  BarChart3,
  Loader2,
} from "lucide-react";
import { formatDistanceToNow, format } from "date-fns";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useState } from "react";

const statusColors: Record<string, string> = {
  draft: "bg-slate-100 text-slate-700",
  pending_review: "bg-yellow-100 text-yellow-700",
  approved: "bg-blue-100 text-blue-700",
  rejected: "bg-red-100 text-red-700",
  active: "bg-green-100 text-green-700",
  paused: "bg-orange-100 text-orange-700",
  completed: "bg-purple-100 text-purple-700",
  cancelled: "bg-gray-100 text-gray-700",
};

export default function CampaignsPage() {
  const [statusFilter, setStatusFilter] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState("");

  const { data: adminProfile } = useQuery({
    queryKey: ["/api/admin/auth/me"],
    queryFn: adminApi.getMe,
  });

  const currentOrg = adminProfile?.organizations?.[0];

  const { data: campaigns, isLoading } = useQuery({
    queryKey: ["/api/admin/campaigns", currentOrg?.id, statusFilter],
    queryFn: () => adminApi.getCampaigns(currentOrg!.id, statusFilter === "all" ? undefined : statusFilter),
    enabled: !!currentOrg?.id,
  });

  const filteredCampaigns = campaigns?.filter((c: any) =>
    c.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-slate-900">Campaigns</h1>
            <p className="text-slate-500">Manage your advertising campaigns</p>
          </div>
          <Link href="/admin/campaigns/new">
            <Button className="bg-pink-600 hover:bg-pink-700" data-testid="button-new-campaign">
              <Plus size={16} className="mr-2" />
              New Campaign
            </Button>
          </Link>
        </div>

        <div className="flex flex-col sm:flex-row gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={18} />
            <Input
              placeholder="Search campaigns..."
              className="pl-10"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              data-testid="input-search-campaigns"
            />
          </div>
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-[180px]" data-testid="select-status-filter">
              <Filter size={16} className="mr-2" />
              <SelectValue placeholder="Filter by status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Statuses</SelectItem>
              <SelectItem value="draft">Draft</SelectItem>
              <SelectItem value="pending_review">Pending Review</SelectItem>
              <SelectItem value="approved">Approved</SelectItem>
              <SelectItem value="active">Active</SelectItem>
              <SelectItem value="paused">Paused</SelectItem>
              <SelectItem value="completed">Completed</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {isLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="animate-spin" size={32} />
          </div>
        ) : filteredCampaigns?.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <Megaphone size={48} className="text-slate-300 mb-4" />
              <h3 className="text-lg font-medium text-slate-900 mb-2">No campaigns found</h3>
              <p className="text-slate-500 text-center mb-4">
                {searchQuery || statusFilter !== "all"
                  ? "Try adjusting your search or filter"
                  : "Create your first campaign to start reaching users"}
              </p>
              {!searchQuery && statusFilter === "all" && (
                <Link href="/admin/campaigns/new">
                  <Button>Create Campaign</Button>
                </Link>
              )}
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4">
            {filteredCampaigns?.map((campaign: any) => (
              <Card key={campaign.id} className="hover:shadow-md transition-shadow">
                <CardContent className="p-6">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-2">
                        <h3 className="text-lg font-semibold text-slate-900">{campaign.name}</h3>
                        <span className={`text-xs px-2 py-1 rounded-full capitalize ${statusColors[campaign.status] || "bg-slate-100"}`}>
                          {campaign.status.replace("_", " ")}
                        </span>
                      </div>
                      
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-slate-500">Budget</p>
                          <p className="font-medium text-slate-900">
                            R {parseFloat(campaign.totalBudget || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                          </p>
                        </div>
                        <div>
                          <p className="text-slate-500">Spent</p>
                          <p className="font-medium text-slate-900">
                            R {parseFloat(campaign.totalSpent || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                          </p>
                        </div>
                        <div>
                          <p className="text-slate-500">CPE</p>
                          <p className="font-medium text-slate-900">
                            R {parseFloat(campaign.cpeZar || "0").toFixed(2)}
                          </p>
                        </div>
                        <div>
                          <p className="text-slate-500">Created</p>
                          <p className="font-medium text-slate-900">
                            {formatDistanceToNow(new Date(campaign.createdAt), { addSuffix: true })}
                          </p>
                        </div>
                      </div>

                      {(campaign.startDate || campaign.endDate) && (
                        <div className="mt-3 text-sm text-slate-500">
                          {campaign.startDate && format(new Date(campaign.startDate), "MMM d, yyyy")}
                          {campaign.startDate && campaign.endDate && " - "}
                          {campaign.endDate && format(new Date(campaign.endDate), "MMM d, yyyy")}
                        </div>
                      )}
                    </div>

                    <div className="flex items-center gap-2">
                      <Link href={`/admin/campaigns/${campaign.id}`}>
                        <Button variant="outline" size="sm" data-testid={`button-view-campaign-${campaign.id}`}>
                          View
                          <ArrowRight size={14} className="ml-1" />
                        </Button>
                      </Link>
                      
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" size="icon" className="text-slate-600 hover:text-slate-900" data-testid={`button-campaign-menu-${campaign.id}`}>
                            <MoreVertical size={16} />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          {campaign.status === "draft" && (
                            <DropdownMenuItem asChild>
                              <Link href={`/admin/campaigns/${campaign.id}/edit`}>
                                <Edit size={14} className="mr-2" />
                                Edit
                              </Link>
                            </DropdownMenuItem>
                          )}
                          {campaign.status === "active" && (
                            <DropdownMenuItem>
                              <Pause size={14} className="mr-2" />
                              Pause
                            </DropdownMenuItem>
                          )}
                          {campaign.status === "paused" && (
                            <DropdownMenuItem>
                              <Play size={14} className="mr-2" />
                              Resume
                            </DropdownMenuItem>
                          )}
                          <DropdownMenuItem asChild>
                            <Link href={`/admin/campaigns/${campaign.id}/analytics`}>
                              <BarChart3 size={14} className="mr-2" />
                              Analytics
                            </Link>
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}
      </div>
    </AdminLayout>
  );
}
