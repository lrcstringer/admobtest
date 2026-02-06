import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../core/di/injection.dart';
import '../../../core/security/device_fingerprint.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../domain/entities/engagement.dart';
import '../../../domain/value_objects/engagement_evidence.dart';
import '../../blocs/earn/earn_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/wave_background.dart';

/// Earn Interaction Screen
/// Handles the full video watching + survey completion flow
class EarnInteractionScreen extends StatefulWidget {
  final String opportunityId;

  const EarnInteractionScreen({super.key, required this.opportunityId});

  @override
  State<EarnInteractionScreen> createState() => _EarnInteractionScreenState();
}

class _EarnInteractionScreenState extends State<EarnInteractionScreen>
    with WidgetsBindingObserver {
  // Video player
  VideoPlayerController? _videoController;
  bool _videoInitialized = false;
  bool _videoError = false;
  String? _videoErrorMessage;

  // Evidence tracking
  DateTime? _videoStartedAt;
  int _watchDurationMs = 0;
  bool _videoSeeked = false;
  final bool _screenVisible = true;
  bool _appInForeground = true;
  Timer? _progressTimer;

  // Survey state
  int _currentQuestionIndex = 0;
  final List<EngagementAnswer> _answers = [];
  final List<int> _responseTimesMs = [];
  DateTime? _questionStartTime;

  // Services
  late final PlayIntegrityService _integrityService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _integrityService = getIt<PlayIntegrityService>();

    // Select the opportunity and start engagement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<EarnBloc>();
      bloc.add(EarnEvent.selectOpportunity(widget.opportunityId));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _progressTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _appInForeground = false;
        _videoController?.pause();
        break;
      case AppLifecycleState.resumed:
        _appInForeground = true;
        // Don't auto-resume - let user control playback
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _appInForeground = false;
        break;
    }
  }

  void _initVideoPlayer(String mediaUrl) {
    if (_videoController != null) return;

    _videoController = VideoPlayerController.networkUrl(Uri.parse(mediaUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoInitialized = true;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _videoError = true;
            _videoErrorMessage = error.toString();
          });
        }
      });

    // Listen for seek events
    _videoController!.addListener(_onVideoStateChanged);
  }

  Duration? _lastKnownPosition;

  void _onVideoStateChanged() {
    if (_videoController == null) return;

    final currentPosition = _videoController!.value.position;

    // Detect seeking (position jumps more than 2 seconds)
    if (_lastKnownPosition != null) {
      final diff = (currentPosition - _lastKnownPosition!).inMilliseconds.abs();
      if (diff > 2000 && _videoController!.value.isPlaying) {
        _videoSeeked = true;
      }
    }
    _lastKnownPosition = currentPosition;
  }

  void _startEngagement() {
    final bloc = context.read<EarnBloc>();
    bloc.add(EarnEvent.startEngagement(opportunityId: widget.opportunityId));
  }

  void _startWatching() {
    if (_videoController == null || !_videoInitialized) return;

    _videoStartedAt = DateTime.now();
    _videoController!.play();
    _startProgressTracking();
  }

  void _startProgressTracking() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _updateProgress();
    });
  }

  void _updateProgress() {
    if (_videoController == null) return;

    final position = _videoController!.value.position;
    _watchDurationMs = position.inMilliseconds;

    final state = context.read<EarnBloc>().state;
    if (state.currentEngagement != null) {
      context.read<EarnBloc>().add(
            EarnEvent.updateWatchProgress(
              engagementId: state.currentEngagement!.id,
              watchDurationSeconds: position.inSeconds,
            ),
          );
    }
  }

  void _onWatchComplete() {
    _progressTimer?.cancel();
    _videoController?.pause();

    // Final progress update
    _updateProgress();

    // Start survey phase
    _questionStartTime = DateTime.now();
  }

  void _selectAnswer(String questionId, String selectedOption) {
    // Calculate response time
    final responseTime = _questionStartTime != null
        ? DateTime.now().difference(_questionStartTime!).inMilliseconds
        : 1000;
    _responseTimesMs.add(responseTime);

    // Record answer
    _answers.add(EngagementAnswer(
      questionId: questionId,
      selectedOption: selectedOption,
      answeredAt: DateTime.now(),
    ));

    final state = context.read<EarnBloc>().state;
    final questions = state.selectedOpportunity?.questions ?? [];

    // Move to next question or submit
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _questionStartTime = DateTime.now();
      });
    } else {
      _submitEngagement();
    }
  }

  Future<void> _submitEngagement() async {
    final state = context.read<EarnBloc>().state;
    if (state.currentEngagement == null) return;

    // Collect device fingerprint
    final fingerprint = await DeviceFingerprint.generate();

    // Try to get integrity token (Android only)
    final integrityToken = await _integrityService.getIntegrityToken();

    // Calculate attention score
    final attentionScore = _calculateAttentionScore();

    // Build evidence
    final evidence = EngagementEvidence(
      deviceFingerprint: fingerprint.hash,
      integrityToken: integrityToken,
      watchDurationMs: _watchDurationMs,
      videoSeeked: _videoSeeked,
      screenVisible: _screenVisible,
      appInForeground: _appInForeground,
      surveyResponseTimesMs: _responseTimesMs,
      videoStartedAt: _videoStartedAt ?? DateTime.now(),
      surveySubmittedAt: DateTime.now(),
      clientAttentionScore: attentionScore,
    );

    // Submit (check mounted after async gap)
    if (!mounted) return;
    context.read<EarnBloc>().add(
          EarnEvent.submitSurvey(
            engagementId: state.currentEngagement!.id,
            answers: _answers,
            evidence: evidence,
          ),
        );
  }

  double _calculateAttentionScore() {
    double score = 100.0;

    // Penalize for seeking
    if (_videoSeeked) score -= 20;

    // Penalize for leaving app
    if (!_appInForeground) score -= 15;

    // Penalize for fast survey responses (< 1 second average)
    if (_responseTimesMs.isNotEmpty) {
      final avgResponseTime =
          _responseTimesMs.reduce((a, b) => a + b) / _responseTimesMs.length;
      if (avgResponseTime < 1000) {
        score -= 25;
      } else if (avgResponseTime < 2000) {
        score -= 10;
      }
    }

    return score.clamp(0, 100);
  }

  void _abandonEngagement() {
    final state = context.read<EarnBloc>().state;
    if (state.currentEngagement != null) {
      context
          .read<EarnBloc>()
          .add(EarnEvent.abandonEngagement(state.currentEngagement!.id));
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarnBloc, EarnState>(
      listener: (context, state) {
        // Initialize video when opportunity is loaded
        if (state.selectedOpportunity != null &&
            state.selectedOpportunity!.mediaUrl != null &&
            _videoController == null) {
          _initVideoPlayer(state.selectedOpportunity!.mediaUrl!);
        }

        // Handle phase transitions
        if (state.engagementPhase == EngagementPhase.watching &&
            _videoStartedAt == null &&
            _videoInitialized) {
          _startWatching();
        }

        if (state.engagementPhase == EngagementPhase.surveying &&
            _questionStartTime == null) {
          _onWatchComplete();
        }

        // Navigate to confirm screen on completion
        if (state.engagementPhase == EngagementPhase.completed) {
          context.go('/earn/opportunity/${widget.opportunityId}/confirm');
        }

        // Show error snackbar
        if (state.engagementPhase == EngagementPhase.failed &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              _showExitConfirmation();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: _showExitConfirmation,
              ),
              title: Text(
                state.selectedOpportunity?.title ?? 'Earn',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              centerTitle: true,
            ),
            body: WaveBackground(
              child: _buildContent(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(EarnState state) {
    // Loading state
    if (state.selectedOpportunity == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state
    if (state.engagementPhase == EngagementPhase.failed) {
      return _buildErrorState(state);
    }

    // Starting engagement
    if (state.engagementPhase == EngagementPhase.idle ||
        state.engagementPhase == EngagementPhase.starting) {
      return _buildStartState(state);
    }

    // Watching phase
    if (state.engagementPhase == EngagementPhase.watching) {
      return _buildWatchingState(state);
    }

    // Surveying phase
    if (state.engagementPhase == EngagementPhase.surveying) {
      return _buildSurveyState(state);
    }

    // Submitting phase
    if (state.engagementPhase == EngagementPhase.submitting) {
      return _buildSubmittingState();
    }

    return const SizedBox.shrink();
  }

  Widget _buildStartState(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final isStarting = state.engagementPhase == EngagementPhase.starting;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Opportunity card
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildClientAvatar(opportunity),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              opportunity.clientName ?? 'Brand',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              opportunity.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  if (opportunity.description != null) ...[
                    Text(
                      opportunity.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: AppSpacing.md),
                  ],
                  // Details row
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _buildDetailChip(
                        Icons.timer_outlined,
                        opportunity.formattedDuration,
                      ),
                      _buildDetailChip(
                        Icons.quiz_outlined,
                        '${opportunity.questions.length} questions',
                      ),
                      _buildDetailChip(
                        Icons.category_outlined,
                        opportunity.earningTypeLabel,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // Reward preview
          Card(
            color: AppColors.primaryLight.withValues(alpha: 0.3),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  Icon(
                    Icons.monetization_on,
                    size: 48,
                    color: AppColors.gold,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    '+${opportunity.tokenReward} tokens',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Complete to earn',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // Instructions
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How it works',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  _buildInstructionStep(1, 'Watch the video completely'),
                  _buildInstructionStep(2, 'Answer all survey questions'),
                  _buildInstructionStep(3, 'Receive your tokens instantly'),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xl),

          // Start button
          AppButton(
            text: isStarting ? 'Starting...' : 'Start Earning',
            onPressed: isStarting ? null : _startEngagement,
            isLoading: isStarting,
            icon: Icons.play_arrow,
          ),
        ],
      ),
    );
  }

  Widget _buildWatchingState(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final engagement = state.currentEngagement;
    final progress = engagement?.watchProgress ?? 0.0;

    return Column(
      children: [
        // Video player
        Expanded(
          child: _videoError
              ? _buildVideoError()
              : !_videoInitialized
                  ? const Center(child: CircularProgressIndicator())
                  : AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_videoController!),
                          // Play/Pause overlay
                          GestureDetector(
                            onTap: () {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                              }
                              setState(() {});
                            },
                            child: AnimatedOpacity(
                              opacity:
                                  _videoController!.value.isPlaying ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(AppSpacing.lg),
                                child: Icon(
                                  _videoController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),

        // Progress section
        Container(
          padding: EdgeInsets.all(AppSpacing.md),
          color: AppColors.surface,
          child: Column(
            children: [
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation(
                    progress >= 1.0 ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.sm),

              // Progress text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toInt()}% watched',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '${engagement?.watchDurationSeconds ?? 0}s / ${opportunity.durationSeconds}s',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),

              // Info text
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      'Watch the full video to unlock the survey',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSurveyState(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final questions = opportunity.questions;

    if (questions.isEmpty) {
      // No questions - auto submit
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _submitEngagement();
      });
      return const Center(child: CircularProgressIndicator());
    }

    final question = questions[_currentQuestionIndex];
    final totalQuestions = questions.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress indicator
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / totalQuestions,
                    minHeight: 6,
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                '${_currentQuestionIndex + 1}/$totalQuestions',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),

          // Question card
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    question.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Answer options
          ...question.options.map((option) => Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sm),
                child: _buildAnswerOption(question.id, option),
              )),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(String questionId, String option) {
    return InkWell(
      onTap: () => _selectAnswer(questionId, option),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmittingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: AppSpacing.md),
          Text(
            'Submitting your responses...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Please wait',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(EarnState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              state.errorMessage ?? 'Please try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            SizedBox(height: AppSpacing.lg),
            AppButton(
              text: 'Try Again',
              onPressed: () {
                context.read<EarnBloc>().add(const EarnEvent.clearError());
                context.read<EarnBloc>().add(const EarnEvent.resetEngagement());
              },
              variant: AppButtonVariant.outline,
            ),
            SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Go Back',
              onPressed: () => context.pop(),
              variant: AppButtonVariant.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 64,
            color: AppColors.error,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Failed to load video',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            _videoErrorMessage ?? 'Please check your connection',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          SizedBox(height: AppSpacing.md),
          AppButton(
            text: 'Retry',
            onPressed: () {
              final state = context.read<EarnBloc>().state;
              if (state.selectedOpportunity?.mediaUrl != null) {
                setState(() {
                  _videoError = false;
                  _videoErrorMessage = null;
                  _videoController?.dispose();
                  _videoController = null;
                });
                _initVideoPlayer(state.selectedOpportunity!.mediaUrl!);
              }
            },
            variant: AppButtonVariant.outline,
            isFullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildClientAvatar(dynamic opportunity) {
    final color = opportunity.clientAvatarColor != null
        ? Color(int.parse(
            opportunity.clientAvatarColor!.replaceFirst('#', '0xFF')))
        : AppColors.primary;

    final initials = opportunity.clientName != null &&
            opportunity.clientName!.isNotEmpty
        ? opportunity.clientName!.split(' ').map((w) => w[0]).take(2).join()
        : '??';

    return CircleAvatar(
      radius: 24,
      backgroundColor: color,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(int number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    final state = context.read<EarnBloc>().state;
    final hasActiveEngagement = state.currentEngagement != null &&
        (state.engagementPhase == EngagementPhase.watching ||
            state.engagementPhase == EngagementPhase.surveying);

    if (!hasActiveEngagement) {
      context.pop();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Earning?'),
        content: const Text(
          'If you leave now, you will lose your progress and won\'t earn any tokens for this opportunity.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _abandonEngagement();
            },
            child: Text(
              'Leave',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
