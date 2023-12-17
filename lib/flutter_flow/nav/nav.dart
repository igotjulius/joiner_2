import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_widget.dart';
import 'package:joiner_1/pages/cra/car/cra_car_widget.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_widget.dart';
import 'package:joiner_1/pages/cra/rentals/cra_rentals_widget.dart';
import 'package:joiner_1/pages/shared_pages/rental_details/rental_details_widget.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_widget.dart';
import 'package:joiner_1/pages/user/dashboard/map_feature/map_feature.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/rentals/car_booking/car_booking_widget.dart';
import 'package:joiner_1/pages/user/rentals/car_details/car_details_widget.dart';
import 'package:joiner_1/pages/user/rentals/listings/listings_widget.dart';
import 'package:joiner_1/pages/user/rentals/payment_result/result_widget.dart';
import 'package:provider/provider.dart';
import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._() {
    setRoutes();
  }

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }

  List<FFRoute> _routes = baseRoute();
  List<FFRoute> get routes => _routes;
  void setRoutes() {
    final appState = FFAppState();
    _routes = baseRoute();
    if (appState.isCra) {
      _routes.addAll(craRoutes());
    } else {
      _routes.addAll(userRoutes());
    }

    notifyListeners();
  }

  FutureOr<String?> redirectState(
      BuildContext context, GoRouterState state, FFAppState appState) {
    bool loggingIn =
        appState.currentUser != null && state.matchedLocation == '/login';
    bool loggingOut =
        appState.currentUser == null && state.matchedLocation == '/account';
    if (loggingIn) return appState.isCra ? '/cars' : '/lobby';
    if (loggingOut) return '/login';

    return null;
  }
}

List<FFRoute> baseRoute() {
  List<FFRoute> routes = [
    FFRoute(
      name: 'Login',
      path: '/login',
      builder: (context, params) => LoginPageWidget(),
    ),
    FFRoute(
      name: 'Sign Up',
      path: '/sign-up',
      builder: (context, params) => SignUpPageWidget(),
    ),
  ];
  return routes;
}

List<FFRoute> userRoutes() {
  return [
    FFRoute(
      name: 'MainDashboard',
      path: '/lobby',
      builder: (context, params) => NavBarPage(initialPage: 'MainDashboard'),
      routes: [
        GoRoute(
          name: 'LobbyCreation',
          path: 'create',
          builder: (context, state) {
            final selectedDestination = state.extraMap['destination'];
            return LobbyCreationWidget(
              destination: selectedDestination,
            );
          },
        ),
        GoRoute(
          name: 'BrowseMap',
          path: 'browseMap',
          builder: (context, state) => MapFeature(),
        ),
        GoRoute(
          name: 'Lobby',
          path: ':lobbyId',
          builder: (context, state) {
            final obj = state.extraMap['currentLobby'] ??= null;
            return ChangeNotifierProvider(
              create: (_) => LobbyProvider(obj),
              child: LobbyPageWidget(
                currentLobby: obj,
                lobbyId: state.pathParameters['lobbyId'],
              ),
            );
          },
        ),
      ],
    ),
    FFRoute(
      name: 'CarRentals',
      path: '/rentals',
      builder: (context, params) => params.isEmpty
          ? NavBarPage(initialPage: 'CarRentals')
          : NavBarPage(
              initialPage: 'CarRentals',
              page: RentalsWidget(),
            ),
      routes: [
        GoRoute(
          name: 'Listings',
          path: 'listings',
          builder: (context, params) => ListingsWidget(),
        ),
        GoRoute(
            name: 'CarDetails',
            path: 'carDetails',
            builder: (context, state) {
              CarModel obj = state.extraMap['car'] as CarModel;
              return CarDetails(car: obj);
            }),
        GoRoute(
          name: 'Booking',
          path: 'booking',
          builder: (context, state) {
            CarModel obj = state.extraMap['car'] as CarModel;
            return CarBookingWidget(car: obj);
          },
        ),
        GoRoute(
          name: 'RentalDetails',
          path: 'rentalDetails',
          builder: (context, state) {
            final RentalModel rental = state.extraMap['rental'] as RentalModel;
            return RentalDetails(
              rental: rental,
            );
          },
        ),
        GoRoute(
          name: 'Result',
          path: ':paymentResult',
          builder: (context, state) {
            final result = state.pathParameters['paymentResult'] as String;
            return ResultWidget(
              result: result,
            );
          },
        ),
        GoRoute(
            path: 'success',
            builder: (context, state) => ResultWidget(result: 'success')),
      ],
    ),
    FFRoute(
      name: 'Friends',
      path: '/friends',
      builder: (context, params) =>
          params.isEmpty ? NavBarPage(initialPage: 'Friends') : FriendsWidget(),
      routes: [
        GoRoute(
          name: 'InviteFriend',
          path: 'invite-request',
          builder: (context, params) => InviteFriendWidget(),
        ),
      ],
    ),
    FFRoute(
      name: 'Account',
      path: '/account',
      builder: (context, params) =>
          params.isEmpty ? NavBarPage(initialPage: 'Account') : AccountWidget(),
    ),
  ];
}

List<FFRoute> craRoutes() {
  return [
    FFRoute(
      name: 'Cars',
      path: '/cars',
      builder: (context, params) =>
          params.isEmpty ? NavBarPage(initialPage: 'Cars') : CraCarWidget(),
      routes: [
        GoRoute(
          name: 'RegisterCar',
          path: 'registerCar',
          builder: (context, state) => AddCarWidget(),
        ),
        GoRoute(
          name: 'CarDetails',
          path: ':licensePlate',
          builder: (context, state) {
            final obj = state.extraMap['car'] ??= null;
            return EditCarWidget(
              car: obj,
            );
          },
        ),
      ],
    ),
    FFRoute(
      name: 'CraRentals',
      path: '/craRentals',
      builder: (context, params) => NavBarPage(
        initialPage: 'CraRentals',
        page: CraRentalsWidget(),
      ),
      routes: [
        GoRoute(
          name: 'RentalDetails',
          path: 'rentalDetails',
          builder: (context, state) {
            final RentalModel rental = state.extraMap['rental'] as RentalModel;
            return RentalDetails(
              rental: rental,
            );
          },
        ),
      ],
    ),
    FFRoute(
      name: 'Account',
      path: '/account',
      builder: (context, params) => params.isEmpty
          ? NavBarPage(initialPage: 'Account')
          : NavBarPage(
              initialPage: 'Account',
              page: AccountWidget(),
            ),
    ),
  ];
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
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

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
