import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/auth_bloc.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/phone_input_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/chat_detail_screen.dart';
import '../screens/earn/earn_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/main/main_shell.dart';
import '../screens/onboarding/profile_setup_screen.dart';
import '../screens/onboarding/terms_screen.dart';
import '../screens/buy/buy_services_screen.dart';
import '../screens/pots/pots_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/referral/referral_screen.dart';
import '../screens/settings/about_screen.dart';
import '../screens/settings/help_support_screen.dart';
import '../screens/settings/notification_settings_screen.dart';
import '../screens/settings/security_settings_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/wallet/cashout_screen.dart';
import '../screens/wallet/transaction_history_screen.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth/phone',
        name: 'phone',
        builder: (context, state) => const PhoneInputScreen(),
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

      // Onboarding routes
      GoRoute(
        path: '/onboarding/terms',
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),
      GoRoute(
        path: '/onboarding/profile',
        name: 'profileSetup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Main app with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Home tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'transactions',
                    name: 'transactions',
                    builder: (context, state) => const TransactionHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'cashout',
                    name: 'cashout',
                    builder: (context, state) => const CashoutScreen(),
                  ),
                  GoRoute(
                    path: 'buy',
                    name: 'buy',
                    builder: (context, state) => const BuyServicesScreen(),
                  ),
                ],
              ),
            ],
          ),
          // Earn tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/earn',
                name: 'earn',
                builder: (context, state) => const EarnScreen(),
              ),
            ],
          ),
          // Chat tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                name: 'chat',
                builder: (context, state) => const ChatScreen(),
                routes: [
                  GoRoute(
                    path: ':threadId',
                    name: 'chatDetail',
                    builder: (context, state) {
                      final threadId = state.pathParameters['threadId'] ?? '';
                      return ChatDetailScreen(threadId: threadId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Pots tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pots',
                name: 'pots',
                builder: (context, state) => const PotsScreen(),
              ),
            ],
          ),
          // Profile tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'referrals',
                    name: 'referrals',
                    builder: (context, state) => const ReferralScreen(),
                  ),
                  GoRoute(
                    path: 'edit',
                    name: 'editProfile',
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    name: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'notifications',
                    name: 'notificationSettings',
                    builder: (context, state) => const NotificationSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'security',
                    name: 'securitySettings',
                    builder: (context, state) => const SecuritySettingsScreen(),
                  ),
                  GoRoute(
                    path: 'help',
                    name: 'helpSupport',
                    builder: (context, state) => const HelpSupportScreen(),
                  ),
                  GoRoute(
                    path: 'about',
                    name: 'about',
                    builder: (context, state) => const AboutScreen(),
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
      final needsOnboarding = authState.status == AuthStatus.onboardingRequired;
      final isInitial = authState.status == AuthStatus.initial;
      final isLoading = authState.status == AuthStatus.loading;

      final currentPath = state.matchedLocation;
      final isOnSplash = currentPath == '/';
      final isOnAuth = currentPath.startsWith('/auth') ||
          currentPath.startsWith('/welcome');
      final isOnOnboarding = currentPath.startsWith('/onboarding');

      // Don't redirect while loading or on splash
      if (isInitial || isLoading) {
        return isOnSplash ? null : '/';
      }

      // If authenticated and on auth/onboarding pages, go to home
      if (isAuthenticated && (isOnAuth || isOnOnboarding || isOnSplash)) {
        return '/home';
      }

      // If needs onboarding and not on onboarding pages, redirect
      if (needsOnboarding && !isOnOnboarding) {
        return '/onboarding/terms';
      }

      // If not authenticated and trying to access protected routes
      if (!isAuthenticated && !needsOnboarding && !isOnAuth && !isOnSplash) {
        return '/welcome';
      }

      return null;
    },
  );
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies listeners when the stream emits.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
