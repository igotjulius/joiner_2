import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/index.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_widget.dart';
import 'package:joiner_1/pages/cra/car/cra_car_widget.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_widget.dart';
import 'package:joiner_1/pages/provider/cra_provider.dart';
import 'package:joiner_1/pages/shared_pages/login_page/login_page_widget.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_widget.dart';
import 'package:joiner_1/pages/user/dashboard/edit_lobby/edit_lobby_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/provider/user_provider.dart';
import 'package:joiner_1/pages/user/rentals/car_booking/car_booking_widget.dart';
import 'package:joiner_1/pages/user/rentals/payment_result/result_widget.dart';
import 'package:provider/provider.dart';

Widget testApp(String initialLocation) {
  final appState = FFAppState();
  appState.initializePersistedState().then((value) {
    appState.setCurrentUser(
      UserModel(
        id: 'user-1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'johndoe@gmail.com',
      ),
    );
  });

  appState.setIsCra(true);
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(
          mockUser(),
        ),
      ),
      ChangeNotifierProvider<CraProvider>(
        create: (_) => CraProvider(
          mockCraUser(),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => LobbyProvider.test(
          mockLobbies(),
        ),
      ),
      ChangeNotifierProvider<FFAppState>.value(value: appState),
    ],
    child: MaterialApp.router(
      routerConfig: mockRouter(initialLocation),
    ),
  );
}

List<CarModel> mockCars() {
  return [
    CarModel(
      licensePlate: 'WYSIWYG',
      ownerName: 'Doe',
      ownerId: '1',
      vehicleType: 'Sedan',
      availability: 'Available',
      startDate: DateTime.now(),
      endDate: DateTime(2025),
      price: 1234,
      photoUrl: [],
    ),
    CarModel(
      licensePlate: 'AWDFQW',
      ownerName: 'Doe',
      ownerId: '2',
      vehicleType: 'Sedan',
      availability: 'Available',
      startDate: DateTime.now(),
      endDate: DateTime(2025),
      price: 1234,
      photoUrl: [],
    ),
    CarModel(
      licensePlate: 'ZXCVXVB',
      ownerName: 'Doe',
      ownerId: '3',
      vehicleType: 'Sedan',
      availability: 'Available',
      startDate: DateTime.now(),
      endDate: DateTime(2025),
      price: 1234,
      photoUrl: [],
    ),
  ];
}

UserModel mockUser() {
  return UserModel(
    id: 'user-1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'johndoe@gmail.com',
    friends: [
      {
        'friendId': 'friend-1',
        'firstName': 'Juan',
        'lastName': 'Cruz',
        'status': 'accepted',
      },
    ],
    rentals: mockRentals(),
  );
}

CraUserModel mockCraUser() {
  return CraUserModel(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'johndoe@gmail.com',
    contactNo: '0987654321',
    address: 'LLC',
    vehicles: mockCars(),
    rentals: [],
  );
}

