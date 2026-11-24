import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbalink/app.dart';
import 'package:nyumbalink/core/widgets/password_field.dart';

/// Pumps the app on a tall screen so forms are fully visible without
/// scrolling.
Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const NyumbaLinkApp());
}

Finder fieldLabelled(String label) =>
    find.widgetWithText(TextFormField, label);

Finder buttonLabelled(String label) =>
    find.widgetWithText(FilledButton, label);

Future<void> fillSignUpForm(WidgetTester tester) async {
  await tester.enterText(fieldLabelled('Email'), 'person@example.com');
  await tester.enterText(fieldLabelled('Phone number'), '0712 345 678');
  await tester.enterText(fieldLabelled('Password'), 'a-long-password');
}

void main() {
  group('welcome screen', () {
    testWidgets('offers Tenant and Landlord and no administrator option',
        (WidgetTester tester) async {
      await pumpApp(tester);

      expect(find.text('Tenant'), findsOneWidget);
      expect(find.text('Landlord'), findsOneWidget);
      expect(
        find.textContaining(RegExp('admin', caseSensitive: false)),
        findsNothing,
      );
    });
  });

  group('tenant sign-up', () {
    testWidgets('shows no landlord consent checkbox',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Tenant'));
      await tester.pumpAndSettle();

      expect(find.text('Create tenant account'), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsNothing);
    });

    testWidgets('shows validation errors for an empty form',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Tenant'));
      await tester.pumpAndSettle();

      await tester.tap(buttonLabelled('Create account'));
      await tester.pump();

      expect(find.text('Enter your email address.'), findsOneWidget);
      expect(find.text('Enter your phone number.'), findsOneWidget);
      expect(find.text('Enter a password.'), findsOneWidget);
    });

    testWidgets('a valid form leads to email verification',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Tenant'));
      await tester.pumpAndSettle();

      await fillSignUpForm(tester);
      await tester.tap(buttonLabelled('Create account'));
      await tester.pumpAndSettle();

      expect(find.text('Verify your email'), findsWidgets);
      expect(find.textContaining('person@example.com'), findsOneWidget);
    });

    testWidgets('verifying the email reaches the tenant placeholder home',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Tenant'));
      await tester.pumpAndSettle();
      await fillSignUpForm(tester);
      await tester.tap(buttonLabelled('Create account'));
      await tester.pumpAndSettle();

      await tester.tap(buttonLabelled('I have verified my email'));
      await tester.pumpAndSettle();

      expect(find.text('You are signed in'), findsOneWidget);
      expect(find.textContaining('step 1C'), findsOneWidget);
    });
  });

  group('landlord sign-up', () {
    testWidgets('cannot continue without agreeing to show the phone number',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Landlord'));
      await tester.pumpAndSettle();
      expect(find.text('Create landlord account'), findsOneWidget);

      await fillSignUpForm(tester);
      await tester.tap(buttonLabelled('Create account'));
      await tester.pumpAndSettle();

      expect(find.text('You must agree to continue.'), findsOneWidget);
      expect(find.text('Verify your email'), findsNothing);
    });

    testWidgets('can continue after agreeing', (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Landlord'));
      await tester.pumpAndSettle();

      await fillSignUpForm(tester);
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pump();
      await tester.tap(buttonLabelled('Create account'));
      await tester.pumpAndSettle();

      expect(find.text('Verify your email'), findsWidgets);
    });
  });

  group('sign-in and password recovery', () {
    testWidgets('sign-in validates and then reaches the placeholder home',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Already have an account? Sign in'));
      await tester.pumpAndSettle();

      await tester.tap(buttonLabelled('Sign in'));
      await tester.pump();
      expect(find.text('Enter your email address.'), findsOneWidget);
      expect(find.text('Enter your password.'), findsOneWidget);

      await tester.enterText(fieldLabelled('Email'), 'person@example.com');
      await tester.enterText(fieldLabelled('Password'), 'x');
      await tester.tap(buttonLabelled('Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('You are signed in'), findsOneWidget);
    });

    testWidgets('signing out returns to the welcome screen',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Already have an account? Sign in'));
      await tester.pumpAndSettle();
      await tester.enterText(fieldLabelled('Email'), 'person@example.com');
      await tester.enterText(fieldLabelled('Password'), 'x');
      await tester.tap(buttonLabelled('Sign in'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign out'));
      await tester.pumpAndSettle();

      expect(find.text('Tenant'), findsOneWidget);
      expect(find.text('Landlord'), findsOneWidget);
    });

    testWidgets('password recovery confirms without revealing whether an '
        'account exists', (WidgetTester tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Already have an account? Sign in'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Forgot password?'));
      await tester.pumpAndSettle();

      await tester.tap(buttonLabelled('Send reset link'));
      await tester.pump();
      expect(find.text('Enter your email address.'), findsOneWidget);

      await tester.enterText(fieldLabelled('Email'), 'person@example.com');
      await tester.tap(buttonLabelled('Send reset link'));
      await tester.pumpAndSettle();

      expect(find.text('Check your email'), findsOneWidget);
      expect(find.textContaining('If an account exists'), findsOneWidget);
    });
  });

  group('password field', () {
    testWidgets('is hidden by default and can be shown and hidden again',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PasswordField())),
      );
      final Finder input = find.descendant(
        of: find.byType(PasswordField),
        matching: find.byType(TextField),
      );

      expect(tester.widget<TextField>(input).obscureText, isTrue);

      await tester.tap(find.byTooltip('Show password'));
      await tester.pump();
      expect(tester.widget<TextField>(input).obscureText, isFalse);

      await tester.tap(find.byTooltip('Hide password'));
      await tester.pump();
      expect(tester.widget<TextField>(input).obscureText, isTrue);
    });
  });
}
