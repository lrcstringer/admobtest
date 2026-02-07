import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    // Ensure minimum splash display time (2 seconds from start)
    await Future.delayed(const Duration(milliseconds: 2000));

    if (mounted) {
      context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.40;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          // Must navigate explicitly — the router redirect has a !isOnSplash
          // guard that prevents redirecting away from splash for unauth users.
          context.go('/welcome');
        }
        // For authenticated and onboardingRequired: the GoRouterRefreshStream
        // triggers a redirect re-evaluation when auth state changes. The router
        // redirect handles these cases (authenticated → /home,
        // onboardingRequired → smart onboarding step based on progress).
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.backgroundGradient,
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mascot face
                  SizedBox(
                    width: mascotSize,
                    height: mascotSize,
                    child: Image.asset(
                      'assets/icons/elephantFinal2.png',
                      width: mascotSize,
                      height: mascotSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/icons/ImaliFacewithText.png',
                          width: mascotSize,
                          height: mascotSize,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // "Welcome to iMaliChat!"
                  Text(
                    'Welcome to iMaliChat!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),

                  // "Earn. Chat. Buy."
                  Text(
                    'Earn. Chat. Buy.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
