import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/admob_constants.dart';
import '../../../core/di/injection.dart';
import '../../../core/security/device_fingerprint.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../data/services/upload_service.dart';
import '../../../domain/entities/earn_opportunity.dart';
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

  // Image viewing state
  DateTime? _imageViewStartedAt;

  // Survey state
  int _currentQuestionIndex = 0;
  final List<EngagementAnswer> _answers = [];
  final List<int> _responseTimesMs = [];
  DateTime? _questionStartTime;

  // AdMob ad state (for adVideo unified screen)
  bool _isShowingAd = false;

  // Poll vote state
  String? _pollSelectedOption;
  bool _pollSubmitting = false;
  bool _pollVoted = false;
  Map<String, dynamic>? _pollResults;

  // Upload state
  File? _recordedVideo;
  File? _compressedVideo;
  File? _selectedImage;
  final TextEditingController _uploadTextController = TextEditingController();
  bool _isCompressing = false;
  bool _isUploading = false;
  double _uploadProgress = 0;
  int _uploadBytesTransferred = 0;
  int _uploadTotalBytes = 0;
  DateTime? _uploadStartedAt;
  bool _isOnWifi = false;
  VideoPlayerController? _uploadVideoPreviewController;
  // Camera state for video recording
  CameraController? _cameraController;
  bool _isRecording = false;
  int _recordingSeconds = 0;
  Timer? _recordingTimer;
  bool _showCamera = false;

  // Services
  late final PlayIntegrityService _integrityService;
  late final UploadService _uploadService;

  // User ID for AdMob SSV
  String? _userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _integrityService = getIt<PlayIntegrityService>();
    _uploadService = getIt<UploadService>();

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
    _uploadTextController.dispose();
    _uploadVideoPreviewController?.dispose();
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    // Clean up compressed temp file
    _uploadService.cleanupTempFile(_compressedVideo);
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

  void _startImageViewing() {
    _videoStartedAt = DateTime.now();
    _imageViewStartedAt = DateTime.now();
    _startProgressTracking();
  }

  void _startProgressTracking() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateProgress();
    });
  }

  void _updateProgress() {
    final state = context.read<EarnBloc>().state;
    final isImage =
        state.selectedOpportunity?.earningType == EarningType.image;

    if (isImage) {
      // Timer-based progress for image viewing
      if (_imageViewStartedAt == null) return;
      final elapsed =
          DateTime.now().difference(_imageViewStartedAt!).inMilliseconds;
      _watchDurationMs = elapsed;

      if (state.currentEngagement != null) {
        context.read<EarnBloc>().add(
              EarnEvent.updateWatchProgress(
                engagementId: state.currentEngagement!.id,
                watchDurationSeconds: elapsed ~/ 1000,
              ),
            );
      }
      setState(() {});
    } else {
      // Video position-based progress
      if (_videoController == null) return;
      final position = _videoController!.value.position;
      _watchDurationMs = position.inMilliseconds;

      if (state.currentEngagement != null) {
        context.read<EarnBloc>().add(
              EarnEvent.updateWatchProgress(
                engagementId: state.currentEngagement!.id,
                watchDurationSeconds: position.inSeconds,
              ),
            );
      }
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

  void _recordAndAdvance(SurveyResponse response, {String? selectedOption}) {
    // Calculate response time
    final responseTime = _questionStartTime != null
        ? DateTime.now().difference(_questionStartTime!).inMilliseconds
        : 1000;
    _responseTimesMs.add(responseTime);
    _answers.add(response);

    final state = context.read<EarnBloc>().state;
    final questions = state.selectedOpportunity?.questions ?? [];
    final current = questions[_currentQuestionIndex];

    // Check branch rules (single_select only)
    String? targetQuestionId;
    if (selectedOption != null && current.branchRules.isNotEmpty) {
      final rule = current.branchRules
          .where((r) => r.optionValue == selectedOption)
          .toList();
      if (rule.isNotEmpty) targetQuestionId = rule.first.goToQuestionId;
    }

    if (targetQuestionId != null) {
      final targetIdx =
          questions.indexWhere((q) => q.id == targetQuestionId);
      if (targetIdx >= 0) {
        setState(() {
          _currentQuestionIndex = targetIdx;
          _questionStartTime = DateTime.now();
        });
        return;
      }
    }

    // Default: next question
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

    // Check if this is an AdMob opportunity
    final isAdMobOpportunity =
        state.selectedOpportunity?.earningType == EarningType.adVideo;

    // Build evidence
    final evidence = EngagementEvidence(
      deviceFingerprint: fingerprint.hash,
      integrityToken: integrityToken,
      watchDurationMs: isAdMobOpportunity ? 30000 : _watchDurationMs,
      videoSeeked: _videoSeeked,
      screenVisible: _screenVisible,
      appInForeground: _appInForeground,
      surveyResponseTimesMs: _responseTimesMs,
      videoStartedAt: _videoStartedAt ?? DateTime.now(),
      surveySubmittedAt: DateTime.now(),
      clientAttentionScore: attentionScore,
      // Include AdMob verification data if available
      adTransactionId: state.adTransactionId,
      adFullyWatched: isAdMobOpportunity && state.adTransactionId != null,
      adResponseId: state.adResponseId,
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
        // Capture user ID for AdMob SSV
        if (state.currentEngagement != null && _userId == null) {
          _userId = state.currentEngagement!.userId;
        }

        // Auto-fire startEngagement + loadAdVideo for adVideo deep links
        if (state.selectedOpportunity != null &&
            state.selectedOpportunity!.earningType == EarningType.adVideo &&
            state.engagementPhase == EngagementPhase.idle &&
            state.currentEngagement == null) {
          final bloc = context.read<EarnBloc>();
          bloc.add(EarnEvent.startEngagement(
              opportunityId: widget.opportunityId));
          if (!state.isAdLoading && !state.isAdReady) {
            bloc.add(const EarnEvent.loadAdVideo());
          }
        }

        // Initialize video when opportunity is loaded (video type only)
        if (state.selectedOpportunity != null &&
            state.selectedOpportunity!.mediaUrl != null &&
            state.selectedOpportunity!.earningType == EarningType.video &&
            _videoController == null) {
          _initVideoPlayer(state.selectedOpportunity!.mediaUrl!);
        }

        // Handle phase transitions
        if (state.engagementPhase == EngagementPhase.watching &&
            _videoStartedAt == null) {
          if (state.selectedOpportunity!.earningType == EarningType.image) {
            _startImageViewing();
          } else if (_videoInitialized) {
            _startWatching();
          }
        }

        if (state.engagementPhase == EngagementPhase.surveying &&
            _questionStartTime == null) {
          _onWatchComplete();
        }

        // Upload phase: check WiFi and record start time
        if (state.engagementPhase == EngagementPhase.uploading &&
            _uploadStartedAt == null) {
          _uploadStartedAt = DateTime.now();
          _checkWifi();
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

    // AdVideo: unified screen for idle/starting/watching/watchingAd phases
    if (state.isAdMobOpportunity &&
        (state.engagementPhase == EngagementPhase.idle ||
            state.engagementPhase == EngagementPhase.starting ||
            state.engagementPhase == EngagementPhase.watching ||
            state.engagementPhase == EngagementPhase.watchingAd)) {
      return _buildAdVideoScreen(state);
    }

    // Starting engagement (non-adVideo only)
    if (state.engagementPhase == EngagementPhase.idle ||
        state.engagementPhase == EngagementPhase.starting) {
      return _buildStartState(state);
    }

    // Upload phase
    if (state.engagementPhase == EngagementPhase.uploading) {
      return _buildUploadState(state);
    }

    // Watching/viewing phase (regular video or image — adVideo handled above)
    if (state.engagementPhase == EngagementPhase.watching) {
      if (state.selectedOpportunity!.earningType == EarningType.image) {
        return _buildImageViewingState(state);
      }
      return _buildWatchingState(state);
    }

    // Surveying phase — poll or survey
    if (state.engagementPhase == EngagementPhase.surveying) {
      if (state.selectedOpportunity!.isPollOpportunity) {
        return _buildPollVoteState(state);
      }
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

          // Reward bonus card (if opportunity has linked reward campaign)
          if (opportunity.hasRewardCampaign) ...[
            SizedBox(height: AppSpacing.sm),
            Card(
              color: AppColors.accent.withValues(alpha: 0.15),
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: AppColors.accent,
                      size: 28,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bonus Reward',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accent,
                                ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            opportunity.rewardCampaignName ?? 'Special reward',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
                  if (opportunity.earningType == EarningType.upload) ...[
                    _buildInstructionStep(1, 'Read the prompt carefully'),
                    _buildInstructionStep(2, 'Record, capture, or type your response'),
                    _buildInstructionStep(3, 'Submit and earn your tokens'),
                  ] else ...[
                    _buildInstructionStep(
                      1,
                      opportunity.earningType == EarningType.image
                          ? 'View the image carefully'
                          : 'Watch the video completely',
                    ),
                    _buildInstructionStep(2, 'Answer all survey questions'),
                    _buildInstructionStep(3, 'Receive your tokens instantly'),
                  ],
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

  Future<void> _showAd() async {
    if (_isShowingAd) return;

    setState(() {
      _isShowingAd = true;
    });

    final bloc = context.read<EarnBloc>();
    final userId = _userId ?? bloc.state.currentEngagement?.userId ?? 'unknown';
    final engagementId = bloc.state.currentEngagement?.id;
    final result = await bloc.showAdVideo(userId, engagementId: engagementId);

    if (!mounted) return;

    setState(() {
      _isShowingAd = false;
    });

    if (result.success && result.transactionId != null) {
      bloc.add(EarnEvent.adVideoCompleted(
        transactionId: result.transactionId!,
        rewardAmount: result.rewardAmount ?? AdMobConstants.adVideoTokenReward,
        responseId: result.responseId,
      ));
      _questionStartTime = DateTime.now();
    } else {
      bloc.add(EarnEvent.adVideoFailed(
        reason: result.errorMessage ?? 'Ad playback failed',
      ));
    }
  }

  Widget _buildAdVideoScreen(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final isEngagementReady = state.currentEngagement != null &&
        (state.engagementPhase == EngagementPhase.watching ||
            state.engagementPhase == EngagementPhase.watchingAd);
    final isAdReady = state.isAdReady;
    final bothReady = isEngagementReady && isAdReady;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Token reward badge
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.monetization_on, color: AppColors.gold, size: 20),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    '+${opportunity.tokenReward} tokens',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // "How it works" card
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
                  _buildInstructionStep(1, 'Watch the ad video completely'),
                  _buildInstructionStep(
                      2, 'Tap the X to close the ad when it finishes'),
                  _buildInstructionStep(3, 'Answer the bonus question'),
                  _buildInstructionStep(4, 'Receive your tokens instantly'),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xl),

          // Ad loading / ready state
          if (!bothReady && !_isShowingAd) ...[
            // Engagement creating or ad actively loading — show spinner + attempt
            if (state.isAdLoading ||
                state.engagementPhase == EngagementPhase.starting ||
                state.engagementPhase == EngagementPhase.idle)
              Center(
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      state.isAdLoading
                          ? 'Loading ad...'
                          : state.engagementPhase == EngagementPhase.starting
                              ? 'Preparing...'
                              : 'Getting ready...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    // Show attempt counter while loading
                    if (state.isAdLoading && state.adLoadAttempt > 1) ...[
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        'Attempt ${state.adLoadAttempt} of ${AdMobConstants.maxLoadRetries}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                      ),
                    ],
                  ],
                ),
              )
            // Ad failed — check if retries exhausted
            else if (state.adRetryRound > AdMobConstants.maxManualRetryRounds)
              // All retry rounds exhausted — graceful unavailable message
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 48,
                      color: AppColors.textHint,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'Ads aren\'t available right now',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'Please try again later',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    AppButton(
                      text: 'Go Back',
                      onPressed: () => context.pop(),
                      variant: AppButtonVariant.outline,
                      isFullWidth: false,
                    ),
                  ],
                ),
              )
            else
              // First failure round — offer one manual retry
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 48,
                      color: AppColors.textHint,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'Ad failed to load',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    SizedBox(height: AppSpacing.md),
                    AppButton(
                      text: 'Try Again',
                      onPressed: () {
                        context
                            .read<EarnBloc>()
                            .add(const EarnEvent.loadAdVideo());
                      },
                      icon: Icons.refresh,
                      isFullWidth: false,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    AppButton(
                      text: 'Go Back',
                      onPressed: () => context.pop(),
                      variant: AppButtonVariant.text,
                      isFullWidth: false,
                    ),
                  ],
                ),
              ),
          ] else if (_isShowingAd) ...[
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Playing ad...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Both ready — show Watch Ad button
            AppButton(
              text: 'Watch Ad',
              onPressed: _showAd,
              icon: Icons.play_arrow,
            ),
          ],
          SizedBox(height: AppSpacing.lg),
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

  Widget _buildImageViewingState(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final engagement = state.currentEngagement;
    final progress = engagement?.watchProgress ?? 0.0;
    final elapsedSeconds = _imageViewStartedAt != null
        ? DateTime.now().difference(_imageViewStartedAt!).inSeconds
        : 0;

    return Column(
      children: [
        // Image display
        Expanded(
          child: Center(
            child: opportunity.mediaUrl != null
                ? InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 3.0,
                    child: Image.network(
                      opportunity.mediaUrl!,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image_outlined,
                                size: 64, color: AppColors.textSecondary),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              'Failed to load image',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported_outlined,
                          size: 64, color: AppColors.textSecondary),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'No image available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textSecondary),
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
                    '${(progress * 100).toInt()}% viewed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '${elapsedSeconds}s / ${opportunity.durationSeconds}s',
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
                      'View the image carefully to unlock the survey',
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

          // Type-specific question widget
          _buildQuestionWidget(question),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget(SurveyQuestion question) {
    switch (question.questionType) {
      case QuestionType.singleSelect:
        return _buildSingleSelect(question);
      case QuestionType.multiSelect:
        return _buildMultiSelect(question);
      case QuestionType.textInput:
        return _buildTextInput(question);
      case QuestionType.likert:
        return _buildLikert(question);
      case QuestionType.starTags:
        return _buildStarTags(question);
      case QuestionType.slider:
        return _buildSlider(question);
    }
  }

  // --- Single Select (radio cards) ---
  Widget _buildSingleSelect(SurveyQuestion question) {
    return Column(
      children: question.options.map((option) => Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.sm),
        child: InkWell(
          onTap: () {
            _recordAndAdvance(
              SurveyResponse(
                questionId: question.id,
                questionType: 'single_select',
                selectedOption: option,
                answeredAt: DateTime.now(),
                isCorrect: question.isAttentionCheck
                    ? option == question.correctAnswer
                    : null,
              ),
              selectedOption: option,
            );
          },
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
                  child: Text(option,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }

  // --- Multi Select (checkbox cards) ---
  List<String> _multiSelectChoices = [];

  Widget _buildMultiSelect(SurveyQuestion question) {
    final maxSel = question.maxSelections ?? question.options.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Select up to $maxSel',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        SizedBox(height: AppSpacing.sm),
        ...question.options.map((option) {
          final selected = _multiSelectChoices.contains(option);
          return Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (selected) {
                    _multiSelectChoices.remove(option);
                  } else if (_multiSelectChoices.length < maxSel) {
                    _multiSelectChoices.add(option);
                  }
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected ? AppColors.primary : AppColors.divider,
                    width: selected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(option,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Continue',
          onPressed: _multiSelectChoices.isEmpty
              ? null
              : () {
                  final choices = List<String>.from(_multiSelectChoices);
                  _multiSelectChoices = [];
                  _recordAndAdvance(SurveyResponse(
                    questionId: question.id,
                    questionType: 'multi_select',
                    selectedOptions: choices,
                    answeredAt: DateTime.now(),
                  ));
                },
        ),
      ],
    );
  }

  // --- Text Input ---
  List<TextEditingController> _textInputControllers = [];

  Widget _buildTextInput(SurveyQuestion question) {
    // Initialize controllers if needed
    while (_textInputControllers.length < question.textInputCount) {
      _textInputControllers.add(TextEditingController());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...List.generate(question.textInputCount, (i) => Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.sm),
          child: TextField(
            controller: _textInputControllers[i],
            maxLength: question.textMaxLength,
            decoration: InputDecoration(
              labelText: question.textInputCount > 1
                  ? 'Response ${i + 1}'
                  : 'Your answer',
              border: const OutlineInputBorder(),
              counterText: '',
            ),
            onChanged: (_) => setState(() {}),
          ),
        )),
        SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Continue',
          onPressed: _textInputControllers
                  .take(question.textInputCount)
                  .any((c) => c.text.trim().isNotEmpty)
              ? () {
                  final responses = _textInputControllers
                      .take(question.textInputCount)
                      .map((c) => c.text.trim())
                      .where((t) => t.isNotEmpty)
                      .toList();
                  for (final c in _textInputControllers) {
                    c.clear();
                  }
                  _recordAndAdvance(SurveyResponse(
                    questionId: question.id,
                    questionType: 'text_input',
                    textResponses: responses,
                    answeredAt: DateTime.now(),
                  ));
                }
              : null,
        ),
      ],
    );
  }

  // --- Likert Scale ---
  int? _likertValue;

  Widget _buildLikert(SurveyQuestion question) {
    final lowLabel = question.likertLowLabel ?? 'Strongly Disagree';
    final highLabel = question.likertHighLabel ?? 'Strongly Agree';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(lowLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      )),
            ),
            Flexible(
              child: Text(highLabel,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      )),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(question.likertScale, (i) {
            final val = i + 1;
            final selected = _likertValue == val;
            return GestureDetector(
              onTap: () {
                setState(() => _likertValue = val);
              },
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.divider,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$val',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Continue',
          onPressed: _likertValue != null
              ? () {
                  final val = _likertValue!;
                  _likertValue = null;
                  _recordAndAdvance(SurveyResponse(
                    questionId: question.id,
                    questionType: 'likert',
                    likertValue: val,
                    answeredAt: DateTime.now(),
                  ));
                }
              : null,
        ),
      ],
    );
  }

  // --- Star + Tags ---
  int _starRating = 0;
  List<String> _selectedTags = [];

  Widget _buildStarTags(SurveyQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(question.maxStars, (i) {
            final starVal = i + 1;
            return GestureDetector(
              onTap: () => setState(() => _starRating = starVal),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  starVal <= _starRating ? Icons.star : Icons.star_border,
                  color: starVal <= _starRating
                      ? Colors.amber
                      : AppColors.textSecondary,
                  size: 40,
                ),
              ),
            );
          }),
        ),
        if (question.tags.isNotEmpty) ...[
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: question.tags.map((tag) {
              final selected = _selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: selected,
                onSelected: (v) {
                  setState(() {
                    if (v) {
                      final maxT = question.maxTags ?? question.tags.length;
                      if (_selectedTags.length < maxT) {
                        _selectedTags.add(tag);
                      }
                    } else {
                      _selectedTags.remove(tag);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
        SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Continue',
          onPressed: _starRating > 0
              ? () {
                  final rating = _starRating;
                  final tags = List<String>.from(_selectedTags);
                  _starRating = 0;
                  _selectedTags = [];
                  _recordAndAdvance(SurveyResponse(
                    questionId: question.id,
                    questionType: 'star_tags',
                    starRating: rating,
                    selectedTags: tags,
                    answeredAt: DateTime.now(),
                  ));
                }
              : null,
        ),
      ],
    );
  }

  // --- Slider ---
  double? _sliderVal;

  Widget _buildSlider(SurveyQuestion question) {
    final min = question.sliderMin.toDouble();
    final max = question.sliderMax.toDouble();
    final step = question.sliderStep.toDouble();
    final current = _sliderVal ?? ((min + max) / 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(question.sliderMinLabel ?? '${question.sliderMin}',
                style: Theme.of(context).textTheme.bodySmall),
            Text(
              current.toStringAsFixed(step < 1 ? 1 : 0),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(question.sliderMaxLabel ?? '${question.sliderMax}',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Slider(
          value: current,
          min: min,
          max: max,
          divisions: step > 0 ? ((max - min) / step).round() : null,
          onChanged: (v) => setState(() => _sliderVal = v),
        ),
        SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Continue',
          onPressed: () {
            final val = _sliderVal ?? current;
            _sliderVal = null;
            _recordAndAdvance(SurveyResponse(
              questionId: question.id,
              questionType: 'slider',
              sliderValue: val,
              answeredAt: DateTime.now(),
            ));
          },
        ),
      ],
    );
  }

  // ===================== Poll Vote =====================

  Widget _buildPollVoteState(EarnState state) {
    final opportunity = state.selectedOpportunity!;
    final pollId = opportunity.pollId;
    if (pollId == null) {
      return const Center(child: Text('Poll not found'));
    }

    if (_pollVoted && _pollResults != null) {
      return _buildPollResults(opportunity);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Poll question card
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.poll_outlined,
                          size: 20, color: AppColors.primary),
                      SizedBox(width: AppSpacing.sm),
                      Text(
                        'Poll',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.primary,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    opportunity.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Poll options
          ...List.generate(_getPollOptions(opportunity).length, (i) {
            final opt = _getPollOptions(opportunity)[i];
            final optId = 'opt_$i';
            final selected = _pollSelectedOption == optId;
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: InkWell(
                onTap: _pollSubmitting
                    ? null
                    : () => setState(() => _pollSelectedOption = optId),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          selected ? AppColors.primary : AppColors.divider,
                      width: selected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.divider,
                            width: 2,
                          ),
                        ),
                        child: selected
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          opt,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: AppSpacing.md),

          // Vote button
          AppButton(
            text: _pollSubmitting ? 'Submitting...' : 'Vote',
            onPressed: _pollSelectedOption == null || _pollSubmitting
                ? null
                : () => _submitPollVote(state),
          ),
        ],
      ),
    );
  }

  /// Extract poll option texts from the opportunity title/questions or fetch from poll doc
  List<String> _getPollOptions(EarnOpportunity opportunity) {
    // Poll options are stored in the polls collection, but the opportunity
    // questions array is empty for polls. We derive options from the
    // opportunity's questions if available, otherwise from Firestore poll doc.
    // For now, the options are fetched when we load poll results.
    // During voting, we load them on first render.
    if (_pollResults != null) {
      final options = (_pollResults!['options'] as List?) ?? [];
      return options
          .map((o) => (o as Map)['text'] as String? ?? '')
          .toList();
    }
    // Fallback: try to load from Firestore directly
    _loadPollOptions(opportunity.pollId!);
    return [];
  }

  bool _pollOptionsLoading = false;

  Future<void> _loadPollOptions(String pollId) async {
    if (_pollOptionsLoading || _pollResults != null) return;
    _pollOptionsLoading = true;
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getPollResults');
      final result = await callable.call(<String, dynamic>{
        'pollId': pollId,
      });
      if (mounted) {
        final data = Map<String, dynamic>.from(result.data as Map);
        setState(() {
          _pollResults = data;
          _pollOptionsLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _pollOptionsLoading = false);
      }
    }
  }

  Future<void> _submitPollVote(EarnState state) async {
    final pollId = state.selectedOpportunity!.pollId!;
    final selectedOption = _pollSelectedOption!;

    setState(() => _pollSubmitting = true);

    try {
      // 1. Submit vote to poll system
      final callable =
          FirebaseFunctions.instance.httpsCallable('submitPollVote');
      await callable.call(<String, dynamic>{
        'pollId': pollId,
        'selectedOption': selectedOption,
      });

      // 2. Load results for animated display
      final resultsCallable =
          FirebaseFunctions.instance.httpsCallable('getPollResults');
      final resultsResult = await resultsCallable.call(<String, dynamic>{
        'pollId': pollId,
      });

      if (!mounted) return;

      setState(() {
        _pollVoted = true;
        _pollSubmitting = false;
        _pollResults = Map<String, dynamic>.from(resultsResult.data as Map);
      });

      // 3. After a brief delay to show results, submit engagement for tokens
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;

      // Record the poll vote as a survey response
      _answers.add(SurveyResponse(
        questionId: 'poll_vote',
        questionType: 'single_select',
        selectedOption: selectedOption,
        answeredAt: DateTime.now(),
      ));
      _responseTimesMs.add(3000);

      _submitEngagement();
    } catch (e) {
      if (mounted) {
        setState(() => _pollSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit vote: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildPollResults(EarnOpportunity opportunity) {
    final results =
        Map<String, dynamic>.from(_pollResults!['results'] as Map? ?? {});
    final options = (_pollResults!['options'] as List?) ?? [];
    final totalRespondents = (results['totalRespondents'] as num?)?.toInt() ?? 0;
    final optionCounts = Map<String, dynamic>.from(
        results['optionCounts'] as Map? ?? {});
    final percentages = Map<String, dynamic>.from(
        results['percentages'] as Map? ?? {});

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thank you header
          Card(
            color: AppColors.primary.withValues(alpha: 0.1),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.primary),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Vote submitted! Earning tokens...',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Question
          Text(
            opportunity.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            '$totalRespondents vote${totalRespondents == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          SizedBox(height: AppSpacing.md),

          // Animated result bars
          ...options.map((opt) {
            final optMap = Map<String, dynamic>.from(opt as Map);
            final optId = optMap['id'] as String;
            final optText = optMap['text'] as String;
            final pct =
                (percentages[optId] as num?)?.toDouble() ?? 0.0;
            final count =
                (optionCounts[optId] as num?)?.toInt() ?? 0;
            final isMyVote = optId == _pollSelectedOption;

            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          optText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight:
                                    isMyVote ? FontWeight.bold : null,
                              ),
                        ),
                      ),
                      Text(
                        '${pct.toStringAsFixed(0)}%',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isMyVote
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        '($count)',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Stack(
                    children: [
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.divider,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: pct / 100),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                        builder: (context, value, _) {
                          return FractionallySizedBox(
                            widthFactor: value.clamp(0.0, 1.0),
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                color: isMyVote
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          );
                        },
                      ),
                      if (isMyVote)
                        Positioned(
                          left: 8,
                          top: 4,
                          child: Icon(Icons.check,
                              size: 18, color: Colors.white),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
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

  Widget _buildClientAvatar(EarnOpportunity opportunity) {
    final color = AppColors.parseHex(opportunity.clientAvatarColor);

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
            state.engagementPhase == EngagementPhase.watchingAd ||
            state.engagementPhase == EngagementPhase.uploading ||
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

  // ===================== Upload Earning Type =====================

  Future<void> _checkWifi() async {
    final results = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _isOnWifi = results.contains(ConnectivityResult.wifi);
      });
    }
  }

  Widget _buildUploadState(EarnState state) {
    final opportunity = state.selectedOpportunity!;

    // If currently showing camera overlay, render that instead
    if (_showCamera) {
      return _buildCameraOverlay(opportunity);
    }

    // If uploading/compressing, show progress
    if (_isUploading || _isCompressing) {
      return _buildUploadProgressState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Prompt/question
          Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.upload_outlined,
                          size: 20, color: AppColors.primary),
                      SizedBox(width: AppSpacing.sm),
                      Text(
                        'Upload',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.primary,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    opportunity.uploadPrompt ?? opportunity.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Context media (read-only image/video displayed for context)
          if (opportunity.uploadContextMediaUrl != null)
            _buildContextMedia(opportunity),

          // Video section
          if (opportunity.uploadVideoEnabled)
            _buildUploadVideoSection(opportunity),

          // Image section
          if (opportunity.uploadImageEnabled)
            _buildUploadImageSection(opportunity),

          // Text section
          if (opportunity.uploadTextEnabled)
            _buildUploadTextSection(opportunity),

          // Data summary
          _buildUploadDataSummary(),

          SizedBox(height: AppSpacing.md),

          // Submit button
          AppButton(
            text: 'Submit',
            onPressed: _canSubmitUpload(opportunity)
                ? () => _submitUploadEngagement()
                : null,
            icon: Icons.cloud_upload_outlined,
          ),
          SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildContextMedia(EarnOpportunity opportunity) {
    final url = opportunity.uploadContextMediaUrl!;
    final isVideo = opportunity.uploadContextMediaType == 'video';

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
              child: Text(
                'Context',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
            if (isVideo)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(
                  child: Icon(Icons.play_circle_outline,
                      size: 48, color: AppColors.textSecondary),
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Image.network(
                  url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => SizedBox(
                    height: 100,
                    child: Center(
                      child: Icon(Icons.broken_image_outlined,
                          color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── Video Recording Section ──

  Widget _buildUploadVideoSection(EarnOpportunity opportunity) {
    final required = opportunity.uploadVideoRequired;
    final maxSeconds = opportunity.uploadVideoMaxSeconds;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.videocam_outlined, size: 20),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Video Recording',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  _buildRequiredBadge(required),
                ],
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                'Max ${maxSeconds}s',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: AppSpacing.md),
              if (_recordedVideo != null) ...[
                // Preview recorded video
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: _uploadVideoPreviewController != null &&
                          _uploadVideoPreviewController!.value.isInitialized
                      ? ClipRRect(
                          borderRadius: AppSpacing.borderRadiusMd,
                          child: AspectRatio(
                            aspectRatio: _uploadVideoPreviewController!
                                .value.aspectRatio,
                            child:
                                VideoPlayer(_uploadVideoPreviewController!),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.videocam,
                              size: 48, color: Colors.white54),
                        ),
                ),
                SizedBox(height: AppSpacing.sm),
                // File size info
                if (_compressedVideo != null)
                  _buildFileSizeInfo(_compressedVideo!)
                else
                  _buildFileSizeInfo(_recordedVideo!),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _clearRecordedVideo,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Re-record'),
                      ),
                    ),
                  ],
                ),
              ] else
                OutlinedButton.icon(
                  onPressed: () => _openCamera(maxSeconds),
                  icon: const Icon(Icons.videocam),
                  label: const Text('Record Video'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCamera(int maxSeconds) async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No camera available')),
          );
        }
        return;
      }

      // Prefer front camera for user-facing video
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: true,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() => _showCamera = true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open camera: $e')),
        );
      }
    }
  }

  Widget _buildCameraOverlay(EarnOpportunity opportunity) {
    final maxSeconds = opportunity.uploadVideoMaxSeconds;

    if (_cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Camera preview
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(_cameraController!),
              // Timer overlay
              if (_isRecording)
                Positioned(
                  top: AppSpacing.md,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Text(
                            '${_recordingSeconds}s / ${maxSeconds}s',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Controls
        Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          color: Colors.black87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel
              IconButton(
                onPressed: _cancelCamera,
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
              ),
              // Record/Stop button
              GestureDetector(
                onTap: _isRecording
                    ? _stopRecording
                    : () => _startRecording(maxSeconds),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      width: _isRecording ? 28 : 56,
                      height: _isRecording ? 28 : 56,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: _isRecording
                            ? BorderRadius.circular(4)
                            : BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer for symmetry
              const SizedBox(width: 32),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _startRecording(int maxSeconds) async {
    if (_cameraController == null || _isRecording) return;

    try {
      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
      });

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => _recordingSeconds++);
        if (_recordingSeconds >= maxSeconds) {
          _stopRecording();
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start recording: $e')),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_isRecording) return;

    _recordingTimer?.cancel();
    setState(() => _isRecording = false);

    try {
      final xFile = await _cameraController!.stopVideoRecording();
      final file = File(xFile.path);

      // Validate file size
      if (!await _uploadService.isValidVideoFile(file)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video file is too large (max 50MB)')),
          );
        }
        return;
      }

      setState(() {
        _recordedVideo = file;
        _showCamera = false;
      });

      // Dispose camera
      await _cameraController?.dispose();
      _cameraController = null;

      // Compress video
      _compressRecordedVideo(file);

      // Initialize preview player
      _initUploadVideoPreview(file);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save recording: $e')),
        );
      }
    }
  }

  void _cancelCamera() {
    _recordingTimer?.cancel();
    _cameraController?.dispose();
    _cameraController = null;
    setState(() {
      _showCamera = false;
      _isRecording = false;
      _recordingSeconds = 0;
    });
  }

  Future<void> _compressRecordedVideo(File file) async {
    setState(() => _isCompressing = true);
    try {
      final compressed = await _uploadService.compressVideo(file);
      if (mounted) {
        setState(() {
          _compressedVideo = compressed;
          _isCompressing = false;
        });
        // Update preview to compressed version
        _initUploadVideoPreview(compressed);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isCompressing = false);
        // Compression failed — use original file
        debugPrint('UploadScreen: Compression failed, using original: $e');
      }
    }
  }

  void _initUploadVideoPreview(File file) {
    _uploadVideoPreviewController?.dispose();
    _uploadVideoPreviewController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      });
  }

  void _clearRecordedVideo() {
    _uploadVideoPreviewController?.dispose();
    _uploadVideoPreviewController = null;
    _uploadService.cleanupTempFile(_compressedVideo);
    setState(() {
      _recordedVideo = null;
      _compressedVideo = null;
    });
  }

  // ── Image Capture Section ──

  Widget _buildUploadImageSection(EarnOpportunity opportunity) {
    final required = opportunity.uploadImageRequired;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.photo_camera_outlined, size: 20),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Photo',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  _buildRequiredBadge(required),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              if (_selectedImage != null) ...[
                // Preview selected image
                ClipRRect(
                  borderRadius: AppSpacing.borderRadiusMd,
                  child: Image.file(
                    _selectedImage!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                _buildFileSizeInfo(_selectedImage!),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _clearSelectedImage,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Re-pick'),
                      ),
                    ),
                  ],
                ),
              ] else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Take Photo'),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Gallery'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final xFile = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (xFile == null) return;

      final file = File(xFile.path);
      if (!await _uploadService.isValidImageFile(file)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image is too large (max 10MB)')),
          );
        }
        return;
      }

      if (mounted) {
        setState(() => _selectedImage = file);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _clearSelectedImage() {
    setState(() => _selectedImage = null);
  }

  // ── Text Response Section ──

  Widget _buildUploadTextSection(EarnOpportunity opportunity) {
    final required = opportunity.uploadTextRequired;
    final minChars = opportunity.uploadTextMinChars;
    final maxChars = opportunity.uploadTextMaxChars;
    final currentLength = _uploadTextController.text.length;
    final meetsMinimum = currentLength >= minChars;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.text_fields_outlined, size: 20),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Text Response',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  _buildRequiredBadge(required),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              TextField(
                controller: _uploadTextController,
                maxLength: maxChars,
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: 'Type your response here...',
                  border: const OutlineInputBorder(),
                  counterText: '$currentLength / $maxChars',
                  counterStyle: TextStyle(
                    color: meetsMinimum
                        ? AppColors.textSecondary
                        : AppColors.error,
                  ),
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),
              if (!meetsMinimum && currentLength > 0)
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    'Minimum $minChars characters required',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Data Summary & WiFi ──

  Widget _buildUploadDataSummary() {
    final totalBytes = _estimateTotalUploadBytes();
    if (totalBytes == 0) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isOnWifi ? Icons.wifi : Icons.signal_cellular_alt,
                  size: 20,
                  color: _isOnWifi ? AppColors.success : AppColors.warning,
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  _isOnWifi ? 'Connected via WiFi' : 'Using mobile data',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _isOnWifi
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated upload size',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                Text(
                  UploadService.formatBytes(totalBytes),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            if (!_isOnWifi) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimated data cost',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Text(
                    _uploadService.estimateDataCost(totalBytes),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warning,
                        ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUploadProgressState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isCompressing) ...[
              const CircularProgressIndicator(),
              SizedBox(height: AppSpacing.md),
              Text(
                'Compressing video...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'This may take a moment',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ] else ...[
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: _uploadProgress > 0 ? _uploadProgress : null,
                  strokeWidth: 6,
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'Uploading...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                '${UploadService.formatBytes(_uploadBytesTransferred)} / '
                '${UploadService.formatBytes(_uploadTotalBytes)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              if (_uploadProgress > 0) ...[
                SizedBox(height: AppSpacing.sm),
                Text(
                  '${(_uploadProgress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // ── Helpers ──

  Widget _buildRequiredBadge(bool required) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: required
            ? AppColors.error.withValues(alpha: 0.1)
            : AppColors.textHint.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        required ? 'Required' : 'Optional',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: required ? AppColors.error : AppColors.textHint,
            ),
      ),
    );
  }

  Widget _buildFileSizeInfo(File file) {
    return FutureBuilder<int>(
      future: file.length(),
      builder: (context, snapshot) {
        final size = snapshot.data ?? 0;
        return Row(
          children: [
            Icon(Icons.storage_outlined, size: 14, color: AppColors.textHint),
            SizedBox(width: AppSpacing.xs),
            Text(
              UploadService.formatBytes(size),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        );
      },
    );
  }

  int _estimateTotalUploadBytes() {
    int total = 0;
    // Use compressed video if available, otherwise original
    final videoFile = _compressedVideo ?? _recordedVideo;
    if (videoFile != null) {
      // Use synchronous stat for estimate (non-blocking on cached files)
      try {
        total += videoFile.lengthSync();
      } catch (_) {}
    }
    if (_selectedImage != null) {
      try {
        total += _selectedImage!.lengthSync();
      } catch (_) {}
    }
    return total;
  }

  bool _canSubmitUpload(EarnOpportunity opportunity) {
    // Check required fields
    if (opportunity.uploadVideoRequired && _recordedVideo == null) {
      return false;
    }
    if (opportunity.uploadImageRequired && _selectedImage == null) {
      return false;
    }
    if (opportunity.uploadTextRequired) {
      final text = _uploadTextController.text.trim();
      if (text.length < opportunity.uploadTextMinChars) return false;
    }

    // Must have at least one upload
    final hasVideo = _recordedVideo != null;
    final hasImage = _selectedImage != null;
    final hasText = _uploadTextController.text.trim().length >=
        opportunity.uploadTextMinChars;

    return hasVideo || hasImage || hasText;
  }

  // ── Submit Upload ──

  Future<void> _submitUploadEngagement() async {
    final state = context.read<EarnBloc>().state;
    if (state.currentEngagement == null) return;

    final engagement = state.currentEngagement!;

    setState(() => _isUploading = true);

    try {
      final List<UploadedFileEvidence> uploadedFiles = [];

      // Upload video if present
      final videoFile = _compressedVideo ?? _recordedVideo;
      if (videoFile != null) {
        final fileName =
            'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
        final storagePath = _uploadService.buildStoragePath(
          engagementId: engagement.id,
          type: 'video',
          fileName: fileName,
        );

        final url = await _uploadService.uploadFile(
          file: videoFile,
          storagePath: storagePath,
          contentType: 'video/mp4',
          onProgress: (transferred, total) {
            if (mounted) {
              setState(() {
                _uploadBytesTransferred = transferred;
                _uploadTotalBytes = total;
                _uploadProgress = total > 0 ? transferred / total : 0;
              });
            }
          },
        );

        final fileSize = await videoFile.length();
        uploadedFiles.add(UploadedFileEvidence(
          url: url,
          type: 'video',
          sizeBytes: fileSize,
          mimeType: 'video/mp4',
          durationSeconds: _recordingSeconds > 0 ? _recordingSeconds : null,
        ));
      }

      // Upload image if present
      if (_selectedImage != null) {
        final fileName =
            'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final storagePath = _uploadService.buildStoragePath(
          engagementId: engagement.id,
          type: 'image',
          fileName: fileName,
        );

        final url = await _uploadService.uploadFile(
          file: _selectedImage!,
          storagePath: storagePath,
          contentType: 'image/jpeg',
          onProgress: (transferred, total) {
            if (mounted) {
              setState(() {
                _uploadBytesTransferred = transferred;
                _uploadTotalBytes = total;
                _uploadProgress = total > 0 ? transferred / total : 0;
              });
            }
          },
        );

        final fileSize = await _selectedImage!.length();
        uploadedFiles.add(UploadedFileEvidence(
          url: url,
          type: 'image',
          sizeBytes: fileSize,
          mimeType: 'image/jpeg',
        ));
      }

      if (!mounted) return;

      // Collect device fingerprint & integrity token
      final fingerprint = await DeviceFingerprint.generate();
      final integrityToken = await _integrityService.getIntegrityToken();
      final attentionScore = _calculateAttentionScore();

      final textResponse = _uploadTextController.text.trim();

      // Build evidence
      final evidence = EngagementEvidence(
        deviceFingerprint: fingerprint.hash,
        integrityToken: integrityToken,
        watchDurationMs: 0,
        videoSeeked: false,
        screenVisible: _screenVisible,
        appInForeground: _appInForeground,
        surveyResponseTimesMs: const [],
        videoStartedAt: _uploadStartedAt ?? DateTime.now(),
        surveySubmittedAt: DateTime.now(),
        clientAttentionScore: attentionScore,
        uploadedFiles: uploadedFiles,
        uploadTextResponse:
            textResponse.isNotEmpty ? textResponse : null,
        uploadStartedAt: _uploadStartedAt,
        uploadCompletedAt: DateTime.now(),
      );

      if (!mounted) return;

      // Submit through BLoC
      context.read<EarnBloc>().add(EarnEvent.submitUpload(
            engagementId: engagement.id,
            uploadedFiles: uploadedFiles,
            textResponse:
                textResponse.isNotEmpty ? textResponse : null,
            evidence: evidence,
          ));
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
