import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/di/injection.dart';
import '../../domain/enums/pool_mode.dart';
import '../blocs/auth/auth_bloc.dart';

// Auth screens
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/phone_input_screen.dart';
import '../screens/auth/session_lock_screen.dart';
import '../screens/auth/step_up_otp_screen.dart';
import '../screens/auth/age_consent_screen.dart';
import '../screens/auth/privacy_policy_screen.dart';
import '../screens/auth/terms_of_service_screen.dart';
import '../screens/auth/welcome_screen.dart';

// Buy screens
import '../../domain/entities/brand_product.dart';
import '../screens/buy/brand_product_detail_screen.dart';
import '../screens/buy/brand_storefront_screen.dart';
import '../screens/buy/buy_category_screen.dart';
import '../screens/buy/buy_subcategory_list_screen.dart';
import '../screens/buy/buy_failure_screen.dart';
import '../screens/buy/buy_purchase_history_screen.dart';
import '../screens/buy/buy_services_screen.dart';
import '../screens/buy/buy_success_screen.dart';
import '../screens/buy/buy_transactions_screen.dart';
import '../screens/buy/buy_wallet_selection_screen.dart';
import '../screens/buy/create_listing_screen.dart';
import '../screens/buy/marketplace_hub_screen.dart';
import '../screens/buy/make_offer_screen.dart';
import '../screens/buy/marketplace_listing_detail_screen.dart';
import '../screens/buy/marketplace_provider_profile_screen.dart';
import '../screens/buy/marketplace_report_screen.dart';
import '../screens/buy/my_orders_screen.dart';
import '../screens/buy/order_detail_screen.dart';
import '../screens/buy/seller_registration_screen.dart';
import '../screens/buy/edit_seller_profile_screen.dart';
import '../screens/buy/seller_dashboard_screen.dart';
import '../screens/buy/group_buy_list_screen.dart';
import '../screens/buy/group_buy_detail_screen.dart';
import '../screens/buy/create_group_buy_screen.dart';
import '../screens/buy/group_buy_voucher_screen.dart';
import '../screens/buy/group_buy_collection_screen.dart';
import '../screens/buy/community_group_buy_create_screen.dart';

// Chat screens (legacy — kept for backward compat until cleanup)
import '../screens/chat/chat_bonus_network_invite_screen.dart';
import '../screens/chat/chat_bonus_network_screen.dart';
import '../screens/chat/chat_send_amount_screen.dart';
import '../screens/chat/chat_send_failure_screen.dart';
import '../screens/chat/chat_send_success_screen.dart';
import '../screens/chat/chat_send_wallet_selection_screen.dart';

// Pool screens (Collection Room)
import '../screens/pool/create_pool_screen.dart';
import '../screens/pool/collection_room_screen.dart';

// New messaging screens (unified chat + community)
import '../screens/messaging/messaging_screen.dart';
import '../screens/messaging/contact_picker_screen.dart';
import '../screens/messaging/conversation_detail_screen.dart';
import '../screens/messaging/image_viewer_screen.dart';
import '../screens/messaging/voice_call_screen.dart';
import '../screens/messaging/video_call_screen.dart';
import '../screens/messaging/contact_requests_screen.dart';
import '../screens/messaging/import_contacts_screen.dart';
import '../screens/messaging/brand_accounts_screen.dart';
import '../screens/messaging/message_requests_screen.dart';
import '../screens/community/community_detail_screen.dart';
import '../screens/community/create_community_screen.dart';
import '../screens/community/community_settings_screen.dart';
import '../screens/community/community_members_screen.dart';
import '../screens/community/invite_member_screen.dart';
import '../screens/community/community_transaction_screen.dart';
import '../screens/community/pending_approvals_screen.dart';

// Domain entities (for route extras)
import '../../domain/entities/buy_category.dart';
import '../../domain/entities/gift.dart';
import '../../domain/enums/community_type.dart';

// Gift screens
import '../screens/gift/gift_composer_screen.dart';
import '../screens/gift/gift_history_screen.dart';
import '../screens/gift/gift_opening_screen.dart';
import '../screens/gift/sasaza_chooser_screen.dart';

// Spray screens
import '../screens/spray/spray_detail_screen.dart';

// QR screens
import '../screens/qr/qr_display_screen.dart';
import '../screens/qr/qr_scanner_screen.dart';

// Earn screens
import '../screens/earn/earn_interaction_screen.dart';
import '../screens/earn/earn_screen.dart';
import '../screens/earn/earn_thread_screen.dart';
import '../screens/earn/earn_wallet_confirm_screen.dart';

// Home screens
import '../screens/home/bonus_network_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/how_to_earn_screen.dart';
import '../screens/home/upgrade_status_screen.dart';
import '../screens/home/what_is_emalichat_screen.dart';


// Gooi-Gooi screens
import '../screens/gooi/gooi_list_screen.dart';
import '../screens/gooi/gooi_onboarding_screen.dart';
import '../screens/gooi/gooi_create_screen.dart';
import '../screens/gooi/gooi_invite_screen.dart';
import '../screens/gooi/gooi_roster_screen.dart';
import '../screens/gooi/gooi_bidding_screen.dart';
import '../screens/gooi/gooi_confirm_screen.dart';
import '../screens/gooi/gooi_dashboard_screen.dart';
import '../screens/gooi/gooi_delegate_screen.dart';
import '../screens/gooi/gooi_history_screen.dart';
import '../screens/gooi/gooi_withdrawal_vote_screen.dart';
import '../screens/gooi/gooi_round_complete_screen.dart';

