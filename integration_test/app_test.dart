import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/index.dart';
import 'package:joiner_1/mock/test_utils.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/modals/survey_poll_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/mole/poll_mole.dart';
import 'package:joiner_1/widgets/atoms/budget_category.dart';
import 'package:joiner_1/widgets/atoms/poll_choices.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';
import 'package:joiner_1/widgets/molecules/active_lobby_mole.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  manageAccount();
  manageLobby();
  manageChat();
  manageResources();
  managePoll();
  manageParticipants();
  manageCars();
  rentals();
}

void manageAccount() {
  group('Testing: Account Management', () {
    testWidgets('Register Account - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/signUp'),
      );
      await widgetTester.pumpAndSettle();
      final signUpBtn = find.text('Sign Up').first;

      // Action
      await widgetTester.dragUntilVisible(find.text('First name'),
          find.byType(UserSignUpMole), Offset(0, -250));
      await widgetTester.enterText(find.byType(TextFormField).at(0), 'John');
      await widgetTester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await widgetTester.enterText(
          find.byType(TextFormField).at(2), 'johndoe@gmail.com');
      await widgetTester.dragUntilVisible(
          find.text('Password'), find.byType(UserSignUpMole), Offset(0, -250));
      await widgetTester.enterText(find.byType(TextFormField).at(3), '123456');
      await widgetTester.enterText(find.byType(TextFormField).at(4), '123456');
      await widgetTester.tap(signUpBtn);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.byType(LoginPageWidget), findsOneWidget);
    });

    testWidgets('Register Account - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/signUp'),
      );
      await widgetTester.pumpAndSettle();
      final signUpBtn = find.text('Sign Up').first;

      // Action
      await widgetTester.enterText(
          find.byType(TextFormField).at(2), 'invalidemail');
      await widgetTester.dragUntilVisible(
          find.text('Password'), find.byType(UserSignUpMole), Offset(0, -250));
      await widgetTester.enterText(
          find.byType(TextFormField).at(3), 'password');
      await widgetTester.enterText(
          find.byType(TextFormField).at(4), 'notmatchingpassword');
      await widgetTester.tap(signUpBtn);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Field is empty'), findsAny);
      expect(find.text('Email is not valid'), findsOneWidget);
      expect(find.text('Passwords don\'t match'), findsAny);
    });

    testWidgets('Login Account - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/login'),
      );
      await widgetTester.pumpAndSettle();

      final emailFormField = find.byKey(Key('emailField'));
      final passFormField = find.byKey(Key('passwordField'));
      final loginButton = find.byKey(Key('loginButton'));

      // Action
      await widgetTester.enterText(emailFormField, '1@gmail.com');
      await widgetTester.enterText(passFormField, '123456');
      await widgetTester.tap(loginButton);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.byType(LobbiesWidget), findsOneWidget);
    });

    testWidgets('Login Account - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/login'),
      );
      await widgetTester.pumpAndSettle();

      final emailFormField = find.byKey(Key('emailField'));
      final passFormField = find.byKey(Key('passwordField'));
      final loginButton = find.byKey(Key('loginButton'));

      // Action
      await widgetTester.tap(loginButton);
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.text('Field is empty'), findsAny);

      // Action
      await widgetTester.enterText(emailFormField, '0@gmail.com');
      await widgetTester.enterText(passFormField, '123456');
      await widgetTester.dragUntilVisible(
          loginButton, find.byType(Scaffold), Offset(0, -250));
      await widgetTester.pump();
      await widgetTester.tap(loginButton);
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.text('Invalid username/password'), findsAny);
    });
  });
}

void manageLobby() {
  group('Testing: Manage Lobby', () {
    testWidgets('Create Lobby - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byType(Card), findsNWidgets(3));

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, 'Beach');
      await widgetTester.tap(find.text('CREATE'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.byType(Card), findsNWidgets(4));
    });

    testWidgets('Create Lobby - Title input is empty', (widgetTester) async {
      await widgetTester.pumpWidget(
        testApp('/lobbies/createLobby'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.enterText(find.byType(TextFormField).first, '');
      await widgetTester.tap(find.text('CREATE'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Field is empty'), findsOneWidget);
    });

    testWidgets('Edit Lobby - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();
      final newTitle = 'Not beach';

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Edit details'));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, '');
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, newTitle);
      await widgetTester.tap(find.text('Save'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text(newTitle), findsOneWidget);
    });

    testWidgets('Edit Lobby - Title input is empty', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Edit details'));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, '');
      await widgetTester.tap(find.text('Save'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Field is empty'), findsOneWidget);
    });

    testWidgets('Leave Lobby', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(PopupMenuButton<int>));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Leave lobby'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.byType(Card), findsNWidgets(2));
    });
  });
}

void manageChat() {
  group('Testing: Manage Chat', () {
    testWidgets('Display messages', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Chat'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Juan'), findsNWidgets(2));
    });

    testWidgets('Broadcast message', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Chat'));
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.enterText(find.byType(TextField), 'Yeah, me too');
      await widgetTester.tap(find.text('SEND'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Yeah, me too'), findsOneWidget);
      expect(find.text('Juan'), findsNWidgets(2));
    });
  });
}

