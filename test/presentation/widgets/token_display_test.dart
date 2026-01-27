import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/presentation/widgets/common/token_display.dart';

void main() {
  group('TokenDisplay Widget', () {
    testWidgets('should display token amount correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenDisplay(amount: 10000),
          ),
        ),
      );

      expect(find.text('10,000'), findsOneWidget);
    });

    testWidgets('should display ZAR value when showZar is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenDisplay(amount: 10000, showZar: true),
          ),
        ),
      );

      expect(find.text('10,000'), findsOneWidget);
      expect(find.textContaining('R100'), findsOneWidget);
    });

    testWidgets('should use large style when specified', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenDisplay(
              amount: 5000,
              style: TokenDisplayStyle.large,
            ),
          ),
        ),
      );

      expect(find.text('5,000'), findsOneWidget);
    });

    testWidgets('should format zero amount correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenDisplay(amount: 0),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('should format large amounts with thousand separators', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenDisplay(amount: 1234567),
          ),
        ),
      );

      expect(find.text('1,234,567'), findsOneWidget);
    });
  });
}
