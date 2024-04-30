import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:t_ddd_flutter/application/user_service.dart';
import 'package:t_ddd_flutter/presentation/login_page.dart';
import 'package:t_ddd_flutter/presentation/next_page.dart';

  // Add this line for mocking

@GenerateMocks([UserService])
void main() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    late Finder usernameField;
    late Finder passwordField;
    late Finder loginButton;

    setUp(() {
        usernameField = find.byWidgetPredicate(
                (Widget widget) => widget is TextFormField && widget.key == Key('username'),
        );
        passwordField = find.byWidgetPredicate(
                (Widget widget) => widget is TextFormField && widget.key == Key('password'),
        );
        loginButton = find.byWidgetPredicate(
                (Widget widget) => widget is ElevatedButton,
        );
    });

    group('Integration Testing', () {
        testWidgets('Login successfully and go straight to the next page', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

            // Simulate valid username and password input
            await tester.enterText(usernameField, 'test');
            await tester.enterText(passwordField, 'password');

            // // Simulate login button tap
            await tester.tap(loginButton);
            await tester.pumpAndSettle();  // Wait for navigation to complete

            // Verify successful navigation to NextPage
            expect(find.byType(NextPage), findsOneWidget);
            expect(find.text('Login'), findsNothing);  // Login page not found
            expect(find.text('Halaman Berikutnya'), findsOneWidget);  // NextPage might be found
        });

        testWidgets('Login failed and not go straight to the next page', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

            // Simulate valid username and password input
            await tester.enterText(usernameField, 'test');
            await tester.enterText(passwordField, 'passwordnya');

            // // Simulate login button tap
            await tester.tap(loginButton);
            await tester.pump();
            await tester.pumpAndSettle();

            // Expect that pumpAndSettle will throw an error
            // Verify that the Snackbar is displayed
            // await expectLater(await tester.pumpAndSettle(), const TypeMatcher<int>());
            await expectLater(find.byType(SnackBar), findsOneWidget);

            // Verify that the Snackbar content matches the expected text
            final snackbarContentFinder = find.text('Invalid username or password');
            await expectLater(snackbarContentFinder, findsOneWidget);

            // Verify failed navigation to NextPage
            // expect(find.text('Invalid username or password'), findsOneWidget); // Login failed
            // expect(find.text('Login gagal! Silakan coba lagi.'), findsOneWidget); // Login failed
            // expect(find.text('Login'), findsOneWidget);  // Login page be and still found
            // expect(find.text('Halaman Berikutnya'), findsNothing);  // NextPage might not found
        });
    });



}