void manageResources() {
  group('Testing: Manage Resources', () {
    testWidgets('Add expense - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Resources'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).first, 'Foods');
      await widgetTester.enterText(find.byType(TextFormField).last, '1234');
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Add'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Foods'), findsOneWidget);
    });
    testWidgets('Add expense - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Resources'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Add'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Field is empty'), findsAny);
    });

    testWidgets('Remove expense', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Resources'));
      await widgetTester.pumpAndSettle();

      expect(
        find.descendant(
            of: find.byType(ListView),
            matching: find.byType(BudgetCategoryWidget)),
        findsNWidgets(2),
      );

      await widgetTester.longPress(find.byType(BudgetCategoryWidget).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Yes'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(
        find.descendant(
            of: find.byType(ListView),
            matching: find.byType(BudgetCategoryWidget)),
        findsNWidgets(1),
      );
    });
  });
}

void managePoll() {
  group('Testing: Manage Poll', () {
    testWidgets('Add poll - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();
      final addBtn = find.text('Add a Choice');
      final createBtn = find.text('Create');

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Poll'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(addBtn);
      await widgetTester.tap(addBtn);
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(
          find.byType(TextFormField).first, 'Meeting time?');
      await widgetTester.dragUntilVisible(
          createBtn, find.byType(SurveyPollWidget), Offset(0, -250));
      await widgetTester.enterText(find.byType(TextFormField).at(1), '7 AM');
      await widgetTester.enterText(find.byType(TextFormField).at(2), '9 AM');
      await widgetTester.enterText(find.byType(TextFormField).at(3), '10 AM');
      await widgetTester.dragUntilVisible(
          createBtn, find.byType(SurveyPollWidget), Offset(0, -250));

      await widgetTester.pumpAndSettle();
      await widgetTester.tap(createBtn);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Meeting time?'), findsOneWidget);
    });

    testWidgets('Add poll - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();
      final createBtn = find.text('Create');

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Poll'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(createBtn);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Field is empty'), findsAny);
    });

    testWidgets('Vote poll', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Poll'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(PollChoices).first,
          warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('1 votes'), findsOneWidget);
    });

    testWidgets('Close poll', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Poll'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Close poll'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Re-open poll'), findsOneWidget);
    });

    testWidgets('Remove poll', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Poll'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byIcon(Icons.delete));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(
        find.descendant(
            of: find.byType(ListView), matching: find.byType(PollMolecule)),
        findsNothing,
      );
    });
  });
}

void manageParticipants() {
  group('Testing: Manage Participants', () {
    testWidgets('Add participant - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Joiners'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(ParticipantMole), findsOneWidget);

      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Checkbox).first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Invite'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.byType(ParticipantMole), findsNWidgets(2));
    });

    testWidgets('Remove participant', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/lobbies'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.text('Lobbies'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(Card).at(1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Joiners'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(ParticipantMole), findsNWidgets(2));

      await widgetTester.tap(find.byIcon(Icons.remove));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Yes'));
      await widgetTester.pumpAndSettle();

      // Testing
      expect(find.text('Participant removed'), findsOneWidget);
      expect(find.byType(ParticipantMole), findsOneWidget);
    });
  });
}

