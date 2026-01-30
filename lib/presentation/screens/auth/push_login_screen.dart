import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/fcm_challenge_handler.dart';
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

  StreamSubscription<String>? _statusSubscription;
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
        .listen((status) {
      if (!mounted) return;

      setState(() => _status = status);

      if (status == 'approved') {
        _countdownTimer?.cancel();
        // Navigate to home — the auth token will be handled by the caller
        context.go('/home');
      } else if (status == 'denied') {
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
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

                const Spacer(flex: 3),

                // Use OTP instead
                if (_status == 'pending' || _status == 'denied' || _status == 'expired')
                  TextButton(
                    onPressed: _useOtpInstead,
                    child: Text(
                      'Use OTP instead',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                const SizedBox(height: 24),
              ],
            ),
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
}
