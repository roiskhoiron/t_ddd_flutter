import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/application/user_service.dart';
import 'package:t_ddd_flutter/domain/entities/login_response.dart';
import 'package:t_ddd_flutter/presentation/login_page.dart';
import 'package:t_ddd_flutter/presentation/next_page.dart';

import '../application/user_service_test.mocks.dart';
  // Add this line for mocking

@GenerateMocks([UserService])
void main() {
    group('Login Page ', () {
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

        testWidgets('Simulate navigation by tapping login button with correct data ', (tester) async {
            await tester.pumpWidget(MaterialApp(home: LoginPage()));

            // Simulate valid username and password input
            await tester.enterText(usernameField, 'test');
            await tester.enterText(passwordField, 'password');

            // // Simulate login button tap
            await tester.tap(loginButton);
            await tester.pump();  // Wait for navigation to complete

            // Verify successful navigation to NextPage

            expect(find.text('Login'), findsNothing);  // Login page not found
            expect(find.text('Halaman Berikutnya'), findsOneWidget);  // NextPage might be found
        });

        testWidgets('Negative State for loggin button tapped before input text field username and password',
                (WidgetTester tester) async {

                await tester.pumpWidget(MaterialApp(home: LoginPage()));

                await tester.tap(loginButton);
                await tester.pump();

                // Assert initial state (empty fields)
                expect(find.text('Username tidak boleh kosong'), findsOneWidget);
                expect(find.text('Password tidak boleh kosong'), findsOneWidget);

            });


    });

}