// Main shell
import '../screens/main/main_shell.dart';

// Pots screen
import '../screens/pots/pots_screen.dart';

// Onboarding screens
import '../screens/onboarding/onboarding_birthday_screen.dart';
import '../screens/onboarding/onboarding_gender_screen.dart';
import '../screens/onboarding/onboarding_mobile_otp_screen.dart';
import '../screens/onboarding/onboarding_mobile_screen.dart';
import '../screens/onboarding/onboarding_extrainfo_screen.dart';
import '../screens/onboarding/onboarding_name_screen.dart';
// Note: Onboarding settings/permissions screens removed - permissions requested in context
// import '../screens/onboarding/onboarding_settings_screen.dart';
// import '../screens/onboarding/permissions_screen.dart';
import '../screens/onboarding/profile_picture_screen.dart';
import '../screens/onboarding/onboarding_success_screen.dart';
import '../screens/onboarding/pin_setup_screen.dart';
import '../screens/onboarding/profile_setup_screen.dart';
// Note: TermsScreen import removed - terms acceptance now on age consent screen
// import '../screens/onboarding/terms_screen.dart';

// Profile screens
import '../screens/messaging/contacts_tab.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';

// Referral
import '../screens/referral/referral_screen.dart';

// Settings screens
import '../screens/settings/about_screen.dart';
import '../screens/settings/help_support_screen.dart';
import '../screens/settings/kyc_verification_screen.dart';
import '../screens/settings/notification_settings_screen.dart';
import '../screens/settings/privacy_settings_screen.dart';
import '../screens/settings/security_settings_screen.dart';
import '../screens/settings/settings_screen.dart';

// Splash
import '../screens/splash/splash_screen.dart';

// Wallet screens
import '../screens/wallet/cashout_screen.dart';
import '../screens/wallet/transaction_history_screen.dart';
import '../screens/wallet/wallet_detail_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/wallet/wallet_send_amount_screen.dart';
import '../screens/wallet/wallet_send_failure_screen.dart';
import '../screens/wallet/wallet_send_screen.dart';
import '../screens/wallet/wallet_send_success_screen.dart';
import '../screens/wallet/reward_item_detail_screen.dart';
import '../screens/wallet/rewards_list_screen.dart';

