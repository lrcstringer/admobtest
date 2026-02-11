import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';

import 'mocks/mock_dependencies.dart';
import 'mocks/test_fixtures.dart';
import 'test_app.dart';

/// Integration tests for earn/engagement flow
///
/// These tests verify the complete earn journey:
/// 1. View available content on earn screen
/// 2. Select and start watching content
/// 3. Complete watching to earn tokens
/// 4. See updated balance
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockDependencies mocks;

  setUp(() {
    mocks = MockDependencies();
  });

  tearDown(() {
    mocks.dispose();
  });

  group('Earn Flow', () {
    testWidgets('should display earn screen with available threads', (
      tester,
    ) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      // Navigate to earn tab (assuming bottom nav index 1 or icon)
      final earnTab = find.byIcon(Icons.play_circle_outline);
      if (earnTab.evaluate().isNotEmpty) {
        await tester.tap(earnTab);
        await tester.pumpAndSettle();
      }

      // Trigger thread loading
      mocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Verify threads are displayed
      expect(find.text('Watch & Earn Campaign'), findsOneWidget);
      expect(find.text('Survey & Earn'), findsOneWidget);
    });

    testWidgets('should show featured thread with badge', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Featured thread should have indicator
      expect(find.text('Watch & Earn Campaign'), findsOneWidget);
      // Look for featured badge or styling
      expect(find.textContaining('Featured'), findsWidgets);
    });

    testWidgets('should load opportunities when thread selected', (
      tester,
    ) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Select first thread
      mocks.earnBloc.add(const EarnEvent.selectThread('thread_1'));
      mocks.earnBloc.add(
        const EarnEvent.loadOpportunities(threadId: 'thread_1'),
      );
      await tester.pumpAndSettle();

      // Verify opportunities loaded
      expect(find.text('Watch Product Video'), findsOneWidget);
      expect(find.text('Product Survey'), findsOneWidget);
    });

    testWidgets('should start engagement when opportunity tapped', (
      tester,
    ) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      // Load and select
      mocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();
      mocks.earnBloc.add(const EarnEvent.selectThread('thread_1'));
      mocks.earnBloc.add(
        const EarnEvent.loadOpportunities(threadId: 'thread_1'),
      );
      await tester.pumpAndSettle();

      // Start engagement
      mocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_1'),
      );
      await tester.pumpAndSettle();

      // Verify engagement started - bloc should be in watching phase
      expect(mocks.earnBloc.state.engagementPhase, EngagementPhase.watching);
    });

    testWidgets('should show error when network fails', (tester) async {
      final errorMocks = MockDependencies(networkError: true);

      await tester.pumpWidget(TestApp(mocks: errorMocks));
      await tester.pumpAndSettle();

      errorMocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Verify error state
      expect(errorMocks.earnBloc.state.status, EarnStatus.error);

      errorMocks.dispose();
    });

    testWidgets('should show error when budget depleted', (tester) async {
      final budgetMocks = MockDependencies(budgetDepleted: true);

      await tester.pumpWidget(TestApp(mocks: budgetMocks));
      await tester.pumpAndSettle();

      budgetMocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();
      budgetMocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_1'),
      );
      await tester.pumpAndSettle();

      // Verify failure due to budget
      expect(
        budgetMocks.earnBloc.state.engagementPhase,
        EngagementPhase.failed,
      );

      budgetMocks.dispose();
    });

    testWidgets('should show daily cap message when at limit', (tester) async {
      final capMocks = MockDependencies(dailyCompleted: 30, dailyLimit: 30);

      await tester.pumpWidget(TestApp(mocks: capMocks));
      await tester.pumpAndSettle();

      capMocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Verify daily cap in state
      expect(capMocks.earnBloc.state.dailyCompletions, 30);
      expect(capMocks.earnBloc.state.dailyEarnCap, 30);
      expect(capMocks.earnBloc.state.dailyLimitReached, isTrue);

      capMocks.dispose();
    });

    testWidgets('should show empty state when no threads available', (
      tester,
    ) async {
      final emptyMocks = MockDependencies(threads: []);

      await tester.pumpWidget(TestApp(mocks: emptyMocks));
      await tester.pumpAndSettle();

      emptyMocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Verify empty threads list
      expect(emptyMocks.earnBloc.state.threads, isEmpty);

      emptyMocks.dispose();
    });

    testWidgets('should track watch progress', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      // Start engagement
      mocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_1'),
      );
      await tester.pumpAndSettle();

      // Update progress
      mocks.earnBloc.add(
        const EarnEvent.updateWatchProgress(
          engagementId: 'engagement_1',
          watchDurationSeconds: 15,
        ),
      );
      await tester.pumpAndSettle();

      // Verify progress updated
      expect(mocks.earnBloc.state.currentEngagement?.watchDurationSeconds, 15);
    });

    testWidgets('should handle abandon flow', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_1'),
      );
      await tester.pumpAndSettle();

      // Abandon engagement
      mocks.earnBloc.add(const EarnEvent.abandonEngagement('engagement_1'));
      await tester.pumpAndSettle();

      // Verify abandoned
      expect(mocks.earnBloc.state.engagementPhase, EngagementPhase.abandoned);
    });

    testWidgets('should load engagement history', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(const EarnEvent.loadHistory());
      await tester.pumpAndSettle();

      // Verify history loaded
      expect(mocks.earnBloc.state.history, isNotEmpty);
      expect(mocks.earnBloc.state.history.length, 2);
    });

    testWidgets('should submit survey answers', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      // Start survey opportunity
      mocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_2'),
      );
      await tester.pumpAndSettle();

      final now = DateTime.now();

      // Submit survey with proper types
      mocks.earnBloc.add(
        EarnEvent.submitSurvey(
          engagementId: 'engagement_1',
          answers: [
            EngagementAnswer(
              questionId: 'q1',
              questionType: 'single_select',
              selectedOption: 'Very likely',
              answeredAt: now,
            ),
            EngagementAnswer(
              questionId: 'q2',
              questionType: 'single_select',
              selectedOption: 'Great quality',
              answeredAt: now,
            ),
          ],
          evidence: TestFixtures.surveyEvidence,
        ),
      );
      await tester.pumpAndSettle();

      // Verify completed
      expect(mocks.earnBloc.state.engagementPhase, EngagementPhase.completed);
    });

    testWidgets('should refresh threads', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(const EarnEvent.loadThreads());
      await tester.pumpAndSettle();

      // Refresh
      mocks.earnBloc.add(const EarnEvent.refresh());
      await tester.pumpAndSettle();

      // Verify still loaded
      expect(mocks.earnBloc.state.status, EarnStatus.loaded);
      expect(mocks.earnBloc.state.threads, isNotEmpty);
    });

    testWidgets('should reset engagement state', (tester) async {
      await tester.pumpWidget(TestApp(mocks: mocks));
      await tester.pumpAndSettle();

      mocks.earnBloc.add(
        const EarnEvent.startEngagement(opportunityId: 'opp_1'),
      );
      await tester.pumpAndSettle();

      // Reset
      mocks.earnBloc.add(const EarnEvent.resetEngagement());
      await tester.pumpAndSettle();

      // Verify reset
      expect(mocks.earnBloc.state.engagementPhase, EngagementPhase.idle);
      expect(mocks.earnBloc.state.currentEngagement, isNull);
    });
  });
}
