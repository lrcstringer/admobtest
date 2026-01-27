import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/presentation/widgets/common/loading_indicator.dart';

void main() {
  group('LoadingIndicator Widget', () {
    testWidgets('should display CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should use default size of 40', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 40);
      expect(sizedBox.width, 40);
    });

    testWidgets('should use custom size when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(size: 60),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 60);
      expect(sizedBox.width, 60);
    });

    testWidgets('should use custom color when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(color: Colors.red),
          ),
        ),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      final animation = indicator.valueColor as AlwaysStoppedAnimation<Color>;
      expect(animation.value, Colors.red);
    });

    testWidgets('should use custom strokeWidth when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(strokeWidth: 5),
          ),
        ),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.strokeWidth, 5);
    });
  });

  group('LoadingOverlay Widget', () {
    testWidgets('should display child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: false,
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('should not show overlay when not loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: false,
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show overlay when loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: true,
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('should display message when loading and message provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: true,
              message: 'Loading data...',
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Loading data...'), findsOneWidget);
    });

    testWidgets('should not display message when not loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: false,
              message: 'Loading data...',
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Loading data...'), findsNothing);
    });
  });

  group('FullScreenLoading Widget', () {
    testWidgets('should display LoadingIndicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenLoading(),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('should display message when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenLoading(
            message: 'Please wait...',
          ),
        ),
      );

      expect(find.text('Please wait...'), findsOneWidget);
    });

    testWidgets('should not display message when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenLoading(),
        ),
      );

      // Should have the loading indicator but no message text
      expect(find.byType(LoadingIndicator), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('should be wrapped in Scaffold', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenLoading(),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
