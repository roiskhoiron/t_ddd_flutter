
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:t_ddd_flutter/presentation/login_page.dart';

void main() {

  testGoldens('Golden test example', (tester) async {
    // Capture a golden image
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.iphone11
      ])
      ..addScenario(
        widget: LoginPage(),
        name: 'login page',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'login_page');
  });

  testGoldens('sekenario login button', (tester) async {

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.iphone11
      ])
      ..addScenario(
        widget: LoginPage(),
        name: 'login page',
        onCreate: (key) async {
          var inputUsername = find.byKey(const Key('username'));
          var inputPassword = find.byKey(const Key('password'));

          expect(inputUsername, findsOneWidget);
          expect(inputPassword, findsOneWidget);

        }
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'login_page');
  });
}