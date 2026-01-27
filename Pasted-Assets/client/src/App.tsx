import { Switch, Route } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/not-found";
import Onboarding from "@/pages/onboarding";
import Home from "@/pages/home";
import EarnInbox from "@/pages/earn-inbox";
import EarnThread from "@/pages/earn-thread";
import PhoneVerification from "@/pages/auth/phone-verification";
import ProfileSetup from "@/pages/auth/profile-setup";
import Permissions from "@/pages/auth/permissions";
import AuthLegalPrivacy from "@/pages/auth/legal";
import Login from "@/pages/auth/login";
import Profile from "@/pages/profile";
import EditProfile from "@/pages/profile/edit-profile";
import MyReferrals from "@/pages/profile/my-referrals";
import Settings from "@/pages/settings";
import HelpSupport from "@/pages/help-support";
import LegalPrivacy from "@/pages/legal-privacy";

import EarnDetail from "@/pages/earn-detail";
import Pots from "@/pages/pots";
import Leaderboard from "@/pages/leaderboard";
import Wallets from "@/pages/wallets";
import TransactionHistory from "@/pages/transaction-history";
import ChatList from "@/pages/chat/chat-list";
import ChatThread from "@/pages/chat/chat-thread";
import ChatSend from "@/pages/chat/chat-send";
import ChatSendSelectWallet from "@/pages/chat/chat-send-select-wallet";
import ChatRequest from "@/pages/chat/chat-request";

import WalletDetail from "@/pages/wallet-detail";
import WalletSendSelectContact from "@/pages/wallet-send-select-contact";
import WalletSendAmount from "@/pages/wallet-send-amount";

import HowItWorks from "@/pages/how-it-works";
import BuyHome from "@/pages/buy/buy-home";

// Admin Portal
import AdminLogin from "@/pages/admin/login";
import AdminDashboard from "@/pages/admin/dashboard";
import AdminCampaigns from "@/pages/admin/campaigns";
import AdminCampaignWizard from "@/pages/admin/campaign-wizard";
import AdminCampaignDetail from "@/pages/admin/campaign-detail";
import AdminWallet from "@/pages/admin/wallet";
import AdminApprovals from "@/pages/admin/approvals";
import AdminTopUps from "@/pages/admin/topups";
import BuyAirtimeWallet from "@/pages/buy/buy-airtime-wallet";
import BuyAirtimeProvider from "@/pages/buy/buy-airtime-provider";
import BuyAirtimeProduct from "@/pages/buy/buy-airtime-product";
import BuySuccess from "@/pages/buy/buy-success";
import BuyElectricityWallet from "@/pages/buy/buy-electricity-wallet";
import BuyElectricityMeter from "@/pages/buy/buy-electricity-meter";
import BuyElectricityAmount from "@/pages/buy/buy-electricity-amount";
import BuyElectricitySuccess from "@/pages/buy/buy-electricity-success";
import BuyHistory from "@/pages/buy/buy-history";

function Router() {
  return (
    <Switch>
      <Route path="/" component={Onboarding} />
      
      {/* Auth Flow */}
      <Route path="/auth/phone" component={PhoneVerification} />
      <Route path="/auth/login" component={Login} />
      <Route path="/auth/profile" component={ProfileSetup} />
      <Route path="/auth/permissions" component={Permissions} />
      <Route path="/auth/legal" component={AuthLegalPrivacy} />

      {/* Main App */}
      <Route path="/home" component={Home} />
      <Route path="/profile" component={Profile} />
      <Route path="/profile/edit" component={EditProfile} />
      <Route path="/profile/referrals" component={MyReferrals} />
      <Route path="/profile/help" component={HelpSupport} />
      <Route path="/profile/legal" component={LegalPrivacy} />
      <Route path="/settings" component={Settings} />
      <Route path="/earn" component={EarnInbox} />
      <Route path="/earn/:id" component={EarnThread} />
      <Route path="/earn/detail/:id" component={EarnDetail} />
      <Route path="/pots" component={Pots} />
      <Route path="/leaderboard" component={Leaderboard} />
      <Route path="/how-it-works" component={HowItWorks} />
      <Route path="/wallets" component={Wallets} />
      <Route path="/wallets/:id" component={WalletDetail} />
      <Route path="/wallets/:id/send" component={WalletSendSelectContact} />
      <Route path="/wallets/:id/send/:contactId" component={WalletSendAmount} />
      <Route path="/transactions" component={TransactionHistory} />

      {/* Buy Flow */}
      <Route path="/buy" component={BuyHome} />
      <Route path="/buy/airtime/wallet" component={BuyAirtimeWallet} />
      <Route path="/buy/airtime/provider/:walletId" component={BuyAirtimeProvider} />
      <Route path="/buy/airtime/product/:walletId/:providerId" component={BuyAirtimeProduct} />
      <Route path="/buy/success" component={BuySuccess} />
      <Route path="/buy/electricity/wallet" component={BuyElectricityWallet} />
      <Route path="/buy/electricity/meter/:walletId" component={BuyElectricityMeter} />
      <Route path="/buy/electricity/amount/:walletId/:meterNumber" component={BuyElectricityAmount} />
      <Route path="/buy/electricity/success/:amount/:meterNumber" component={BuyElectricitySuccess} />
      <Route path="/buy/history" component={BuyHistory} />
      
      {/* Money Chat */}
      <Route path="/chat" component={ChatList} />
      <Route path="/chat/:contactId" component={ChatThread} />
      <Route path="/chat/send/:contactId" component={ChatSendSelectWallet} />
      <Route path="/chat/send/:contactId/:walletId" component={ChatSend} />
      <Route path="/chat/request/:contactId" component={ChatRequest} />

      {/* Admin Portal */}
      <Route path="/admin/login" component={AdminLogin} />
      <Route path="/admin" component={AdminDashboard} />
      <Route path="/admin/campaigns" component={AdminCampaigns} />
      <Route path="/admin/campaigns/new" component={AdminCampaignWizard} />
      <Route path="/admin/campaigns/:id" component={AdminCampaignDetail} />
      <Route path="/admin/wallet" component={AdminWallet} />
      <Route path="/admin/approvals" component={AdminApprovals} />
      <Route path="/admin/topups" component={AdminTopUps} />
      
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Router />
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;
