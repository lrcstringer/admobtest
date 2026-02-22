import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/data/services/admob_service.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';
import 'package:imalichat/presentation/widgets/earn/admob_video_widget.dart';

class MockEarnRepository extends Mock implements EarnRepository {}

class MockAdMobService extends Mock implements AdMobService {}

class MockEarnBloc extends MockBloc<EarnEvent, EarnState> implements EarnBloc {}

void main() {
  late MockEarnBloc mockEarnBloc;

  setUp(() {
    mockEarnBloc = MockEarnBloc();
  });

  Widget buildWidget({VoidCallback? onAdCompleted, VoidCallback? onAdFailed}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<EarnBloc>.value(
          value: mockEarnBloc,
          child: AdMobVideoWidget(
            userId: 'test_user_123',
            onAdCompleted: onAdCompleted,
            onAdFailed: onAdFailed,
          ),
        ),
      ),
    );
  }

  group('AdMobVideoWidget', () {
    testWidgets('should display Load Ad button in default state',
        (tester) async {
      when(() => mockEarnBloc.state).thenReturn(const EarnState());

      await tester.pumpWidget(buildWidget());

      expect(find.text('Load Ad'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('should display Watch Ad button when ad is ready',
        (tester) async {
      when(() => mockEarnBloc.state).thenReturn(
        const EarnState(isAdReady: true),
      );

      await tester.pumpWidget(buildWidget());

      expect(find.text('Watch Ad'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('should not show Watch Ad button when not ready',
        (tester) async {
      when(() => mockEarnBloc.state).thenReturn(const EarnState());

      await tester.pumpWidget(buildWidget());

      expect(find.text('Watch Ad'), findsNothing);
    });

    testWidgets('should not show loading text in default state',
        (tester) async {
      when(() => mockEarnBloc.state).thenReturn(const EarnState());

      await tester.pumpWidget(buildWidget());

      expect(find.text('Loading ad...'), findsNothing);
    });

    group('Loading state', () {
      testWidgets('should show loading indicator when ad is loading',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdLoading: true),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading ad...'), findsOneWidget);
      });

      testWidgets('should not show Watch Ad button when loading',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdLoading: true),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.text('Watch Ad'), findsNothing);
      });
    });

    group('Ad ready state', () {
      testWidgets('should show Watch Ad button when ad is ready',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdReady: true),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.text('Watch Ad'), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      });

      testWidgets('should not show loading indicator when ad is ready',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdReady: true),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.text('Loading ad...'), findsNothing);
      });
    });

    group('Ad not ready state', () {
      testWidgets('should show Load Ad button when ad is not ready',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdReady: false, isAdLoading: false),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.text('Load Ad'), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets('should not show loading indicator when not ready',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdReady: false, isAdLoading: false),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });

    group('Button interactions', () {
      testWidgets('should dispatch loadAdVideo event when Load Ad is tapped',
          (tester) async {
        when(() => mockEarnBloc.state).thenReturn(
          const EarnState(isAdReady: false, isAdLoading: false),
        );

        await tester.pumpWidget(buildWidget());
        await tester.pump(); // Wait for post frame callback (initial load)

        // Clear previous calls from initState
        clearInteractions(mockEarnBloc);

        await tester.tap(find.text('Load Ad'));
        await tester.pump();

        verify(() => mockEarnBloc.add(const EarnEvent.loadAdVideo())).called(1);
      });
    });

    group('State transitions', () {
      testWidgets('should rebuild when state changes from loading to ready',
          (tester) async {
        whenListen(
          mockEarnBloc,
          Stream.fromIterable([
            const EarnState(isAdLoading: true),
            const EarnState(isAdReady: true, isAdLoading: false),
          ]),
          initialState: const EarnState(),
        );

        await tester.pumpWidget(buildWidget());

        // Initial state
        expect(find.text('Load Ad'), findsOneWidget);

        // Pump to process first state (loading)
        await tester.pump();

        // Pump to process second state (ready)
        await tester.pump();

        // Should now show Watch Ad button
        expect(find.text('Watch Ad'), findsOneWidget);
      });
    });

    group('Initial ad loading', () {
      testWidgets('should dispatch loadAdVideo on init', (tester) async {
        when(() => mockEarnBloc.state).thenReturn(const EarnState());

        await tester.pumpWidget(buildWidget());
        await tester.pump(); // Wait for post frame callback

        verify(() => mockEarnBloc.add(const EarnEvent.loadAdVideo())).called(1);
      });
    });
  });
}