// Groups screens (legacy — kept until cleanup)
import '../screens/groups/groups_list_screen.dart';
import '../screens/groups/group_detail_screen.dart';
import '../screens/groups/create_group_screen.dart';
import '../screens/groups/group_transaction_screen.dart';
import '../screens/groups/pending_approvals_screen.dart' as groups;

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  // Stable navigator keys — prevent Duplicate GlobalKey errors on refresh
  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final _homeNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeTab');
  static final _earnNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'earnTab');
  static final _chatNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'chatTab');
  static final _buyNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'buyTab');
  static final _walletNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'walletTab');

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      // 1) Splash
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Session Lock
      GoRoute(
        path: '/auth/session-lock',
        name: 'sessionLock',
        builder: (context, state) => const SessionLockScreen(),
      ),

      // 2) Welcome
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),

      // 2b) Age consent
      GoRoute(
        path: '/auth/age-consent',
        name: 'ageConsent',
        builder: (context, state) => const AgeConsentScreen(),
      ),
      GoRoute(
        path: '/auth/terms-of-service',
        name: 'termsOfService',
        builder: (context, state) => const TermsOfServiceScreen(),
      ),
      GoRoute(
        path: '/auth/privacy-policy',
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),

      // 3) Signup (phone + OTP flow)
      GoRoute(
        path: '/auth/phone',
        name: 'phone',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PhoneInputScreen(
            initialPhoneNumber: extra?['phoneNumber'] as String?,
          );
        },
      ),
      GoRoute(
        path: '/auth/otp',
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpVerificationScreen(
            verificationId: extra?['verificationId'] ?? '',
            phoneNumber: extra?['phoneNumber'] ?? '',
          );
        },
      ),

      GoRoute(
        path: '/auth/step-up-otp',
        name: 'stepUpOtp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return StepUpOtpScreen(
            phoneNumber: extra?['phoneNumber'] ?? '',
            reason: extra?['reason'] as String? ??
                'This action requires identity verification.',
          );
        },
      ),


      // 4) Settings (accessible outside shell too)
      GoRoute(
        path: '/settings',
        name: 'settingsRoot',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Onboarding routes
      // Note: Terms screen removed from routing - terms acceptance now handled
      // on the age consent screen before sign-up. The TermsScreen file is kept
      // for potential future use but not part of the onboarding flow.
      GoRoute(
        path: '/onboarding/name',
        name: 'onboardingName',
        builder: (context, state) => const OnboardingNameScreen(),
      ),
      GoRoute(
        path: '/onboarding/extrainfo',
        name: 'onboardingExtraInfo',
        builder: (context, state) => const OnboardingExtraInfoScreen(),
      ),
      GoRoute(
        path: '/onboarding/gender',
        name: 'onboardingGender',
        builder: (context, state) => const OnboardingGenderScreen(),
      ),
      GoRoute(
        path: '/onboarding/birthday',
        name: 'onboardingBirthday',
        builder: (context, state) => const OnboardingBirthdayScreen(),
      ),
      GoRoute(
        path: '/onboarding/mobile',
        name: 'onboardingMobile',
        builder: (context, state) => const OnboardingMobileScreen(),
      ),
      GoRoute(
        path: '/onboarding/mobile-otp',
        name: 'onboardingMobileOtp',
        builder: (context, state) => const OnboardingMobileOtpScreen(),
      ),
      GoRoute(
        path: '/onboarding/picture',
        name: 'onboardingPicture',
        builder: (context, state) => const ProfilePictureScreen(),
      ),
      // Note: Onboarding permissions/settings routes removed - permissions requested in context
      // GoRoute(
      //   path: '/onboarding/permissions',
      //   name: 'onboardingPermissions',
      //   builder: (context, state) => const PermissionsScreen(),
      // ),
      // GoRoute(
      //   path: '/onboarding/settings',
      //   name: 'onboardingSettings',
      //   builder: (context, state) => const OnboardingSettingsScreen(),
      // ),
      GoRoute(
        path: '/onboarding/success',
        name: 'onboardingSuccess',
        builder: (context, state) => const OnboardingSuccessScreen(),
      ),
      GoRoute(
        path: '/onboarding/profile',
        name: 'profileSetup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/onboarding/pin-setup',
        name: 'onboardingPinSetup',
        builder: (context, state) => const PinSetupScreen(),
      ),

      // Pots screen (standalone, outside bottom nav)
      GoRoute(
        path: '/pots',
        name: 'pots',
        builder: (context, state) => const PotsScreen(),
      ),

      // QR Scanner (standalone, outside bottom nav)
      GoRoute(
        path: '/scan',
        name: 'qrScanner',
        builder: (context, state) => const QrScannerScreen(),
      ),

      // Groups screens (standalone, outside bottom nav)
      GoRoute(
        path: '/groups',
        name: 'groups',
        builder: (context, state) => const GroupsListScreen(),
        routes: [
          // Create group
          GoRoute(
            path: 'create',
            name: 'createGroup',
            builder: (context, state) => const CreateGroupScreen(),
          ),
          // Group detail
          GoRoute(
            path: ':groupId',
            name: 'groupDetail',
            builder: (context, state) {
              final groupId = state.pathParameters['groupId'] ?? '';
              return GroupDetailScreen(groupId: groupId);
            },
            routes: [
              // Contribute to group
              GoRoute(
                path: 'contribute',
                name: 'groupContribute',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId'] ?? '';
                  return GroupTransactionScreen(
                    groupId: groupId,
                    type: TransactionType.contribute,
                  );
                },
              ),
              // Withdraw from group
              GoRoute(
                path: 'withdraw',
                name: 'groupWithdraw',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId'] ?? '';
                  return GroupTransactionScreen(
                    groupId: groupId,
                    type: TransactionType.withdraw,
                  );
                },
              ),
              // Pending approvals
              GoRoute(
                path: 'approvals',
                name: 'groupApprovals',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId'] ?? '';
                  return groups.PendingApprovalsScreen(groupId: groupId);
                },
              ),
            ],
          ),
        ],
      ),

      // =============================================
      // Main app with bottom navigation (5 tabs)
      // =============================================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // ---- Tab 0: Home ----
          StatefulShellBranch(
            navigatorKey: _homeNavKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  // 6.1) What is eMaliChat
                  GoRoute(
                    path: 'what-is-emalichat',
                    name: 'whatIsEMaliChat',
                    builder: (context, state) =>
                        const WhatIsEMaliChatScreen(),
                  ),
                  // 6.2) How to Earn
                  GoRoute(
                    path: 'how-to-earn',
                    name: 'howToEarn',
                    builder: (context, state) => const HowToEarnScreen(),
                  ),
                  // 6.3) The Bonus Network
                  GoRoute(
                    path: 'bonus-network',
                    name: 'bonusNetwork',
                    builder: (context, state) =>
                        const BonusNetworkScreen(),
                  ),
                  // 6.4) Upgrade Status
                  GoRoute(
                    path: 'upgrade-status',
                    name: 'upgradeStatus',
                    builder: (context, state) =>
                        const UpgradeStatusScreen(),
                  ),
                  // 6.5) Profile
                  GoRoute(
                    path: 'profile',
                    name: 'profile',
                    builder: (context, state) => ProfileScreen(
                      sourceTab: state.extra as String?,
                    ),
                    routes: [
                      GoRoute(
                        path: 'referrals',
                        name: 'referrals',
                        builder: (context, state) =>
                            const ReferralScreen(),
                      ),
                      GoRoute(
                        path: 'edit',
                        name: 'editProfile',
                        builder: (context, state) =>
                            const EditProfileScreen(),
                      ),
                      GoRoute(
                        path: 'contacts',
                        name: 'profileContacts',
                        builder: (context, state) => Scaffold(
                          appBar: AppBar(title: const Text('Contacts')),
                          body: const ContactsTab(),
                        ),
                      ),
                      GoRoute(
                        path: 'settings',
                        name: 'settings',
                        builder: (context, state) =>
                            const SettingsScreen(),
                      ),
                      GoRoute(
                        path: 'notifications',
                        name: 'notificationSettings',
                        builder: (context, state) =>
                            const NotificationSettingsScreen(),
                      ),
                      GoRoute(
                        path: 'security',
                        name: 'securitySettings',
                        builder: (context, state) =>
                            const SecuritySettingsScreen(),
                      ),
                      GoRoute(
                        path: 'privacy',
                        name: 'privacySettings',
                        builder: (context, state) =>
                            const PrivacySettingsScreen(),
                      ),
                      GoRoute(
                        path: 'help',
                        name: 'helpSupport',
                        builder: (context, state) =>
                            const HelpSupportScreen(),
                      ),
                      GoRoute(
                        path: 'about',
                        name: 'about',
                        builder: (context, state) => const AboutScreen(),
                      ),
                      GoRoute(
                        path: 'kyc',
                        name: 'kycVerification',
                        builder: (context, state) =>
                            const KycVerificationScreen(),
                      ),
                      // Gift History
                      GoRoute(
                        path: 'gift-history',
                        name: 'giftHistory',
                        builder: (context, state) =>
                            const GiftHistoryScreen(),
                      ),
                      // User QR Code
                      GoRoute(
                        path: 'qr-code',
                        name: 'userQrCode',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>? ?? {};
                          return QrDisplayScreen(
                            qrData:
                                'imali://user/${extra['userId'] ?? ''}',
                            title: extra['displayName'] as String? ??
                                'My QR Code',
                            subtitle: 'Scan to start a conversation',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ---- Tab 1: Earn ----
          StatefulShellBranch(
            navigatorKey: _earnNavKey,
            routes: [
              GoRoute(
                path: '/earn',
                name: 'earn',
                builder: (context, state) => const EarnScreen(),
                routes: [
                  // 7.1) Thread Detail (opportunities list)
                  GoRoute(
                    path: 'thread/:threadId',
                    name: 'earnThread',
                    builder: (context, state) {
                      final threadId =
                          state.pathParameters['threadId'] ?? '';
                      return EarnThreadScreen(threadId: threadId);
                    },
                  ),
                  // 7.2) Opportunity / Interaction Screen
                  GoRoute(
                    path: 'opportunity/:opportunityId',
                    name: 'earnOpportunity',
                    builder: (context, state) {
                      final opportunityId =
                          state.pathParameters['opportunityId'] ?? '';
                      return EarnInteractionScreen(
                          opportunityId: opportunityId);
                    },
                    routes: [
                      // 7.2.1) Earn Wallet Confirm
                      GoRoute(
                        path: 'confirm',
                        name: 'earnWalletConfirm',
                        builder: (context, state) =>
                            const EarnWalletConfirmScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ---- Tab 2: Chat (Unified Messaging) ----
          StatefulShellBranch(
            navigatorKey: _chatNavKey,
            routes: [
              GoRoute(
                path: '/chat',
                name: 'chat',
                builder: (context, state) => const MessagingScreen(),
                routes: [
                  // 8.0) New Chat - Contact Picker
                  GoRoute(
                    path: 'new',
                    name: 'newChat',
                    builder: (context, state) =>
                        const ContactPickerScreen(),
                  ),
                  // 8.0a) Pick single contact (returns Map<String, String>)
                  GoRoute(
                    path: 'pick-contact',
                    name: 'pickContact',
                    builder: (context, state) =>
                        const ContactPickerScreen(returnContact: true),
                  ),
                  // 8.0b) Pick multiple contacts (returns List<Map<String, String>>)
                  GoRoute(
                    path: 'pick-contacts',
                    name: 'pickContacts',
                    builder: (context, state) =>
                        const ContactPickerScreen(
                            returnContact: true, multiSelect: true),
                  ),
                  // 8.0.1) Message Requests
                  GoRoute(
                    path: 'requests',
                    name: 'messageRequests',
                    builder: (context, state) =>
                        const MessageRequestsScreen(),
                  ),
                  // 8.0.2) Contact Requests
                  GoRoute(
                    path: 'contact-requests',
                    name: 'contactRequests',
                    builder: (context, state) =>
                        const ContactRequestsScreen(),
                  ),
                  // 8.0.3) Import Phone Contacts
                  GoRoute(
                    path: 'import-contacts',
                    name: 'importContacts',
                    builder: (context, state) =>
                        const ImportContactsScreen(),
                  ),
                  // 8.0.4) Brand Accounts
                  GoRoute(
                    path: 'brand-accounts',
                    name: 'brandAccounts',
                    builder: (context, state) =>
                        const BrandAccountsScreen(),
                  ),
                  // 8.1) P2P Conversation Detail
                  GoRoute(
                    path: 'conversation/:conversationId',
                    name: 'conversationDetail',
                    builder: (context, state) {
                      final conversationId =
                          state.pathParameters['conversationId'] ?? '';
                      return ConversationDetailScreen(
                          conversationId: conversationId);
                    },
                    routes: [
                      // 8.1.1) Send Gift in Conversation
                      GoRoute(
                        path: 'send-gift',
                        name: 'conversationSendGift',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>? ?? {};
                          return GiftComposerScreen(
                            conversationId:
                                state.pathParameters['conversationId'],
                            recipientId:
                                extra['recipientId'] as String?,
                            recipientName:
                                extra['recipientName'] as String?,
                          );
                        },
                      ),
                      // 8.1.2) Open Gift (full-screen animated reveal)
                      GoRoute(
                        path: 'open-gift',
                        name: 'conversationOpenGift',
                        builder: (context, state) {
                          final gift = state.extra as Gift;
                          return GiftOpeningScreen(gift: gift);
                        },
                      ),
                      // 8.1.3) Full-screen image viewer
                      GoRoute(
                        path: 'image-viewer',
                        name: 'imageViewer',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>? ?? {};
                          return ImageViewerScreen(
                            messageId:
                                extra['messageId'] as String? ?? '',
                            imageUrl:
                                extra['imageUrl'] as String? ?? '',
                            mediaKeyBase64:
                                extra['mediaKeyBase64'] as String?,
                          );
                        },
                      ),
                      // 8.1.4) Voice/Video Call
                      GoRoute(
                        path: 'call/:callId',
                        name: 'conversationCall',
                        builder: (context, state) {
                          final callId =
                              state.pathParameters['callId'] ?? '';
                          final extra =
                              state.extra as Map<String, dynamic>? ?? {};
                          final isVideo =
                              extra['isVideo'] as bool? ?? false;
                          if (isVideo) {
                            return VideoCallScreen(callId: callId);
                          }
                          return VoiceCallScreen(callId: callId);
                        },
                      ),
                    ],
                  ),
                  // 8.2) Community Detail (tabbed: Chat/Members/Finances)
                  GoRoute(
                    path: 'community/:communityId',
                    name: 'communityDetail',
                    builder: (context, state) {
                      final communityId =
                          state.pathParameters['communityId'] ?? '';
                      return CommunityDetailScreen(
                          communityId: communityId);
                    },
                    routes: [
                      // 8.2.1) Community Settings
                      GoRoute(
                        path: 'settings',
                        name: 'communitySettings',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return CommunitySettingsScreen(
                              communityId: communityId);
                        },
                      ),
                      // 8.2.2) Community Members
                      GoRoute(
                        path: 'members',
                        name: 'communityMembers',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return CommunityMembersScreen(
                              communityId: communityId);
                        },
                      ),
                      // 8.2.3) Invite Member
                      GoRoute(
                        path: 'invite',
                        name: 'communityInvite',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return InviteMemberScreen(
                              communityId: communityId);
                        },
                      ),
                      // 8.2.4) Contribute
                      GoRoute(
                        path: 'contribute',
                        name: 'communityContribute',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return CommunityTransactionScreen(
                            communityId: communityId,
                            type: CommunityTransactionType.contribute,
                          );
                        },
                      ),
                      // 8.2.5) Withdraw
                      GoRoute(
                        path: 'withdraw',
                        name: 'communityWithdraw',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return CommunityTransactionScreen(
                            communityId: communityId,
                            type: CommunityTransactionType.withdraw,
                          );
                        },
                      ),
                      // 8.2.6) Pending Approvals
                      GoRoute(
                        path: 'approvals',
                        name: 'communityApprovals',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          return PendingApprovalsScreen(
                              communityId: communityId);
                        },
                      ),
                      // 8.2.7) Spray Detail (live-updating progress + contribute)
                      GoRoute(
                        path: 'spray/:sprayId',
                        name: 'sprayDetail',
                        builder: (context, state) {
                          final communityId =
                              state.pathParameters['communityId'] ?? '';
                          final sprayId =
                              state.pathParameters['sprayId'] ?? '';
                          return SprayDetailScreen(
                            sprayId: sprayId,
                            communityId: communityId,
                          );
                        },
                      ),
                    ],
                  ),
                  // 8.3) Create Community
                  GoRoute(
                    path: 'create-community',
                    name: 'createCommunity',
                    builder: (context, state) => CreateCommunityScreen(
                        initialType: state.extra as CommunityType?),
                  ),
                  // 8.4) Chat Send Wallet Selection (legacy token send flow)
                  GoRoute(
                    path: 'send-wallet',
                    name: 'chatSendWallet',
                    builder: (context, state) =>
                        const ChatSendWalletSelectionScreen(),
                  ),
                  // 8.5) Chat Send Amount Selection
                  GoRoute(
                    path: 'send-amount',
                    name: 'chatSendAmount',
                    builder: (context, state) =>
                        const ChatSendAmountScreen(),
                    routes: [
                      // 8.5.1) Chat Send Success
                      GoRoute(
                        path: 'success',
                        name: 'chatSendSuccess',
                        builder: (context, state) =>
                            const ChatSendSuccessScreen(),
                      ),
                      // 8.5.2) Chat Send Failure
                      GoRoute(
                        path: 'failure',
                        name: 'chatSendFailure',
                        builder: (context, state) =>
                            const ChatSendFailureScreen(),
                      ),
                    ],
                  ),
                  // 8.6) Bonus Network
                  GoRoute(
                    path: 'bonus-network',
                    name: 'chatBonusNetwork',
                    builder: (context, state) =>
                        const ChatBonusNetworkScreen(),
                    routes: [
                      // 8.6.1) Bonus Network Invite
                      GoRoute(
                        path: 'invite',
                        name: 'chatBonusNetworkInvite',
                        builder: (context, state) =>
                            const ChatBonusNetworkInviteScreen(),
                      ),
                    ],
                  ),
                  // 8.7) Sasaza Chooser (One-to-One vs Group)
                  GoRoute(
                    path: 'sasaza',
                    name: 'sasazaChooser',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      return SasazaChooserScreen(
                        recipientId:
                            extra?['recipientId'] as String? ?? '',
                        recipientName:
                            extra?['recipientName'] as String? ?? '',
                        conversationId:
                            extra?['conversationId'] as String?,
                      );
                    },
                  ),
                  // 8.8) Create Collection Room (Pool) — sasaza mode
                  GoRoute(
                    path: 'create-pool',
                    name: 'createPool',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      final modeStr =
                          extra?['mode'] as String? ?? 'sasaza';
                      return CreatePoolScreen(
                        initialMode: modeStr == 'save'
                            ? PoolMode.save
                            : PoolMode.sasaza,
                        recipientId:
                            extra?['recipientId'] as String?,
                        recipientName:
                            extra?['recipientName'] as String?,
                        communityId:
                            extra?['communityId'] as String?,
                      );
                    },
                  ),
                  // 8.8b) Create Group Save — save mode
                  GoRoute(
                    path: 'create-group-save',
                    name: 'createGroupSave',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      return CreatePoolScreen(
                        initialMode: PoolMode.save,
                        communityId:
                            extra?['communityId'] as String?,
                      );
                    },
                  ),
                  // 8.8c) Standalone Send Gift (no conversation context)
                  GoRoute(
                    path: 'send-gift',
                    name: 'standaloneSendGift',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>? ?? {};
                      return GiftComposerScreen(
                        recipientId:
                            extra['recipientId'] as String?,
                        recipientName:
                            extra['recipientName'] as String?,
                      );
                    },
                  ),
                  // 8.8) Collection Room Detail
                  GoRoute(
                    path: 'pool/:poolId',
                    name: 'collectionRoom',
                    builder: (context, state) {
                      final poolId =
                          state.pathParameters['poolId'] ?? '';
                      return CollectionRoomScreen(poolId: poolId);
                    },
                  ),

                  // ── Gooi-Gooi routes ──
                  GoRoute(
                    path: 'gooi',
                    name: 'gooiList',
                    builder: (context, state) => const GooiListScreen(),
                    routes: [
                      GoRoute(
                        path: 'onboarding',
                        name: 'gooiOnboarding',
                        builder: (context, state) => const GooiOnboardingScreen(),
                      ),
                      GoRoute(
                        path: 'create',
                        name: 'gooiCreate',
                        builder: (context, state) => const GooiCreateScreen(),
                      ),
                      GoRoute(
                        path: ':groupId',
                        name: 'gooiDashboard',
                        builder: (context, state) {
                          final groupId = state.pathParameters['groupId'] ?? '';
                          return GooiDashboardScreen(groupId: groupId);
                        },
                        routes: [
                          GoRoute(
                            path: 'invite',
                            name: 'gooiInvite',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiInviteScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'roster',
                            name: 'gooiRoster',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiRosterScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'bidding',
                            name: 'gooiBidding',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiBiddingScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'confirm',
                            name: 'gooiConfirm',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiConfirmScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'delegate',
                            name: 'gooiDelegate',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiDelegateScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'history',
                            name: 'gooiHistory',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiHistoryScreen(groupId: groupId);
                            },
                          ),
                          GoRoute(
                            path: 'withdrawal-vote/:withdrawalId',
                            name: 'gooiWithdrawalVote',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              final withdrawalId = state.pathParameters['withdrawalId'] ?? '';
                              final extra = state.extra as Map<String, dynamic>? ?? {};
                              return GooiWithdrawalVoteScreen(
                                groupId: groupId,
                                withdrawalId: withdrawalId,
                                memberName: extra['memberName'] as String? ?? '',
                                reason: extra['reason'] as String?,
                              );
                            },
                          ),
                          GoRoute(
                            path: 'round-complete',
                            name: 'gooiRoundComplete',
                            builder: (context, state) {
                              final groupId = state.pathParameters['groupId'] ?? '';
                              return GooiRoundCompleteScreen(groupId: groupId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ---- Tab 3: Buy ----
          StatefulShellBranch(
            navigatorKey: _buyNavKey,
            routes: [
              GoRoute(
                path: '/buy',
                name: 'buy',
                builder: (context, state) => const BuyServicesScreen(),
                routes: [
                  // 10.1) Buy Wallet From Selection
                  GoRoute(
                    path: 'wallet-selection',
                    name: 'buyWalletSelection',
                    builder: (context, state) =>
                        const BuyWalletSelectionScreen(),
                    routes: [
                      // 10.1.1) Buy Success
                      GoRoute(
                        path: 'success',
                        name: 'buySuccess',
                        builder: (context, state) =>
                            const BuySuccessScreen(),
                      ),
                      // 10.1.2) Buy Failure
                      GoRoute(
                        path: 'failure',
                        name: 'buyFailure',
                        builder: (context, state) =>
                            const BuyFailureScreen(),
                      ),
                    ],
                  ),
                  // 10.2) Buy Transactions
                  GoRoute(
                    path: 'transactions',
                    name: 'buyTransactions',
                    builder: (context, state) =>
                        const BuyTransactionsScreen(),
                  ),
                  // 10.3) Buy Category drill-down
                  GoRoute(
                    path: 'category/:categoryId',
                    name: 'buyCategory',
                    builder: (context, state) {
                      final categoryId = state.pathParameters['categoryId']!;
                      final extra = state.extra as Map<String, dynamic>?;
                      return BuyCategoryScreen(
                        categoryId: categoryId,
                        categoryName: extra?['name'] as String?,
                        categoryEmoji: extra?['emoji'] as String?,
                        quickBuyProviderId:
                            extra?['quickBuyProviderId'] as String?,
                        quickBuyProductId:
                            extra?['quickBuyProductId'] as String?,
                        quickBuyRecipient:
                            extra?['quickBuyRecipient'] as String?,
                      );
                    },
                  ),
                  // 10.3b) Marketplace Subcategory drill-down
                  GoRoute(
                    path: 'subcategories/:categoryId',
                    name: 'buySubcategories',
                    builder: (context, state) {
                      final categoryId =
                          state.pathParameters['categoryId']!;
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      final subcategories =
                          extra?['subcategories'] as List<BuySubcategory>? ??
                              [];
                      return BuySubcategoryListScreen(
                        categoryId: categoryId,
                        categoryName:
                            extra?['name'] as String? ?? '',
                        categoryEmoji:
                            extra?['emoji'] as String? ?? '',
                        subcategories: subcategories,
                      );
                    },
                  ),
                  // 10.4) Purchase History
                  GoRoute(
                    path: 'history',
                    name: 'buyHistory',
                    builder: (context, state) =>
                        const BuyPurchaseHistoryScreen(),
                  ),
                  // 10.5) Brand Storefront
                  GoRoute(
                    path: 'brand/:storefrontId',
                    name: 'brandStorefront',
                    builder: (context, state) {
                      final storefrontId =
                          state.pathParameters['storefrontId']!;
                      final extra = state.extra as Map<String, dynamic>?;
                      final orderId = extra?['orderId'] as String?;
                      return BrandStorefrontScreen(
                        storefrontId: storefrontId,
                        orderId: orderId,
                      );
                    },
                    routes: [
                      // 10.5.1) Brand Product Detail
                      GoRoute(
                        path: 'product/:productId',
                        name: 'brandProductDetail',
                        builder: (context, state) {
                          final storefrontId =
                              state.pathParameters['storefrontId']!;
                          final productId =
                              state.pathParameters['productId']!;
                          final product =
                              state.extra as BrandProduct?;
                          return BrandProductDetailScreen(
                            storefrontId: storefrontId,
                            productId: productId,
                            product: product,
                          );
                        },
                      ),
                    ],
                  ),
                  // 10.6) Marketplace hub
                  GoRoute(
                    path: 'marketplace',
                    name: 'marketplace',
                    builder: (context, state) =>
                        const MarketplaceHubScreen(),
                    routes: [
                      // 10.6.1) Listing detail
                      GoRoute(
                        path: 'listing/:listingId',
                        name: 'marketplaceListing',
                        builder: (context, state) {
                          final listingId =
                              state.pathParameters['listingId']!;
                          return MarketplaceListingDetailScreen(
                            listingId: listingId,
                          );
                        },
                      ),
                      // 10.6.2) Provider profile
                      GoRoute(
                        path: 'provider/:providerId',
                        name: 'marketplaceProvider',
                        builder: (context, state) {
                          final providerId =
                              state.pathParameters['providerId']!;
                          return MarketplaceProviderProfileScreen(
                            providerId: providerId,
                          );
                        },
                      ),
                      // 10.6.3) Seller registration
                      GoRoute(
                        path: 'register',
                        name: 'sellerRegistration',
                        builder: (context, state) =>
                            const SellerRegistrationScreen(),
                      ),
                      // 10.6.3b) Edit seller profile
                      GoRoute(
                        path: 'edit-profile',
                        name: 'editSellerProfile',
                        builder: (context, state) =>
                            const EditSellerProfileScreen(),
                      ),
                      // 10.6.4) Create listing
                      GoRoute(
                        path: 'create-listing',
                        name: 'createListing',
                        builder: (context, state) =>
                            const CreateListingScreen(),
                      ),
                      // 10.6.5) My orders
                      GoRoute(
                        path: 'orders',
                        name: 'myOrders',
                        builder: (context, state) =>
                            const MyOrdersScreen(),
                        routes: [
                          // 10.6.5.1) Order detail
                          GoRoute(
                            path: ':orderId',
                            name: 'orderDetail',
                            builder: (context, state) {
                              final orderId =
                                  state.pathParameters['orderId']!;
                              return OrderDetailScreen(
                                  orderId: orderId);
                            },
                          ),
                        ],
                      ),
                      // 10.6.6) Make Offer
                      GoRoute(
                        path: 'make-offer',
                        name: 'makeOffer',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>;
                          return MakeOfferScreen(
                            listingId:
                                extra['listingId'] as String,
                            listingPriceTokens:
                                extra['listingPriceTokens'] as int,
                            listingTitle:
                                extra['listingTitle'] as String,
                          );
                        },
                      ),
                      // 10.6.7) Seller Dashboard
                      GoRoute(
                        path: 'seller-dashboard',
                        name: 'sellerDashboard',
                        builder: (context, state) =>
                            const SellerDashboardScreen(),
                      ),
                      // 10.6.8) Report listing or provider
                      GoRoute(
                        path: 'report/:targetType/:targetId',
                        name: 'marketplaceReport',
                        builder: (context, state) {
                          final targetType =
                              state.pathParameters['targetType']!;
                          final targetId =
                              state.pathParameters['targetId']!;
                          return MarketplaceReportScreen(
                            targetType: targetType,
                            targetId: targetId,
                          );
                        },
                      ),
                    ],
                  ),
                  // 10.7) Group buys (Hlangana)
                  GoRoute(
                    path: 'group-buys',
                    name: 'groupBuys',
                    builder: (context, state) =>
                        const GroupBuyListScreen(),
                    routes: [
                      // 10.7.1) Create group buy
                      GoRoute(
                        path: 'create',
                        name: 'createGroupBuy',
                        builder: (context, state) =>
                            const CreateGroupBuyScreen(),
                      ),
                      // 10.7.2) Community group buy create
                      GoRoute(
                        path: 'community-create',
                        name: 'communityGroupBuyCreate',
                        builder: (context, state) =>
                            const CommunityGroupBuyCreateScreen(),
                      ),
                      // 10.7.3) Group buy detail
                      GoRoute(
                        path: ':groupBuyId',
                        name: 'groupBuyDetail',
                        builder: (context, state) {
                          final groupBuyId =
                              state.pathParameters['groupBuyId']!;
                          return GroupBuyDetailScreen(
                            groupBuyId: groupBuyId,
                          );
                        },
                        routes: [
                          // 10.7.3a) Voucher redemption
                          GoRoute(
                            path: 'voucher',
                            name: 'groupBuyVoucher',
                            builder: (context, state) {
                              final groupBuyId =
                                  state.pathParameters['groupBuyId']!;
                              return GroupBuyVoucherScreen(
                                groupBuyId: groupBuyId,
                              );
                            },
                          ),
                          // 10.7.3b) Collection confirmation
                          GoRoute(
                            path: 'collection',
                            name: 'groupBuyCollection',
                            builder: (context, state) {
                              final groupBuyId =
                                  state.pathParameters['groupBuyId']!;
                              return GroupBuyCollectionScreen(
                                groupBuyId: groupBuyId,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // ---- Tab 5: Wallet ----
          StatefulShellBranch(
            navigatorKey: _walletNavKey,
            routes: [
              GoRoute(
                path: '/wallet',
                name: 'wallet',
                builder: (context, state) => const WalletScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:subAccountId',
                    name: 'walletDetail',
                    builder: (context, state) {
                      final subAccountId =
                          state.pathParameters['subAccountId'] ?? '';
                      return WalletDetailScreen(
                          subAccountId: subAccountId);
                    },
                  ),
                  GoRoute(
                    path: 'send',
                    name: 'walletSend',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      return WalletSendScreen(
                        subAccountId:
                            extra?['subAccountId'] as String?,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'amount',
                        name: 'walletSendAmount',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>?;
                          return WalletSendAmountScreen(
                            recipientUserId:
                                extra?['recipientUserId']
                                    as String? ??
                                    '',
                            recipientName:
                                extra?['recipientName']
                                    as String? ??
                                    'Unknown',
                            subAccountId:
                                extra?['subAccountId'] as String?,
                          );
                        },
                      ),
                      GoRoute(
                        path: 'success',
                        name: 'walletSendSuccess',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>?;
                          return WalletSendSuccessScreen(
                            amount: extra?['amount'] as int?,
                            recipientName:
                                extra?['recipientName'] as String?,
                          );
                        },
                      ),
                      GoRoute(
                        path: 'failure',
                        name: 'walletSendFailure',
                        builder: (context, state) {
                          final extra =
                              state.extra as Map<String, dynamic>?;
                          return WalletSendFailureScreen(
                            error: extra?['error'] as String?,
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'withdraw',
                    name: 'walletWithdraw',
                    builder: (context, state) =>
                        const CashoutScreen(),
                  ),
                  GoRoute(
                    path: 'transactions',
                    name: 'transactions',
                    builder: (context, state) =>
                        const TransactionHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'cashout',
                    name: 'cashout',
                    builder: (context, state) =>
                        const CashoutScreen(),
                  ),
                  GoRoute(
                    path: 'rewards',
                    name: 'walletRewards',
                    builder: (context, state) =>
                        const RewardsListScreen(),
                    routes: [
                      GoRoute(
                        path: ':rewardId',
                        name: 'rewardDetail',
                        builder: (context, state) {
                          final rewardId =
                              state.pathParameters['rewardId'] ?? '';
                          return RewardItemDetailScreen(
                              rewardId: rewardId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final needsOnboarding =
          authState.status == AuthStatus.onboardingRequired;
      final isSessionLocked =
          authState.status == AuthStatus.sessionLocked;
      final isInitial = authState.status == AuthStatus.initial;
      final isLoading = authState.status == AuthStatus.loading;

      final currentPath = state.matchedLocation;
      final isOnSplash = currentPath == '/';
      final isOnAuth = currentPath.startsWith('/auth') ||
          currentPath.startsWith('/welcome');
      final isOnOnboarding = currentPath.startsWith('/onboarding');
      final isOnSessionLock = currentPath == '/auth/session-lock';
      // Step-up OTP is used by already-authenticated users — never redirect away
      final isOnStepUpOtp = currentPath == '/auth/step-up-otp';

      // Don't redirect while loading or on initial state.
      // Allow auth screens to stay put during loading (e.g. OTP send in progress).
      if (isInitial || isLoading) {
        if (isOnSplash || isOnAuth) return null;
        return '/';
      }

      // Session locked — force to session lock screen
      if (isSessionLocked) {
        return isOnSessionLock ? null : '/auth/session-lock';
      }

      // If authenticated and on auth/onboarding pages, go to the last active
      // tab (or home by default). This restores the correct tab after Android
      // process death instead of always landing on Home.
      // Exceptions: step-up OTP and onboarding success (shown before redirect)
      final isOnOnboardingSuccess = currentPath == '/onboarding/success';
      if (isAuthenticated &&
          !isOnStepUpOtp &&
          !isOnOnboardingSuccess &&
          (isOnAuth || isOnOnboarding || isOnSplash)) {
        final savedTab = getIt<SharedPreferences>()
            .getInt(MainShell.lastTabKey);
        if (savedTab != null &&
            savedTab >= 0 &&
            savedTab < MainShell.tabPaths.length) {
          return MainShell.tabPaths[savedTab];
        }
        return '/home';
      }

      // If needs onboarding and not on onboarding pages, redirect to the
      // appropriate step based on what they've already completed.
      // Note: Terms acceptance is now handled on the age consent screen before
      // sign-up, so we skip the terms check and go directly to name entry.
      if (needsOnboarding && !isOnOnboarding) {
        final user = authState.user;
        final profile = user?.profile;
        if (profile == null ||
            profile.displayName.isEmpty ||
            profile.displayName == 'iMali User') {
          return '/onboarding/name';
        }
        // Name is set — send to extrainfo (all fields optional)
        return '/onboarding/extrainfo';
      }

      // If not authenticated and trying to access protected routes
      if (!isAuthenticated &&
          !needsOnboarding &&
          !isOnAuth &&
          !isOnOnboarding &&
          !isOnSplash) {
        return '/welcome';
      }

      return null;
    },
  );
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies listeners
/// when the stream emits.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription =
        stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
