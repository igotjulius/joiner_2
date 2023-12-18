import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joiner_1/main.dart' as app;
import 'package:joiner_1/pages/cra/car/add_car/add_car_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  manageAccount();
  manageCars();
}

void manageAccount() {
  group('Integration Test: Account Management', () {
    testWidgets('Login', (widgetTester) async {
      // Setup
      app.main();
      await widgetTester.pumpAndSettle();

      final emailFormField = find.byKey(Key('emailField'));
      final passFormField = find.byKey(Key('passwordField'));
      final loginButton = find.byKey(Key('loginButton'));

      // Action
      widgetTester.enterText(emailFormField, '0@gmail.com');
      widgetTester.enterText(passFormField, '123456');
      await widgetTester.tap(loginButton);
      await widgetTester.pumpAndSettle();

      // Test
      final hasError =
          widgetTester.widget<TextFormField>(emailFormField).validator;
      expect(hasError, null);
    });
  });
}

void manageCars() {
  group('Testing', () {
    testWidgets('Register car', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: AddCarWidget(),
        ),
      );

      final licenseField = find.byType(TextFormField).at(0);
      final vehicleTypeMenu = find.byKey(Key('vehicleType'));
      final datesField = find.byType(TextFormField).at(1);
      final priceField = find.byType(TextFormField).at(2);

      // Action
      await widgetTester.enterText(licenseField, 'WYSIWYG');

      await widgetTester.tap(vehicleTypeMenu);
      await widgetTester.pumpAndSettle();
      final vehicleType = find.text('Van').first;
      await widgetTester.tap(vehicleType);
      await widgetTester.pumpAndSettle();

      widgetTester.widget<TextFormField>(datesField).controller?.text =
          'Dec 5 - Dec 10';

      final button = find.byKey(Key('submit'));
      await widgetTester.dragUntilVisible(
          button, find.byType(Scaffold), Offset(0, -250));
      await widgetTester.tap(button);

      await widgetTester.pump();
      expect(find.text('Registration failed'), findsOneWidget);

      await widgetTester.enterText(priceField, '100');
      await widgetTester.pumpAndSettle(Duration(seconds: 2));

      await widgetTester.dragUntilVisible(
          button, find.byType(Scaffold), Offset(0, -250));
      await widgetTester.tap(button);

      await widgetTester.pump(Duration(seconds: 2));
      expect(find.text('Car registered successfully'), findsOneWidget);
    });
  });
}
