import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joiner_1/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test: Login', (widgetTester) async {
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
}
