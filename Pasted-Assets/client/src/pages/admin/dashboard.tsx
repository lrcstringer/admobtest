import { AdminLayout } from "@/components/admin/admin-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useQuery } from "@tanstack/react-query";
import { adminApi } from "@/lib/admin-api";
import { authApi } from "@/lib/api";
import { Link } from "wouter";
import {
  Megaphone,
  Wallet,
  TrendingUp,
  Users,
  Plus,
  ArrowRight,
  BarChart3,
  Clock,
  CheckCircle,
  AlertCircle,
  Loader2,
} from "lucide-react";
import { formatDistanceToNow } from "date-fns";

export default function AdminDashboard() {
  const { data: user } = useQuery({
    queryKey: ["/api/auth/me"],
    queryFn: authApi.getMe,
  });

  const { data: adminProfile } = useQuery({
    queryKey: ["/api/admin/auth/me"],
    queryFn: adminApi.getMe,
    enabled: !!user,
  });

  const currentOrg = adminProfile?.organizations?.[0];

  const { data: wallet, isLoading: walletLoading } = useQuery({
    queryKey: ["/api/admin/wallet", currentOrg?.id],
    queryFn: () => adminApi.getWallet(currentOrg!.id),
    enabled: !!currentOrg?.id,
  });

  const { data: campaigns, isLoading: campaignsLoading } = useQuery({
    queryKey: ["/api/admin/campaigns", currentOrg?.id],
    queryFn: () => adminApi.getCampaigns(currentOrg!.id),
    enabled: !!currentOrg?.id,
  });

  const isSuperAdmin = user?.role === "super_admin";

  if (isSuperAdmin) {
    return <SuperAdminDashboard />;
  }

  const activeCampaigns = campaigns?.filter((c: any) => c.status === "active") || [];
  const pendingCampaigns = campaigns?.filter((c: any) => c.status === "pending_review") || [];
  const draftCampaigns = campaigns?.filter((c: any) => c.status === "draft") || [];

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-slate-900">Welcome back, {user?.firstName || "Advertiser"}</h1>
            <p className="text-slate-500">{currentOrg?.brandName || "Your Organization"}</p>
          </div>
          <Link href="/admin/campaigns/new">
            <Button className="bg-pink-600 hover:bg-pink-700" data-testid="button-new-campaign">
              <Plus size={16} className="mr-2" />
              New Campaign
            </Button>
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Wallet size={16} />
                Wallet Balance
              </CardDescription>
            </CardHeader>
            <CardContent>
              {walletLoading ? (
                <Loader2 className="animate-spin" size={20} />
              ) : (
                <>
                  <p className="text-2xl font-bold text-slate-900">
                    R {parseFloat(wallet?.balance || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                  </p>
                  <p className="text-xs text-slate-500">
                    Spent: R {parseFloat(wallet?.totalSpent || "0").toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                  </p>
                </>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <CheckCircle size={16} className="text-green-500" />
                Active Campaigns
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900">{activeCampaigns.length}</p>
              <p className="text-xs text-slate-500">Currently delivering</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Clock size={16} className="text-yellow-500" />
                Pending Review
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900">{pendingCampaigns.length}</p>
              <p className="text-xs text-slate-500">Awaiting approval</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <AlertCircle size={16} className="text-slate-400" />
                Drafts
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-slate-900">{draftCampaigns.length}</p>
              <p className="text-xs text-slate-500">Not yet submitted</p>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <Megaphone size={20} />
                Recent Campaigns
              </CardTitle>
            </CardHeader>
            <CardContent>
              {campaignsLoading ? (
                <div className="flex justify-center py-8">
                  <Loader2 className="animate-spin" size={24} />
                </div>
              ) : campaigns?.length === 0 ? (
                <div className="text-center py-8">
                  <p className="text-slate-500 mb-4">No campaigns yet</p>
                  <Link href="/admin/campaigns/new">
                    <Button variant="outline">Create your first campaign</Button>
                  </Link>
                </div>
              ) : (
                <div className="space-y-3">
                  {campaigns?.slice(0, 5).map((campaign: any) => (
                    <Link key={campaign.id} href={`/admin/campaigns/${campaign.id}`}>
                      <div className="flex items-center justify-between p-3 rounded-lg hover:bg-slate-50 cursor-pointer border border-slate-100">
                        <div>
                          <p className="font-medium text-slate-900">{campaign.name}</p>
                          <p className="text-xs text-slate-500">
                            Created {formatDistanceToNow(new Date(campaign.createdAt), { addSuffix: true })}
                          </p>
                        </div>
                        <div className="flex items-center gap-2">
                          <span
                            className={`text-xs px-2 py-1 rounded-full ${
                              campaign.status === "active"
                                ? "bg-green-100 text-green-700"
                                : campaign.status === "pending_review"
                                ? "bg-yellow-100 text-yellow-700"
                                : campaign.status === "draft"
                                ? "bg-slate-100 text-slate-700"
                                : "bg-red-100 text-red-700"
                            }`}
                          >
                            {campaign.status.replace("_", " ")}
                          </span>
                          <ArrowRight size={16} className="text-slate-400" />
                        </div>
                      </div>
                    </Link>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                <Wallet size={20} />
                Recent Transactions
              </CardTitle>
            </CardHeader>
            <CardContent>
              {walletLoading ? (
                <div className="flex justify-center py-8">
                  <Loader2 className="animate-spin" size={24} />
                </div>
              ) : wallet?.topUps?.length === 0 ? (
                <div className="text-center py-8">
                  <p className="text-slate-500 mb-4">No transactions yet</p>
                  <Link href="/admin/wallet">
                    <Button variant="outline">Add funds to your wallet</Button>
                  </Link>
                </div>
              ) : (
                <div className="space-y-3">
                  {wallet?.topUps?.slice(0, 5).map((topUp: any) => (
                    <div key={topUp.id} className="flex items-center justify-between p-3 rounded-lg border border-slate-100">
                      <div>
                        <p className="font-medium text-slate-900">
                          + R {parseFloat(topUp.amount).toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                        </p>
                        <p className="text-xs text-slate-500">
                          {formatDistanceToNow(new Date(topUp.createdAt), { addSuffix: true })}
                        </p>
                      </div>
                      <span
                        className={`text-xs px-2 py-1 rounded-full ${
                          topUp.status === "cleared"
                            ? "bg-green-100 text-green-700"
                            : topUp.status === "pending"
                            ? "bg-yellow-100 text-yellow-700"
                            : "bg-red-100 text-red-700"
                        }`}
                      >
                        {topUp.status}
                      </span>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </AdminLayout>
  );
}

function SuperAdminDashboard() {
  const { data: pendingCampaigns, isLoading: campaignsLoading } = useQuery({
    queryKey: ["/api/admin/super/campaigns/pending"],
    queryFn: adminApi.superAdmin.getPendingCampaigns,
  });

  const { data: pendingTopUps, isLoading: topUpsLoading } = useQuery({
    queryKey: ["/api/admin/super/topups", "pending"],
    queryFn: () => adminApi.superAdmin.getTopUps("pending"),
  });

  const { data: orgs, isLoading: orgsLoading } = useQuery({
    queryKey: ["/api/admin/super/orgs"],
    queryFn: adminApi.superAdmin.getOrgs,
  });

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Super Admin Dashboard</h1>
          <p className="text-slate-500">System overview and pending approvals</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Megaphone size={16} />
                Pending Campaigns
              </CardDescription>
            </CardHeader>
            <CardContent>
              {campaignsLoading ? (
                <Loader2 className="animate-spin" size={20} />
              ) : (
                <>
                  <p className="text-2xl font-bold text-slate-900">{pendingCampaigns?.length || 0}</p>
                  <p className="text-xs text-slate-500">Awaiting review</p>
                </>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Wallet size={16} />
                Pending Top-ups
              </CardDescription>
            </CardHeader>
            <CardContent>
              {topUpsLoading ? (
                <Loader2 className="animate-spin" size={20} />
              ) : (
                <>
                  <p className="text-2xl font-bold text-slate-900">{pendingTopUps?.length || 0}</p>
                  <p className="text-xs text-slate-500">EFT payments to verify</p>
                </>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <Users size={16} />
                Advertiser Orgs
              </CardDescription>
            </CardHeader>
            <CardContent>
              {orgsLoading ? (
                <Loader2 className="animate-spin" size={20} />
              ) : (
                <>
                  <p className="text-2xl font-bold text-slate-900">{orgs?.length || 0}</p>
                  <p className="text-xs text-slate-500">Registered organizations</p>
                </>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardDescription className="flex items-center gap-2">
                <TrendingUp size={16} />
                Platform Health
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-2xl font-bold text-green-600">Good</p>
              <p className="text-xs text-slate-500">All systems operational</p>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle className="text-lg">Pending Campaign Approvals</CardTitle>
              <Link href="/admin/approvals">
                <Button variant="outline" size="sm">View All</Button>
              </Link>
            </CardHeader>
            <CardContent>
              {campaignsLoading ? (
                <div className="flex justify-center py-8">
                  <Loader2 className="animate-spin" size={24} />
                </div>
              ) : pendingCampaigns?.length === 0 ? (
                <p className="text-center text-slate-500 py-8">No pending campaigns</p>
              ) : (
                <div className="space-y-3">
                  {pendingCampaigns?.slice(0, 5).map((campaign: any) => (
                    <div key={campaign.id} className="flex items-center justify-between p-3 rounded-lg border border-slate-100">
                      <div>
                        <p className="font-medium text-slate-900">{campaign.name}</p>
                        <p className="text-xs text-slate-500">{campaign.org?.brandName}</p>
                      </div>
                      <Link href={`/admin/approvals/${campaign.id}`}>
                        <Button size="sm" variant="outline">Review</Button>
                      </Link>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle className="text-lg">Pending Top-up Approvals</CardTitle>
              <Link href="/admin/topups">
                <Button variant="outline" size="sm">View All</Button>
              </Link>
            </CardHeader>
            <CardContent>
              {topUpsLoading ? (
                <div className="flex justify-center py-8">
                  <Loader2 className="animate-spin" size={24} />
                </div>
              ) : pendingTopUps?.length === 0 ? (
                <p className="text-center text-slate-500 py-8">No pending top-ups</p>
              ) : (
                <div className="space-y-3">
                  {pendingTopUps?.slice(0, 5).map((topUp: any) => (
                    <div key={topUp.id} className="flex items-center justify-between p-3 rounded-lg border border-slate-100">
                      <div>
                        <p className="font-medium text-slate-900">
                          R {parseFloat(topUp.amount).toLocaleString("en-ZA", { minimumFractionDigits: 2 })}
                        </p>
                        <p className="text-xs text-slate-500">{topUp.org?.brandName}</p>
                      </div>
                      <Link href="/admin/topups">
                        <Button size="sm" variant="outline">Review</Button>
                      </Link>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </AdminLayout>
  );
}