void rentals() {
  group('Testing: Rentals', () {
    testWidgets('Rent a car - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/rental'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      // Tap date picker
      await widgetTester.tap(find.byKey(Key('datePicker')).first);
      await widgetTester.pump();
      // Select dates
      await widgetTester.tap(find.text('${DateTime.now().day}').first);
      await widgetTester
          .tap(find.text('${DateTime.now().add(Duration(days: 3)).day}').first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Save'));
      await widgetTester.pumpAndSettle();
      // Click next
      final button = find.byType(FilledButton).first;
      await widgetTester.dragUntilVisible(
          button, find.byType(Scaffold), Offset(0, -250));
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.text('Total'), findsOneWidget);

      // Click next
      await widgetTester.tap(find.byType(FilledButton).first);
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.text('Payment sent'), findsOneWidget);
    });

    testWidgets('Rent a car - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/rental'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      // Click next
      await widgetTester.tap(find.byType(FilledButton).first);
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.text('Minimum rent duration is one day'), findsOneWidget);
    });

    testWidgets('Display rentals', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/rentals'),
      );
      await widgetTester.pumpAndSettle();

      // Test
      expect(find.byType(RentalInfo), findsNWidgets(3));
    });
  });
}

void manageCars() {
  group('Testing: Manage car', () {
    testWidgets('Register car - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/addCar'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.byKey(Key('vehicleType')));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Van').first, warnIfMissed: false);
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).at(0), 'WYSIWYG');
      widgetTester
          .widget<TextFormField>(find.byType(TextFormField).at(1))
          .controller
          ?.text = 'Dec 5 - Dec 10';
      await widgetTester.enterText(find.byType(TextFormField).at(2), '100');
      await widgetTester.tap(find.text('Register').first);
      await widgetTester.pumpAndSettle();

      // Testing
      await widgetTester.pump(Duration(seconds: 4));
      expect(find.text('Car registered successfully'), findsOneWidget);
    });

    // Setup
    testWidgets('Register car - Invalid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/addCar'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      await widgetTester.tap(find.byKey(Key('vehicleType')));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Van').first, warnIfMissed: false);
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(find.byType(TextFormField).at(0), 'WYSIWYG');
      widgetTester
          .widget<TextFormField>(find.byType(TextFormField).at(1))
          .controller
          ?.text = 'Dec 5 - Dec 10';
      final button = find.text('Register').first;
      await widgetTester.tap(button);

      // Testing
      await widgetTester.pump();
      expect(find.text('Registration failed'), findsOneWidget);
    });

    testWidgets('Edit car - Valid entries', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/editCar'),
      );
      await widgetTester.pumpAndSettle();

      // Action
      // Tap date picker
      final datePicker = find.byKey(Key('datePicker'));
      await widgetTester.tap(datePicker);
      await widgetTester.pumpAndSettle();
      // Select dates
      await widgetTester.tap(find.text('${DateTime.now().day}').first);
      await widgetTester
          .tap(find.text('${DateTime.now().add(Duration(days: 3)).day}').first);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Save'));
      await widgetTester.pump(Duration(seconds: 4));
      await widgetTester.pumpAndSettle();
      // Tap dropdownmenu
      final vehicleType = find.byKey(Key('vehicleType'));
      await widgetTester.tap(vehicleType);
      await widgetTester.pumpAndSettle();
      // Select choice from dropdownmenu
      await widgetTester.tap(find.text('SUV').last);
      await widgetTester.pumpAndSettle();
      // Tap dropdownmenu
      final availability = find.byKey(Key('availability'));
      await widgetTester.tap(availability);
      // Select choice from dropdownmenu
      await widgetTester.tap(find.text('Unavailable').last,
          warnIfMissed: false);
      await widgetTester.pumpAndSettle();

      // Tap button
      final button = find.byType(FilledButton).first;
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();

      // Enter price
      await widgetTester.enterText(find.byType(TextFormField).last, '1234');
      await widgetTester.pumpAndSettle();
      // Tap button
      await widgetTester.tap(button);
      await widgetTester.pump();

      // Testing
      expect(find.text('Changes saved'), findsOneWidget);
    });

    testWidgets('Remove car', (widgetTester) async {
      // Setup
      await widgetTester.pumpWidget(
        testApp('/craCar'),
      );
      await widgetTester.pumpAndSettle();

      // Testing
      expect(
        find.byType(CarItemWidget),
        findsNWidgets(3),
      );

      // Action
      await widgetTester.longPress(find.byType(CarItemWidget).first,
          warnIfMissed: false);
      await widgetTester.pump();
      await widgetTester.tap(find.text('Remove').last);
      await widgetTester.pumpAndSettle();

      // Testing
      expect(
        find.byType(CarItemWidget),
        findsNWidgets(2),
      );
    });
  });
}