GoRouter mockRouter(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        name: 'Lobbies',
        path: '/lobbies',
        builder: (context, state) => LobbiesWidget(),
        routes: [
          GoRoute(
            name: 'LobbyCreation',
            path: 'createLobby',
            builder: (context, state) => LobbyCreationWidget(),
          ),
          GoRoute(
            name: 'Lobby',
            path: 'lobby',
            builder: (context, state) {
              LobbyModel obj = state.extraMap['currentLobby'];
              return LobbyPageWidget(
                currentLobby: obj,
                lobbyId: obj.id,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => SignUpPageWidget(),
      ),
      GoRoute(
        name: 'Login',
        path: '/login',
        builder: (context, state) => LoginPageWidget(),
        routes: [
          GoRoute(
            name: 'UserDashboard',
            path: 'userDashboard',
            builder: (context, state) => LobbiesWidget(),
          ),
        ],
      ),
      GoRoute(
        path: '/addCar',
        builder: (context, state) => AddCarWidget(),
      ),
      GoRoute(
        path: '/craCar',
        builder: (context, state) => CraCarWidget(),
      ),
      GoRoute(
        path: '/editCar',
        builder: (context, state) => EditCarWidget(
          car: mockCars()[0],
        ),
      ),
      GoRoute(
        path: '/rental',
        builder: (context, state) => CarBookingWidget(
          car: mockCars()[0],
        ),
        routes: [
          GoRoute(
            name: 'Success',
            path: 'success',
            builder: (context, state) => ResultWidget(result: 'success'),
          ),
        ],
      ),
      GoRoute(
        path: '/rentals',
        builder: (context, state) => RentalsWidget(),
      ),
    ],
  );
}

Map<String, List<LobbyModel>> mockLobbies() {
  return {
    'activeLobby': [
      LobbyModel(
        id: 'lobby-1',
        hostId: 'user-1',
        title: 'Beach',
        destination: 'Badian Beach',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        expense: ExpenseModel(
          id: 'e-1',
          items: {},
          total: 0,
        ),
        participants: [
          ParticipantModel(
            id: 'p-1',
            userId: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            joinStatus: 'Joined',
            type: 'Host',
          ),
        ],
        poll: [],
      ),
      LobbyModel(
        id: 'lobby-2',
        hostId: 'user-1',
        title: 'Hiking',
        destination: 'Mt. Kan-Irag',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        expense: ExpenseModel(
          id: 'e-1',
          items: {
            'Foods': 1234,
            'Drinks': 1234,
          },
          total: 2468,
        ),
        participants: [
          ParticipantModel(
            id: 'p-1',
            userId: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            joinStatus: 'Joined',
            type: 'Host',
          ),
          ParticipantModel(
            id: 'p-2',
            userId: 'user-2',
            firstName: 'Juan',
            lastName: 'Cruz',
            joinStatus: 'Joined',
            type: 'Participant',
          ),
        ],
        poll: [
          PollModel(
            id: 'poll-1',
            question: 'Meeting Time?',
            choices: [
              {
                'title': '7 AM',
                'voters': [],
              },
              {
                'title': '9 AM',
                'voters': [],
              },
              {
                'title': '10 AM',
                'voters': [],
              },
            ],
            isOpen: true,
          ),
        ],
      ),
      LobbyModel(
        id: 'lobby-2',
        hostId: 'user-1',
        title: 'RoadTrip',
        destination: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        expense: ExpenseModel(
          id: 'e-1',
          items: {},
          total: 0,
        ),
        participants: [
          ParticipantModel(
            id: 'p-1',
            userId: 'user-1',
            firstName: 'John',
            lastName: 'Doe',
            joinStatus: 'Joined',
            type: 'Host',
          ),
        ],
        poll: [],
      ),
    ],
    'pendingLobby': []
  };
}

List<MessageModel> mockMessages() {
  return [
    MessageModel(
      creator: 'Juan',
      creatorId: 'user-2',
      createdAt: DateTime.now(),
      message: 'Hello there',
    ),
    MessageModel(
      creator: 'Juan',
      creatorId: 'user-2',
      createdAt: DateTime.now(),
      message: 'I\'m excited for the weekend',
    ),
  ];
}

List<RentalModel> mockRentals() {
  return [
    RentalModel(
      id: '1',
      licensePlate: 'WYSIWYG',
      vehicleOwner: 'John Doe',
      renterUserId: 'renter-1',
      renterName: 'Juan Cruz',
      startRental: DateTime.now(),
      endRental: DateTime.now(),
      duration: 1,
      rentalStatus: 'Incomplete',
      price: 123,
      linkedLobbyId: 'lobby-1',
      paymentId: 'payment-1',
      paymentStatus: 'Paid',
    ),
    RentalModel(
      id: '2',
      licensePlate: 'AWDFQW',
      vehicleOwner: 'John Doe',
      renterUserId: 'renter-1',
      renterName: 'Juan Cruz',
      startRental: DateTime.now(),
      endRental: DateTime.now(),
      duration: 1,
      rentalStatus: 'Incomplete',
      price: 123,
      linkedLobbyId: 'lobby-1',
      paymentId: 'payment-1',
      paymentStatus: 'Paid',
    ),
    RentalModel(
      id: '3',
      licensePlate: 'ZXCVXVB',
      vehicleOwner: 'John Doe',
      renterUserId: 'renter-1',
      renterName: 'Juan Cruz',
      startRental: DateTime.now(),
      endRental: DateTime.now(),
      duration: 1,
      rentalStatus: 'Incomplete',
      price: 123,
      linkedLobbyId: 'lobby-1',
      paymentId: 'payment-1',
      paymentStatus: 'Paid',
    ),
  ];
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}
