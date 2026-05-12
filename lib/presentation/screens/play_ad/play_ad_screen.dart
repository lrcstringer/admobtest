import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../data/services/admob_service.dart';

class PlayAdScreen extends StatefulWidget {
  const PlayAdScreen({super.key});

  @override
  State<PlayAdScreen> createState() => _PlayAdScreenState();
}

class _PlayAdScreenState extends State<PlayAdScreen> {
  late final AdMobService _adMobService;
  bool _isShowingAd = false;
  String? _lastResult;

  @override
  void initState() {
    super.initState();
    _adMobService = getIt<AdMobService>();
  }

  Future<void> _playAd() async {
    if (_isShowingAd) return;
    setState(() {
      _isShowingAd = true;
      _lastResult = null;
    });
    final result = await _adMobService.showAd(userId: 'demo');
    if (mounted) {
      setState(() {
        _isShowingAd = false;
        _lastResult = result.success
            ? 'Reward earned: ${result.rewardAmount} ${result.rewardType}'
            : result.errorMessage ?? 'Unknown error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F3C),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isShowingAd)
                _spinner('Loading ad...')
              else
                _playButton(),
              if (_lastResult != null && !_isShowingAd) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    _lastResult!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _playButton() {
    return ElevatedButton(
      onPressed: _playAd,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0955FA),
        minimumSize: const Size(200, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        'Play Ad',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _spinner(String message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: Color(0xFF0955FA)),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
