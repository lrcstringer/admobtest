import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/security/device_binding_service.dart';
import '../../../core/services/fcm_challenge_handler.dart';
import '../../theme/app_colors.dart';

/// Screen shown on a trusted device when an auth challenge push is received.
///
/// Allows the user to approve (sign the nonce) or deny the login request.
class ChallengeApprovalScreen extends StatefulWidget {
  final String challengeId;
  final String nonce;

  const ChallengeApprovalScreen({
    super.key,
    required this.challengeId,
    required this.nonce,
  });

  @override
  State<ChallengeApprovalScreen> createState() =>
      _ChallengeApprovalScreenState();
}

class _ChallengeApprovalScreenState extends State<ChallengeApprovalScreen> {
  final _challengeHandler = GetIt.instance<FcmChallengeHandler>();
  final _deviceBindingService = GetIt.instance<DeviceBindingService>();

  bool _isProcessing = false;
  String? _errorMessage;
  Timer? _expiryTimer;
  int _remainingSeconds = 180; // 3 minutes
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startExpiryCountdown();
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }

  void _startExpiryCountdown() {
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _isExpired = true);
      }
    });
  }

  Future<void> _approve() async {
    if (_isProcessing || _isExpired) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    // Get the device ID and user ID from local binding
    final deviceId = await _deviceBindingService.getStoredDeviceId();
    final userId = await _deviceBindingService.getStoredUserId();

    if (deviceId == null || userId == null) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Device not bound. Cannot approve.';
      });
      return;
    }

    final customToken = await _challengeHandler.approveChallenge(
      challengeId: widget.challengeId,
      nonce: widget.nonce,
      deviceId: deviceId,
      userId: userId,
    );

    if (!mounted) return;

    if (customToken != null) {
      // Show success and navigate back
      _showSnackBar('Login approved successfully');
      context.pop();
    } else {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Failed to approve. Please try again.';
      });
    }
  }

  Future<void> _deny() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    await _challengeHandler.denyChallenge(widget.challengeId);

    if (!mounted) return;

    _showSnackBar('Login denied');
    context.pop();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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

                // Shield icon
                const Icon(
                  Icons.security,
                  size: 80,
                  color: AppColors.primary,
                ),

                const SizedBox(height: 24),

                Text(
                  'Login Request',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 12),

                if (_isExpired)
                  Text(
                    'This request has expired.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  )
                else ...[
                  Text(
                    'Someone is trying to log in to your iMali account. Was this you?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Expires in $_formattedTime',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontFeatures: [const FontFeature.tabularFigures()],
                        ),
                  ),
                ],

                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ],

                const SizedBox(height: 40),

                if (!_isExpired) ...[
                  // Approve button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _approve,
                      icon: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check_circle_outline),
                      label: Text(_isProcessing ? 'Approving...' : 'Yes, this was me'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Deny button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: _isProcessing ? null : _deny,
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('No, deny this login'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],

                const Spacer(flex: 3),

                // Dismiss
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    _isExpired ? 'Close' : 'Dismiss',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
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
}
