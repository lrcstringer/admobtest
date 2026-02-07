import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/admob_constants.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/app_button.dart';

/// Widget for displaying and managing AdMob rewarded video ads
class AdMobVideoWidget extends StatefulWidget {
  final String userId;
  final VoidCallback? onAdCompleted;
  final VoidCallback? onAdFailed;

  const AdMobVideoWidget({
    super.key,
    required this.userId,
    this.onAdCompleted,
    this.onAdFailed,
  });

  @override
  State<AdMobVideoWidget> createState() => _AdMobVideoWidgetState();
}

class _AdMobVideoWidgetState extends State<AdMobVideoWidget> {
  bool _isShowingAd = false;

  @override
  void initState() {
    super.initState();
    // Load ad when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAd();
    });
  }

  void _loadAd() {
    context.read<EarnBloc>().add(const EarnEvent.loadAdVideo());
  }

  Future<void> _showAd() async {
    if (_isShowingAd) return;

    setState(() {
      _isShowingAd = true;
    });

    final bloc = context.read<EarnBloc>();
    final result = await bloc.showAdVideo(widget.userId);

    if (!mounted) return;

    setState(() {
      _isShowingAd = false;
    });

    if (result.success && result.transactionId != null) {
      bloc.add(EarnEvent.adVideoCompleted(
        transactionId: result.transactionId!,
        rewardAmount: result.rewardAmount ?? AdMobConstants.adVideoTokenReward,
      ));
      widget.onAdCompleted?.call();
    } else {
      bloc.add(EarnEvent.adVideoFailed(
        reason: result.errorMessage ?? 'Ad playback failed',
      ));
      widget.onAdFailed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EarnBloc, EarnState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Watch ad button / loading states
            if (state.isAdLoading)
              Column(
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Loading ad...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              )
            else if (_isShowingAd)
              Column(
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Playing ad...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              )
            else
              AppButton(
                text: state.isAdReady ? 'Watch Ad' : 'Load Ad',
                onPressed: state.isAdReady ? _showAd : _loadAd,
                icon: state.isAdReady ? Icons.play_arrow : Icons.refresh,
                isFullWidth: false,
              ),
          ],
        );
      },
    );
  }
}
