import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t_ddd_flutter/presentation/login_page.dart';

void main() {
testWidgets('Login Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(LoginPage());

    // Verify that the title is 'Login'.
    expect(find.text('Login'), findsOneWidget);

    // Enter 'username' and 'password' in the TextField.
    await tester.enterText(find.byType(TextField).first, 'username');
    await tester.enterText(find.byType(TextField).last, 'password');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify that the NextPage is shown.
    expect(find.text('NextPage'), findsOneWidget);
  });
}