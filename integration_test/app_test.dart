import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/main.dart' as app;
import 'package:joiner_1/mock/test_utils.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_widget.dart';
import 'package:joiner_1/pages/cra/car/cra_car_widget.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_widget.dart';
import 'package:joiner_1/pages/provider/cra_provider.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  manageAccount();
  manageCars();
}

void manageAccount() {
  group('Testing: Account Management', () {
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
  group('Testing: Manage car', () {
    testWidgets('Register car - Valid and invalid entries',
        (widgetTester) async {
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

      // Testing
      await widgetTester.pump();
      expect(find.text('Registration failed'), findsOneWidget);

      await widgetTester.enterText(priceField, '100');
      await widgetTester.pumpAndSettle(Duration(seconds: 2));

      await widgetTester.dragUntilVisible(
          button, find.byType(Scaffold), Offset(0, -250));
      await widgetTester.tap(button);

      // Testing
      await widgetTester.pump(Duration(seconds: 2));
      expect(find.text('Car registered successfully'), findsOneWidget);
    });

    testWidgets('Edit car - Valid entries', (widgetTester) async {
      // Setup
      final car = CarModel(
        licensePlate: 'WYSIWYG',
        ownerId: '1234',
        ownerName: 'Juan',
        vehicleType: 'Van',
        availability: 'Available',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        price: 1234,
        photoUrl: [],
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCarWidget(
            car: car,
          ),
        ),
      );

      // Action
      // Tap date picker
      final datePicker = find.byKey(Key('datePicker'));
      await widgetTester.tap(datePicker);
      await widgetTester.pumpAndSettle();
      // Select dates
      await widgetTester.tap(find.text('19').first);
      await widgetTester.tap(find.text('22').first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Save'));
      await widgetTester.pump(Duration(seconds: 4));
      await widgetTester.pumpAndSettle();
      // Tap dropdownmenu
      final vehicleType = find.byKey(Key('vehicleType'));
      await widgetTester.tap(vehicleType);
      await widgetTester.pumpAndSettle();
      // Select choice from dropdownmenu
      await widgetTester.tap(find.text('SUV').last, warnIfMissed: false);
      await widgetTester.pumpAndSettle();
      // Tap dropdownmenu
      final availability = find.byKey(Key('availability'));
      await widgetTester.tap(availability);
      // Select choice from dropdownmenu
      await widgetTester.tap(find.text('Unavailable').last,
          warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      // Tap button
      final button = find.byType(FilledButton);
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();

      // Enter price
      await widgetTester.enterText(find.byType(TextFormField).last, '1234');
      await widgetTester.pumpAndSettle();
      // Tap button
      await widgetTester.tap(button);
      await widgetTester.pump(Duration(seconds: 2));

      // Testing
      expect(find.text('Changes saved'), findsOneWidget);
    });

    testWidgets('Edit car - On rent status', (widgetTester) async {
      // Setup
      final car = CarModel(
        licensePlate: 'WYSIWYG',
        ownerId: '1234',
        ownerName: 'Juan',
        vehicleType: 'Van',
        availability: 'On rent',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        price: 1234,
        photoUrl: [],
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: EditCarWidget(
            car: car,
          ),
        ),
      );

      // Testing
      expect(find.text('Save changes'), findsNothing);
    });

    testWidgets('Remove car', (widgetTester) async {
      final appState = FFAppState();
      appState.setIsCra(true);
      final _router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => CraCarWidget(),
          ),
        ],
      );
      // Setup
      await widgetTester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: appState),
            ChangeNotifierProvider(
              create: (_) => CraProvider(
                mockCraUser(),
              ),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: _router,
          ),
        ),
      );

      // Testing
      expect(
        find.byType(CarItemWidget),
        findsNWidgets(3),
      );

      // Action
      await widgetTester.longPress(find.byType(CarItemWidget).first);
      await widgetTester.pump();
      await widgetTester.tap(find.text('Remove').last);
      await widgetTester.pump();

      // Testing
      expect(
        find.byType(CarItemWidget),
        findsNWidgets(2),
      );

      // Action
      await widgetTester.longPress(find.byType(CarItemWidget).last);
      await widgetTester.pump();
      expect(find.text('Car still on rent'), findsOneWidget);
    });
  });
}
