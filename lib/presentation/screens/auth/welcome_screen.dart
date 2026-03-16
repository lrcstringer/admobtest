import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../core/config/auth_test_config.dart';
import '../../../core/error/failures.dart';
import '../../../core/services/biometric_login_service.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final _biometricService = GetIt.instance<BiometricLoginService>();

  bool _isReturningUser = false;
  String? _displayName;
  bool _isBiometricLoading = false;
  String? _biometricError;

  // Intro video (first-launch only)
  static const _kFirstLaunchKey = 'welcome_video_shown';
  VideoPlayerController? _videoController;
  bool _showVideo = false;
  bool _videoPlaying = false;
  bool _videoFinished = false;
  bool _videoInitialized = false;

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
    _checkReturningUser();
    _initVideoIfFirstLaunch();
  }

  Future<void> _initVideoIfFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_kFirstLaunchKey) == true) return;

    // Mark as shown immediately so interrupted sessions don't replay
    await prefs.setBool(_kFirstLaunchKey, true);

    if (!mounted) return;
    setState(() => _showVideo = true);

    final controller =
        VideoPlayerController.asset('assets/video/AyandaWelcomeVid_cropped.mp4');
    _videoController = controller;

    await controller.initialize();
    if (!mounted) return;
    setState(() => _videoInitialized = true);

    // Detect playback completion
    controller.addListener(_onVideoPlaybackChanged);
  }

  void _onVideoPlaybackChanged() {
    final c = _videoController;
    if (c == null || _videoFinished) return;

    final pos = c.value.position;
    final dur = c.value.duration;
    if (dur.inMilliseconds > 0 &&
        pos.inMilliseconds > 0 &&
        !c.value.isPlaying &&
        (dur - pos).inMilliseconds < 500) {
      setState(() => _videoFinished = true);
    }
  }

  void _disposeVideo() {
    _videoController?.removeListener(_onVideoPlaybackChanged);
    _videoController?.dispose();
    _videoController = null;
  }

  Future<void> _checkReturningUser() async {
    // Respect dev test mode
    if (kDebugMode) {
      if (AuthTestConfig.mode == AuthTestMode.forceWelcome ||
          AuthTestConfig.mode == AuthTestMode.forceOtp ||
          AuthTestConfig.mode == AuthTestMode.forcePushLogin) {
        return; // Show standard welcome
      }
      if (AuthTestConfig.mode == AuthTestMode.forceBiometric) {
        setState(() {
          _isReturningUser = true;
          _displayName = 'Test User';
        });
        return;
      }
    }

    final canUse = await _biometricService.canUseBiometricLogin();
    if (!canUse || !mounted) return;

    final name = await _biometricService.getStoredDisplayName();
    if (!mounted) return;

    setState(() {
      _isReturningUser = true;
      _displayName = name;
    });
  }

  Future<void> _handleBiometricLogin() async {
    setState(() {
      _isBiometricLoading = true;
      _biometricError = null;
    });

    final result = await _biometricService.attemptBiometricLogin();

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isBiometricLoading = false;
          _biometricError = failure.displayMessage;
        });
      },
      (customToken) {
        // Cache display name for next time
        if (_displayName != null) {
          _biometricService.cacheDisplayName(_displayName!);
        }
        // Use existing push token auth handler (signs in with custom token)
        context.read<AuthBloc>().add(
              AuthEvent.authenticateWithPushToken(customToken: customToken),
            );
      },
    );
  }

  /// Debug-only dialog: paste a custom auth token to sign in as any user.
  void _showDebugTokenDialog() {
    final tokenController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Debug Token Sign-In'),
        content: TextField(
          controller: tokenController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Paste custom auth token here',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final token = tokenController.text.trim();
              if (token.isEmpty) return;
              Navigator.of(ctx).pop();
              context.read<AuthBloc>().add(
                    AuthEvent.authenticateWithPushToken(customToken: token),
                  );
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposeVideo();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.48;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          // Cache display name for next biometric login
          final name = state.user?.displayName;
          if (name != null && name.isNotEmpty && name != 'iMali User') {
            _biometricService.cacheDisplayName(name);
          }
          // Router redirect handles navigation to /home
        } else if (state.status == AuthStatus.onboardingRequired) {
          // Router redirect handles smart onboarding routing
          // (checks which steps are already complete)
        } else if (state.status == AuthStatus.error) {
          setState(() {
            _isBiometricLoading = false;
            _biometricError = state.errorMessage ?? 'Sign-in failed';
          });
        }
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.themed(context).tabGradient,
            ),
          ),
          child: Stack(
            children: [
              // Layer 1: Feather wave at the top (max 25% of screen height)

              // Layer 2: Main content
              Positioned.fill(
                child: SafeArea(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _isReturningUser
                        ? _buildReturningUserContent(context, size, mascotSize)
                        : _buildNewUserContent(context, size, mascotSize),
                  ),
                ),
              ),

              // Debug mode badge (tap = cycle auth mode, long-press = token sign-in)
              if (kDebugMode)
                Positioned(
                  top: 50,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      final newMode = AuthTestConfig.cycleMode();
                      // Re-check returning user state
                      setState(() {
                        _isReturningUser = false;
                        _displayName = null;
                        _biometricError = null;
                      });
                      _checkReturningUser();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Auth mode: ${newMode.name}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onLongPress: _showDebugTokenDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        AuthTestConfig.mode.badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
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

  /// Standard welcome content for new users or users without device binding.
  Widget _buildNewUserContent(
      BuildContext context, Size size, double mascotSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
        SizedBox(height: size.height * 0.02),

        // Mascot face
        SizedBox(
          width: mascotSize,
          height: mascotSize,
          child: Image.asset(
            'assets/icons/iMaliCrown4.png',
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
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Welcome to ',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: 'iMali',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: 'Chat!',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),

        // "Earn. Chat. Buy."
        Text(
          'Earn. Chat. Buy.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'izandla ziyagezana',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.5,
              ),
        ),

        SizedBox(height: size.height * 0.03),

        // Intro video (first-launch only)
        if (_showVideo && _videoController != null)
          AnimatedOpacity(
            opacity: _videoFinished ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            onEnd: () {
              if (_videoFinished) {
                setState(() {
                  _showVideo = false;
                  _disposeVideo();
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: size.height * 0.02,
              ),
              child: GestureDetector(
                onTap: () {
                  if (!_videoPlaying && _videoInitialized) {
                    _videoController!.play();
                    setState(() => _videoPlaying = true);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: _videoInitialized
                        ? _videoController!.value.aspectRatio
                        : 16 / 9,
                    child: _videoInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              // Video with cover fit
                              SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: _videoController!.value.size.width,
                                    height: _videoController!.value.size.height,
                                    child: VideoPlayer(_videoController!),
                                  ),
                                ),
                              ),
                              // Play button overlay
                              if (!_videoPlaying)
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          )
                        : Container(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

        // Bullet points
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              _buildBulletPoint(context, 'Watch short ads to earn tokens'),
              const SizedBox(height: 10),
              _buildBulletPoint(context, 'Answer quick surveys for cash'),
              const SizedBox(height: 10),
              _buildBulletPoint(context, 'Join daily prize pots & win big'),
            ],
          ),
        ),

        SizedBox(height: size.height * 0.06),

        // "Get Started" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: AppButton(
            text: 'Get Started',
            onPressed: () => context.go('/auth/age-consent'),
            size: AppButtonSize.large,
          ),
        ),

        const SizedBox(height: 16),

        // "Already have an account? Log in" - secondary text button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => context.go('/auth/age-consent'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withValues(alpha: 0.3),
                foregroundColor: const Color(0xFF0D1028),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text.rich(
                TextSpan(
                  text: 'Have an account? ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: size.height * 0.04),
        ],
      ),
    );
  }

  /// Returning user content with biometric sign-in.
  Widget _buildReturningUserContent(
      BuildContext context, Size size, double mascotSize) {
    final greeting = _displayName != null && _displayName!.isNotEmpty
        ? 'Welcome back,\n$_displayName!'
        : 'Welcome back!';

    return Column(
      children: [
        SizedBox(height: size.height * 0.02),

        // Mascot face
        SizedBox(
          width: mascotSize,
          height: mascotSize,
          child: Image.asset(
            'assets/icons/iMaliCrown4.png',
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

        // "Welcome back, [Name]!"
        Text(
          greeting,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),

        // "Earn. Chat. Buy."
        Text(
          'Earn. Chat. Buy.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
        ),

        SizedBox(height: size.height * 0.06),

        // Biometric sign-in button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: AppButton(
            text: 'Sign in',
            onPressed: _handleBiometricLogin,
            isLoading: _isBiometricLoading,
            icon: Icons.fingerprint,
            size: AppButtonSize.large,
          ),
        ),

        // Error message
        if (_biometricError != null) ...[
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              _biometricError!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.redAccent,
                  ),
            ),
          ),
        ],

        SizedBox(height: size.height * 0.03),

        // "Use OTP instead"
        GestureDetector(
          onTap: () => context.go('/auth/phone', extra: {
            'skipPushLogin': true,
          }),
          child: Text(
            'Use OTP instead',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),

        const Spacer(),

        // "Not you?" switch to new user mode
        GestureDetector(
          onTap: () {
            setState(() {
              _isReturningUser = false;
              _biometricError = null;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Not ${_displayName ?? 'you'}? Sign in with a different account',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.textSecondary,
                  ),
            ),
          ),
        ),
      ],
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
