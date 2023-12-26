import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/pages/shared_pages/login_page/login_page_widget.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_widget.dart';
import 'package:joiner_1/pages/shared_pages/verification/verification_widget.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController<T extends Auth> extends ChangeNotifier {
  static final ApiService _apiService = ApiService(Dio());
  T? userTypeController;
  late SharedPreferences pref;

  static List<GoRoute> _routes = baseRoutes();
  static List<GoRoute> baseRoutes() {
    return [
      GoRoute(
        name: 'Login',
        path: '/login',
        builder: (context, params) => LoginPageWidget(),
      ),
      GoRoute(
        name: 'Sign Up',
        path: '/sign-up',
        builder: (context, params) => SignUpPageWidget(),
      ),
      GoRoute(
        name: 'Verification',
        path: '/verification',
        builder: (context, params) => VerificationWidget(),
      ),
    ];
  }

  List<GoRoute> get routes => _routes;
  void setRoutes(List<GoRoute> nRoutes) {
    _routes.addAll(nRoutes);
    notifyListeners();
  }

  // Register CRA
  Future<String?> registerCra(User nUser) async {
    final result = await _apiService.registerCra(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Register Joiner
  Future<String?> registerUser(User nUser) async {
    final result = await _apiService.registerUser(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Login CRA/Joiner
  Future<User?> loginUser(String email, String password) async {
    final result =
        await _apiService.loginUser({'email': email, 'password': password});

    // TODO: This the part where the user is redirected to its appropriate dashboard
    if (result.code == HttpStatus.ok) {
      if (result.message == 'CraUser') {
        userTypeController =
            CraController(result.data! as CraUserModel, _apiService) as T;
      } else {
        userTypeController =
            UserController(result.data! as UserModel, _apiService) as T;
      }
      userTypeController?.cacheUser();
      notifyListeners();
    }

    return result.data;
  }

  void logout() {
    userTypeController?.logout();
    userTypeController = null;
    _routes = baseRoutes();
    notifyListeners();
  }

  Future initializePersistedState() async {
    final _pref = await SharedPreferences.getInstance();
    var cachedUser = _pref.getString('user');
    if (cachedUser != null) {
      Map<String, dynamic> user = jsonDecode(cachedUser);
      userTypeController =
          UserController(UserModel.fromJson(user), _apiService) as T;
      return;
    }
    cachedUser = _pref.getString('craUser');
    if (cachedUser != null) {
      Map<String, dynamic> craUser = jsonDecode(cachedUser);
      userTypeController =
          CraController(CraUserModel.fromJson(craUser), _apiService) as T;
      return;
    }
    print('Neither user or cra user is cached.');
  }

  FutureOr<String?> redirectState(GoRouterState state) {
    bool loggingIn =
        userTypeController != null && state.matchedLocation == '/login';
    bool loggingOut =
        userTypeController == null && state.matchedLocation == '/account';
    if (loggingIn)
      return userTypeController is CraController ? '/cars' : '/lobby';
    if (loggingOut) return '/login';
    return null;
  }
}

abstract interface class Auth {
  User get profile;
  Future cacheUser();
  void logout();
  bool isVerified();
}
