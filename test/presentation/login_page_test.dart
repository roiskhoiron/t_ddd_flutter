import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:t_ddd_flutter/application/user_service.dart';
import 'package:t_ddd_flutter/presentation/login_page.dart';

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

    group('Widget testing ', () {


        testWidgets('LoginPage renders correctly and validates user input', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));
            await tester.pump();

            expect(usernameField, findsOneWidget);
            expect(passwordField, findsOneWidget);
            expect(loginButton, findsOneWidget);
        });

        testWidgets('Simulate empty username input', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

            // Simulate empty username input
            await tester.enterText(usernameField, '');
            await tester.tap(loginButton);
            await tester.pump();

            // Assert username validation error
            expect(find.text('Username tidak boleh kosong'), findsOneWidget);
        });

        testWidgets('Simulate empty password input', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

             // Simulate empty password input
            await tester.enterText(passwordField, '');
            await tester.tap(loginButton);
            await tester.pump();

            // Assert password validation error
            expect(find.text('Password tidak boleh kosong'), findsOneWidget);
        });


        testWidgets(' Simulate valid username and password input', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

            // Simulate valid username and password input
            await tester.enterText(usernameField, 'valid_username');
            await tester.enterText(passwordField, 'valid_password');
            await tester.tap(loginButton);
            await tester.pump();

            // Assert validation errors disappear and no other errors are present
            expect(find.text('Username tidak boleh kosong'), findsNothing);
            expect(find.text('Password tidak boleh kosong'), findsNothing);
            expect(find.text('Login gagal! Silakan coba lagi.'), findsNothing);
        });



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

            expect(find.text('Login'), findsNothing);  // Login page not found
            expect(find.text('Halaman Berikutnya'), findsOneWidget);  // NextPage might be found
        });

        // testWidgets('Login failed and not go straight to the next page', (tester) async {
        //     await tester.pumpWidget(MaterialApp(home: LoginPage()));
        //
        //     // Simulate valid username and password input
        //     await tester.enterText(usernameField, 'test');
        //     await tester.enterText(passwordField, 'passwordnya');
        //
        //     // // Simulate login button tap
        //     await tester.tap(loginButton);
        //     await tester.pump(Duration(seconds: 2));  // Wait for navigation to complete
        //
        //
        //     // Expect that pumpAndSettle will throw an error
        //     // Verify that the Snackbar is displayed
        //     expect(find.byType(SnackBar), findsOneWidget);
        //
        //     // Verify that the Snackbar content matches the expected text
        //     final snackbarContentFinder = find.text('Invalid username or password');
        //     expect(snackbarContentFinder, findsOneWidget);
        //     // expectLater(tester.pumpAndSettle(), throwsA(const TypeMatcher<InvalidCredentialsException>()));
        //
        //     // Verify failed navigation to NextPage
        //     // expectLater(find.text('Invalid username or password'), findsOneWidget); // Login failed
        //     // expect(find.text('Login gagal! Silakan coba lagi.'), findsOneWidget); // Login failed
        //     // expectLater(find.text('Login'), findsOneWidget);  // Login page be and still found
        //     // expectLater(find.text('Halaman Berikutnya'), findsNothing);  // NextPage might not found
        // });
    });

}
