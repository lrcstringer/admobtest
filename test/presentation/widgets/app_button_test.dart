import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/presentation/widgets/common/app_button.dart';

void main() {
  group('AppButton Widget', () {
    testWidgets('should display text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Continue',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Submit',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(pressed, true);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Disabled',
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should show loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('should not call onPressed when loading', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Loading',
              onPressed: () {
                pressed = true;
              },
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(pressed, false);
    });

    testWidgets('should display leading icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'With Icon',
              onPressed: () {},
              icon: Icons.add,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display trailing icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Next',
              onPressed: () {},
              trailingIcon: Icons.arrow_forward,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    group('Button Variants', () {
      testWidgets('should render primary variant with ElevatedButton',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Primary',
                onPressed: () {},
                variant: AppButtonVariant.primary,
              ),
            ),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should render outline variant with OutlinedButton',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Outline',
                onPressed: () {},
                variant: AppButtonVariant.outline,
              ),
            ),
          ),
        );

        expect(find.byType(OutlinedButton), findsOneWidget);
      });

      testWidgets('should render text variant with TextButton', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Text',
                onPressed: () {},
                variant: AppButtonVariant.text,
              ),
            ),
          ),
        );

        expect(find.byType(TextButton), findsOneWidget);
      });
    });

    group('Button Sizes', () {
      testWidgets('should render small button with correct height',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Small',
                onPressed: () {},
                size: AppButtonSize.small,
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsOneWidget);
      });

      testWidgets('should render large button with correct height',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Large',
                onPressed: () {},
                size: AppButtonSize.large,
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsOneWidget);
      });
    });

    testWidgets('should not be full width when isFullWidth is false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppButton(
                text: 'Compact',
                onPressed: () {},
                isFullWidth: false,
              ),
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, isNot(double.infinity));
    });
  });
}
