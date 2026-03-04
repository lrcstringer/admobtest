import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/auth_bloc.dart';

// Auth screens
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/phone_input_screen.dart';
import '../screens/auth/challenge_approval_screen.dart';
import '../screens/auth/push_login_screen.dart';
import '../screens/auth/session_lock_screen.dart';
import '../screens/auth/step_up_otp_screen.dart';
import '../screens/auth/age_consent_screen.dart';
import '../screens/auth/privacy_policy_screen.dart';
import '../screens/auth/terms_of_service_screen.dart';
import '../screens/auth/welcome_screen.dart';

// Buy screens
import '../screens/buy/buy_failure_screen.dart';
import '../screens/buy/buy_services_screen.dart';
import '../screens/buy/buy_success_screen.dart';
import '../screens/buy/buy_transactions_screen.dart';
import '../screens/buy/buy_wallet_selection_screen.dart';

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
  static final _walletNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'walletTab');
  static final _buyNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'buyTab');

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
            skipPushLogin: extra?['skipPushLogin'] as bool? ?? false,
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

      // Push-based login flow
      GoRoute(
        path: '/auth/push-login',
        name: 'pushLogin',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PushLoginScreen(
            challengeId: extra?['challengeId'] ?? '',
            phoneNumber: extra?['phoneNumber'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/auth/challenge-approval',
        name: 'challengeApproval',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ChallengeApprovalScreen(
            challengeId: extra?['challengeId'] ?? '',
            nonce: extra?['nonce'] ?? '',
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
                    builder: (context, state) => const ProfileScreen(),
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
                                extra['recipientId'] as String? ?? '',
                            recipientName:
                                extra['recipientName'] as String? ??
                                    'User',
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
                  // 8.8) Create Collection Room (Pool)
                  GoRoute(
                    path: 'create-pool',
                    name: 'createPool',
                    builder: (context, state) {
                      final extra =
                          state.extra as Map<String, dynamic>?;
                      return CreatePoolScreen(
                        recipientId:
                            extra?['recipientId'] as String?,
                        recipientName:
                            extra?['recipientName'] as String?,
                        communityId:
                            extra?['communityId'] as String?,
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
                ],
              ),
            ],
          ),

          // ---- Tab 3: Wallet ----
          StatefulShellBranch(
            navigatorKey: _walletNavKey,
            routes: [
              GoRoute(
                path: '/wallet',
                name: 'wallet',
                builder: (context, state) => const WalletScreen(),
                routes: [
                  // 9.1) Wallet Detail (single wallet view)
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
                  // 9.2) Wallet Send (contact picker)
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
                      // 9.2.1) Wallet Send Amount
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
                      // 9.2.2) Wallet Send Success
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
                      // 9.2.3) Wallet Send Failure
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
                  // 9.3) Wallet Withdraw (Cash Out)
                  GoRoute(
                    path: 'withdraw',
                    name: 'walletWithdraw',
                    builder: (context, state) =>
                        const CashoutScreen(),
                  ),
                  // 9.4) Transaction History
                  GoRoute(
                    path: 'transactions',
                    name: 'transactions',
                    builder: (context, state) =>
                        const TransactionHistoryScreen(),
                  ),
                  // 9.5) Cashout (legacy route alias)
                  GoRoute(
                    path: 'cashout',
                    name: 'cashout',
                    builder: (context, state) =>
                        const CashoutScreen(),
                  ),
                  // 9.6) Rewards list
                  GoRoute(
                    path: 'rewards',
                    name: 'walletRewards',
                    builder: (context, state) =>
                        const RewardsListScreen(),
                    routes: [
                      // 9.6.1) Reward item detail
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

          // ---- Tab 4: Buy ----
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

      // If authenticated and on auth/onboarding pages, go to home
      // Exceptions: step-up OTP and onboarding success (shown before redirect)
      final isOnOnboardingSuccess = currentPath == '/onboarding/success';
      if (isAuthenticated &&
          !isOnStepUpOtp &&
          !isOnOnboardingSuccess &&
          (isOnAuth || isOnOnboarding || isOnSplash)) {
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
