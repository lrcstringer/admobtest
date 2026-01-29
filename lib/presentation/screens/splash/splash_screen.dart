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

    // TODO: Re-enable auth check after splash design is finalized
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   if (mounted) {
    //     context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
    //   }
    // });
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
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        } else if (state.status == AuthStatus.onboardingRequired) {
          context.go('/onboarding/terms');
        } else if (state.status == AuthStatus.unauthenticated) {
          context.go('/welcome');
        }
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
          child: Stack(
            children: [
              // Layer 1: Blue wave at the top (behind light blue)
              // Image is 375x550; constrain to 60% of screen height
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: size.height * 0.60,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/Top Blue Wave.png',
                    width: size.width,
                    height: size.height * 0.60,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Layer 2: Light blue wave overlaying dark blue at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Top Light Blue.png',
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),

              // Layer 3: Yellow wave at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Bottom Yellow Wave.png',
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),

              // Layer 4: Main content
              Positioned.fill(
                child: SafeArea(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),

                        // Mascot face - 30% of screen width
                        SizedBox(
                          width: mascotSize,
                          height: mascotSize,
                          child: Image.asset(
                            'assets/logo-assets/mascot-bubbles-512.png',
                            width: mascotSize,
                            height: mascotSize,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback if logo-assets not bundled yet
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

                        SizedBox(height: size.height * 0.03),

                        // Bullet points
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              _buildBulletPoint(
                                context,
                                'Watch short ads to earn tokens',
                              ),
                              const SizedBox(height: 10),
                              _buildBulletPoint(
                                context,
                                'Answer quick surveys for cash',
                              ),
                              const SizedBox(height: 10),
                              _buildBulletPoint(
                                context,
                                'Join daily prize pots & win big',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.06),

                        // "Get Started" button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () => context.go('/auth/phone'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.03),

                        // "Already have an account?"
                        Text(
                          'Already have an account?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        // "Log in." - tappable link
                        GestureDetector(
                          onTap: () => context.go('/auth/login'),
                          child: Text(
                            'Log in.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.textPrimary,
                                ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: AppColors.logoGradient,
            ),
          ),
          child: const Icon(
            Icons.check,
            size: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.9),
                  height: 1.3,
                ),
          ),
        ),
      ],
    );
  }
}
