import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbalink/app.dart';
import 'package:nyumbalink/core/widgets/app_button.dart';

void main() {
  testWidgets('app starts and shows the NyumbaLink wordmark and parent credit',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NyumbaLinkApp());

    expect(find.text('NyumbaLink'), findsOneWidget);
    expect(find.text("A subsidiary of LGC'S GROUP"), findsOneWidget);
  });

  testWidgets('AppButton calls onPressed when enabled',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(label: 'Pay', onPressed: () => pressed = true),
        ),
      ),
    );

    await tester.tap(find.text('Pay'));
    expect(pressed, isTrue);
  });

  testWidgets('AppButton ignores taps while loading',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Pay',
            onPressed: () => pressed = true,
            isLoading: true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FilledButton));
    expect(pressed, isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
