import { useState } from "react";
import { useLocation } from "wouter";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Checkbox } from "@/components/ui/checkbox";
import { Loader2 } from "lucide-react";
import { authApi } from "@/lib/api";
import { adminApi } from "@/lib/admin-api";
import { useToast } from "@/hooks/use-toast";

export default function AdminLogin() {
  const [, setLocation] = useLocation();
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [loginData, setLoginData] = useState({ username: "", password: "" });
  const [registerData, setRegisterData] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    firstName: "",
    lastName: "",
    companyName: "",
    brandName: "",
    vatNumber: "",
    registrationNumber: "",
    acceptedTerms: false,
    acceptedPopia: false,
  });

  const loginMutation = useMutation({
    mutationFn: (data: { username: string; password: string }) => authApi.login(data.username, data.password),
    onSuccess: (user) => {
      queryClient.setQueryData(["/api/auth/me"], user);
      if (user.role === "super_admin" || user.role === "advertiser") {
        setLocation("/admin");
      } else {
        toast({ title: "Access denied", description: "You don't have access to the admin portal", variant: "destructive" });
      }
    },
    onError: (error: Error) => {
      toast({ title: "Login failed", description: error.message, variant: "destructive" });
    },
  });

  const registerMutation = useMutation({
    mutationFn: adminApi.register,
    onSuccess: () => {
      toast({ title: "Registration successful", description: "Please check your email for verification, then log in." });
    },
    onError: (error: Error) => {
      toast({ title: "Registration failed", description: error.message, variant: "destructive" });
    },
  });

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    loginMutation.mutate(loginData);
  };

  const handleRegister = (e: React.FormEvent) => {
    e.preventDefault();
    if (registerData.password !== registerData.confirmPassword) {
      toast({ title: "Error", description: "Passwords do not match", variant: "destructive" });
      return;
    }
    if (!registerData.acceptedTerms || !registerData.acceptedPopia) {
      toast({ title: "Error", description: "You must accept the terms and POPIA agreement", variant: "destructive" });
      return;
    }
    registerMutation.mutate(registerData);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <div className="w-16 h-16 bg-gradient-to-br from-pink-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-4">
            <span className="text-white font-bold text-2xl">i</span>
          </div>
          <h1 className="text-2xl font-bold text-white">iMaliChat</h1>
          <p className="text-slate-400">Advertiser Portal</p>
        </div>

        <Card className="border-0 shadow-2xl">
          <Tabs defaultValue="login">
            <CardHeader className="pb-4">
              <TabsList className="grid w-full grid-cols-2">
                <TabsTrigger value="login" data-testid="tab-login">Sign In</TabsTrigger>
                <TabsTrigger value="register" data-testid="tab-register">Register</TabsTrigger>
              </TabsList>
            </CardHeader>

            <CardContent>
              <TabsContent value="login" className="mt-0">
                <form onSubmit={handleLogin} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="username">Username or Email</Label>
                    <Input
                      id="username"
                      type="text"
                      placeholder="Enter your username"
                      value={loginData.username}
                      onChange={(e) => setLoginData({ ...loginData, username: e.target.value })}
                      required
                      data-testid="input-username"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="password">Password</Label>
                    <Input
                      id="password"
                      type="password"
                      placeholder="Enter your password"
                      value={loginData.password}
                      onChange={(e) => setLoginData({ ...loginData, password: e.target.value })}
                      required
                      data-testid="input-password"
                    />
                  </div>
                  <Button
                    type="submit"
                    className="w-full bg-pink-600 hover:bg-pink-700"
                    disabled={loginMutation.isPending}
                    data-testid="button-login"
                  >
                    {loginMutation.isPending ? <Loader2 className="animate-spin mr-2" size={16} /> : null}
                    Sign In
                  </Button>
                </form>
              </TabsContent>

              <TabsContent value="register" className="mt-0">
                <form onSubmit={handleRegister} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="firstName">First Name</Label>
                      <Input
                        id="firstName"
                        placeholder="John"
                        value={registerData.firstName}
                        onChange={(e) => setRegisterData({ ...registerData, firstName: e.target.value })}
                        data-testid="input-firstName"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="lastName">Last Name</Label>
                      <Input
                        id="lastName"
                        placeholder="Doe"
                        value={registerData.lastName}
                        onChange={(e) => setRegisterData({ ...registerData, lastName: e.target.value })}
                        data-testid="input-lastName"
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="email">Email</Label>
                    <Input
                      id="email"
                      type="email"
                      placeholder="you@company.com"
                      value={registerData.email}
                      onChange={(e) => setRegisterData({ ...registerData, email: e.target.value })}
                      required
                      data-testid="input-email"
                    />
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="regPassword">Password</Label>
                      <Input
                        id="regPassword"
                        type="password"
                        placeholder="Min 6 characters"
                        value={registerData.password}
                        onChange={(e) => setRegisterData({ ...registerData, password: e.target.value })}
                        required
                        data-testid="input-reg-password"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="confirmPassword">Confirm</Label>
                      <Input
                        id="confirmPassword"
                        type="password"
                        placeholder="Confirm password"
                        value={registerData.confirmPassword}
                        onChange={(e) => setRegisterData({ ...registerData, confirmPassword: e.target.value })}
                        required
                        data-testid="input-confirm-password"
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="companyName">Company Name</Label>
                    <Input
                      id="companyName"
                      placeholder="Your Company (Pty) Ltd"
                      value={registerData.companyName}
                      onChange={(e) => setRegisterData({ ...registerData, companyName: e.target.value })}
                      required
                      data-testid="input-companyName"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="brandName">Brand Name</Label>
                    <Input
                      id="brandName"
                      placeholder="Your Brand"
                      value={registerData.brandName}
                      onChange={(e) => setRegisterData({ ...registerData, brandName: e.target.value })}
                      required
                      data-testid="input-brandName"
                    />
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="vatNumber">VAT Number</Label>
                      <Input
                        id="vatNumber"
                        placeholder="Optional"
                        value={registerData.vatNumber}
                        onChange={(e) => setRegisterData({ ...registerData, vatNumber: e.target.value })}
                        data-testid="input-vatNumber"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="registrationNumber">Reg Number</Label>
                      <Input
                        id="registrationNumber"
                        placeholder="Optional"
                        value={registerData.registrationNumber}
                        onChange={(e) => setRegisterData({ ...registerData, registrationNumber: e.target.value })}
                        data-testid="input-registrationNumber"
                      />
                    </div>
                  </div>

                  <div className="space-y-3 pt-2">
                    <div className="flex items-start gap-2">
                      <Checkbox
                        id="terms"
                        checked={registerData.acceptedTerms}
                        onCheckedChange={(checked) => setRegisterData({ ...registerData, acceptedTerms: !!checked })}
                        data-testid="checkbox-terms"
                      />
                      <Label htmlFor="terms" className="text-sm leading-tight cursor-pointer">
                        I accept the <span className="text-pink-600 underline">Terms of Service</span> and <span className="text-pink-600 underline">Creative Policy</span>
                      </Label>
                    </div>
                    <div className="flex items-start gap-2">
                      <Checkbox
                        id="popia"
                        checked={registerData.acceptedPopia}
                        onCheckedChange={(checked) => setRegisterData({ ...registerData, acceptedPopia: !!checked })}
                        data-testid="checkbox-popia"
                      />
                      <Label htmlFor="popia" className="text-sm leading-tight cursor-pointer">
                        I accept the <span className="text-pink-600 underline">POPIA Data Processing Agreement</span>
                      </Label>
                    </div>
                  </div>

                  <Button
                    type="submit"
                    className="w-full bg-pink-600 hover:bg-pink-700"
                    disabled={registerMutation.isPending}
                    data-testid="button-register"
                  >
                    {registerMutation.isPending ? <Loader2 className="animate-spin mr-2" size={16} /> : null}
                    Create Account
                  </Button>
                </form>
              </TabsContent>
            </CardContent>
          </Tabs>
        </Card>

        <p className="text-center text-slate-400 text-sm mt-6">
          Regular user? <a href="/" className="text-pink-400 hover:underline">Go to the app</a>
        </p>
      </div>
    </div>
  );
}
