import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/fcm_challenge_handler.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';

/// Waiting screen shown after a push login request is sent.
///
/// Displays a countdown timer and listens for real-time challenge
/// status updates via Firestore. Provides an "Use OTP instead" fallback.
class PushLoginScreen extends StatefulWidget {
  final String challengeId;
  final String phoneNumber;

  const PushLoginScreen({
    super.key,
    required this.challengeId,
    required this.phoneNumber,
  });

  @override
  State<PushLoginScreen> createState() => _PushLoginScreenState();
}

class _PushLoginScreenState extends State<PushLoginScreen> {
  final _challengeHandler = GetIt.instance<FcmChallengeHandler>();

  StreamSubscription<({String status, String? customToken, String? nonce})>?
      _statusSubscription;
  Timer? _countdownTimer;
  int _remainingSeconds = 180; // 3 minutes
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _watchChallengeStatus();
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        if (_status == 'pending') {
          setState(() => _status = 'expired');
        }
      }
    });
  }

  void _watchChallengeStatus() {
    _statusSubscription = _challengeHandler
        .watchChallengeStatus(widget.challengeId)
        .listen((result) {
      if (!mounted) return;

      setState(() => _status = result.status);

      if (result.status == 'approved' && result.customToken != null) {
        _countdownTimer?.cancel();
        // Exchange the custom token for a Firebase Auth session
        context.read<AuthBloc>().add(
              AuthEvent.authenticateWithPushToken(
                customToken: result.customToken!,
              ),
            );
        // Navigation handled by BlocListener below
      } else if (result.status == 'denied') {
        _countdownTimer?.cancel();
      }
    });
  }

  void _useOtpInstead() {
    context.go('/auth/phone', extra: {
      'phoneNumber': widget.phoneNumber,
      'skipPushLogin': true,
    });
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          // Router redirect handles navigation to /home
        } else if (state.status == AuthStatus.onboardingRequired) {
          // Router redirect handles smart onboarding routing
        } else if (state.status == AuthStatus.error) {
          setState(() => _status = 'error');
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.backgroundGradient,
            ),
          ),
          child: Stack(
            children: [
              // Top Light Blue background image
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

              // Main content
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),

                        // Logo
                        Image.asset(
                          'assets/icons/ImaliFacewithText.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.notifications_active_outlined,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(height: 32),

                        _buildStatusContent(),

                        const SizedBox(height: 32),

                        // Use OTP instead
                        if (_status == 'pending' ||
                            _status == 'denied' ||
                            _status == 'expired' ||
                            _status == 'error')
                          TextButton(
                            onPressed: _useOtpInstead,
                            child: Text(
                              'Use OTP instead',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),

                        const Spacer(flex: 3),
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

  Widget _buildStatusContent() {
    switch (_status) {
      case 'pending':
        return _buildPendingContent();
      case 'approved':
        return _buildApprovedContent();
      case 'denied':
        return _buildDeniedContent();
      case 'expired':
        return _buildExpiredContent();
      case 'error':
        return _buildErrorContent();
      default:
        return _buildPendingContent();
    }
  }

  Widget _buildPendingContent() {
    return Column(
      children: [
        Text(
          'Approve on your device',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'A notification has been sent to your trusted device. Tap to approve the login.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 32),
        const CircularProgressIndicator(color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          _formattedTime,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondary,
                fontFeatures: [const FontFeature.tabularFigures()],
              ),
        ),
      ],
    );
  }

  Widget _buildApprovedContent() {
    return Column(
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 64,
          color: AppColors.success,
        ),
        const SizedBox(height: 16),
        Text(
          'Login Approved',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Signing you in...',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildDeniedContent() {
    return Column(
      children: [
        const Icon(
          Icons.cancel_outlined,
          size: 64,
          color: Colors.redAccent,
        ),
        const SizedBox(height: 16),
        Text(
          'Login Denied',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'The login request was denied. If this wasn\'t you, your account is safe.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildExpiredContent() {
    return Column(
      children: [
        const Icon(
          Icons.timer_off_outlined,
          size: 64,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: 16),
        Text(
          'Request Expired',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'The login request has expired. Please try again or use OTP verification.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildErrorContent() {
    return Column(
      children: [
        const Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.redAccent,
        ),
        const SizedBox(height: 16),
        Text(
          'Sign-in Failed',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Something went wrong. Please try again or use OTP verification.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
