import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/presentation/widgets/common/app_text_field.dart';

void main() {
  group('AppTextField Widget', () {
    testWidgets('should display label when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Email',
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should display hint text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              hint: 'Enter your email',
            ),
          ),
        ),
      );

      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('should display error text when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              errorText: 'Invalid email format',
            ),
          ),
        ),
      );

      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('should call onChanged when text changes', (tester) async {
      String changedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test@example.com');
      expect(changedValue, 'test@example.com');
    });

    testWidgets('should obscure text when obscureText is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('should be read only when readOnly is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              readOnly: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, true);
    });

    testWidgets('should display prefix icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('should display suffix icon and call onSuffixTap',
        (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              suffixIcon: Icons.clear,
              onSuffixTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      expect(tapped, true);
    });

    testWidgets('should autofocus when autofocus is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              autofocus: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, true);
    });

    testWidgets('should use controller when provided', (tester) async {
      final controller = TextEditingController(text: 'Initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Initial text'), findsOneWidget);
    });

    testWidgets('should call onSubmitted when submitted', (tester) async {
      String submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              onSubmitted: (value) {
                submittedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'submitted text');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submittedValue, 'submitted text');
    });
  });

  group('AppPhoneTextField Widget', () {
    testWidgets('should display default label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(),
          ),
        ),
      );

      expect(find.text('Phone Number'), findsOneWidget);
    });

    testWidgets('should display custom label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(
              label: 'Mobile Number',
            ),
          ),
        ),
      );

      expect(find.text('Mobile Number'), findsOneWidget);
    });

    testWidgets('should display +27 prefix', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(),
          ),
        ),
      );

      expect(find.text('+27'), findsOneWidget);
    });

    testWidgets('should display hint text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(),
          ),
        ),
      );

      expect(find.text('81 234 5678'), findsOneWidget);
    });

    testWidgets('should display error text when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(
              errorText: 'Invalid phone number',
            ),
          ),
        ),
      );

      expect(find.text('Invalid phone number'), findsOneWidget);
    });

    testWidgets('should call onChanged when text changes', (tester) async {
      String changedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), '812345678');
      expect(changedValue.isNotEmpty, true);
    });

    testWidgets('should use phone keyboard type', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPhoneTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.phone);
    });
  });
}
