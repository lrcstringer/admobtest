import { Link, useLocation } from "wouter";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  LayoutDashboard,
  Megaphone,
  Wallet,
  BarChart3,
  Users,
  Settings,
  LogOut,
  Menu,
  X,
  Building2,
  CheckSquare,
  CreditCard,
  ChevronDown,
} from "lucide-react";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { authApi } from "@/lib/api";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

interface AdminLayoutProps {
  children: React.ReactNode;
}

interface NavItem {
  label: string;
  href: string;
  icon: React.ReactNode;
  roles?: string[];
  superAdminOnly?: boolean;
}

const advertiserNavItems: NavItem[] = [
  { label: "Dashboard", href: "/admin", icon: <LayoutDashboard size={20} /> },
  { label: "Campaigns", href: "/admin/campaigns", icon: <Megaphone size={20} /> },
  { label: "Wallet", href: "/admin/wallet", icon: <Wallet size={20} /> },
  { label: "Analytics", href: "/admin/analytics", icon: <BarChart3 size={20} /> },
  { label: "Team", href: "/admin/team", icon: <Users size={20} /> },
];

const superAdminNavItems: NavItem[] = [
  { label: "Dashboard", href: "/admin", icon: <LayoutDashboard size={20} /> },
  { label: "Users", href: "/admin/users", icon: <Users size={20} /> },
  { label: "Organizations", href: "/admin/organizations", icon: <Building2 size={20} /> },
  { label: "Campaign Approvals", href: "/admin/approvals", icon: <CheckSquare size={20} /> },
  { label: "Top-up Approvals", href: "/admin/topups", icon: <CreditCard size={20} /> },
  { label: "Settings", href: "/admin/settings", icon: <Settings size={20} /> },
];

export function AdminLayout({ children }: AdminLayoutProps) {
  const [location] = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const queryClient = useQueryClient();

  const { data: user } = useQuery({
    queryKey: ["/api/auth/me"],
    queryFn: authApi.getMe,
  });

  const logoutMutation = useMutation({
    mutationFn: authApi.logout,
    onSuccess: () => {
      queryClient.clear();
      window.location.href = "/admin/login";
    },
  });

  const isSuperAdmin = user?.role === "super_admin";
  const navItems = isSuperAdmin ? superAdminNavItems : advertiserNavItems;

  return (
    <div className="min-h-screen bg-slate-50">
      <button
        className="lg:hidden fixed top-4 left-4 z-50 p-2 bg-white rounded-lg shadow-md"
        onClick={() => setSidebarOpen(!sidebarOpen)}
        data-testid="button-toggle-sidebar"
      >
        {sidebarOpen ? <X size={24} /> : <Menu size={24} />}
      </button>

      <aside
        className={cn(
          "fixed inset-y-0 left-0 z-40 w-64 bg-white border-r border-slate-200 transform transition-transform duration-200 ease-in-out lg:translate-x-0",
          sidebarOpen ? "translate-x-0" : "-translate-x-full"
        )}
      >
        <div className="flex flex-col h-full">
          <div className="p-6 border-b border-slate-200">
            <Link href="/admin">
              <div className="flex items-center gap-2 cursor-pointer">
                <div className="w-10 h-10 bg-gradient-to-br from-pink-500 to-purple-600 rounded-xl flex items-center justify-center">
                  <span className="text-white font-bold text-lg">i</span>
                </div>
                <div>
                  <h1 className="font-bold text-slate-900">iMaliChat</h1>
                  <p className="text-xs text-slate-500">
                    {isSuperAdmin ? "Admin Portal" : "Advertiser Portal"}
                  </p>
                </div>
              </div>
            </Link>
          </div>

          <nav className="flex-1 p-4 space-y-1 overflow-y-auto">
            {navItems.map((item) => {
              const isActive = location === item.href || 
                (item.href !== "/admin" && location.startsWith(item.href));
              
              return (
                <Link key={item.href} href={item.href}>
                  <div
                    className={cn(
                      "flex items-center gap-3 px-4 py-3 rounded-lg cursor-pointer transition-colors",
                      isActive
                        ? "bg-pink-50 text-pink-600"
                        : "text-slate-600 hover:bg-slate-50"
                    )}
                    data-testid={`nav-${item.label.toLowerCase().replace(" ", "-")}`}
                  >
                    {item.icon}
                    <span className="font-medium">{item.label}</span>
                  </div>
                </Link>
              );
            })}
          </nav>

          <div className="p-4 border-t border-slate-200">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <button className="flex items-center gap-3 w-full p-3 rounded-lg hover:bg-slate-50 transition-colors">
                  <Avatar className="h-10 w-10">
                    <AvatarFallback className="bg-pink-100 text-pink-600 font-bold">
                      {user?.firstName?.[0] || user?.username?.[0] || "U"}
                    </AvatarFallback>
                  </Avatar>
                  <div className="flex-1 text-left">
                    <p className="font-medium text-slate-900 text-sm">
                      {user?.firstName || user?.username}
                    </p>
                    <p className="text-xs text-slate-500 capitalize">{user?.role?.replace("_", " ")}</p>
                  </div>
                  <ChevronDown size={16} className="text-slate-400" />
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel>My Account</DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem onClick={() => logoutMutation.mutate()}>
                  <LogOut size={16} className="mr-2" />
                  Sign Out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </div>
      </aside>

      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-black/20 z-30 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      <main className="lg:ml-64 min-h-screen">
        <div className="p-6 lg:p-8">
          {children}
        </div>
      </main>
    </div>
  );
}
