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

class AuthController extends ChangeNotifier {
  static final ApiService _apiService = ApiService(Dio());
  Auth? _userTypeController;
  Auth? get userTypeController => _userTypeController;

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

    /* 
      This is the part where the user is redirected to its appropriate dashboard.
      Whenever the _userTypeController is initialized, it notifies the state of the app,
      that it will be updated and automatically redirects to the appropriate dashboard
      based on the logged in user.
    */
    if (result.code == HttpStatus.ok) {
      if (result.message == 'CraUser') {
        _userTypeController =
            CraController(result.data! as CraUserModel, _apiService);
      } else {
        _userTypeController =
            UserController(result.data! as UserModel, _apiService);
      }
      _userTypeController?.cacheUser();
      setRoutes(_userTypeController!.routes);
    }
    return result.data;
  }

  void logout() {
    _userTypeController?.logout();
    _userTypeController = null;
    _routes = baseRoutes();
    notifyListeners();
  }

  Future initializePersistedState() async {
    final _pref = await SharedPreferences.getInstance();
    var cachedUser = _pref.getString('user');
    if (cachedUser != null) {
      Map<String, dynamic> user = jsonDecode(cachedUser);
      _userTypeController =
          UserController(UserModel.fromJson(user), _apiService);
      setRoutes(_userTypeController!.routes);
      return;
    }
    cachedUser = _pref.getString('craUser');
    if (cachedUser != null) {
      Map<String, dynamic> craUser = jsonDecode(cachedUser);
      _userTypeController =
          CraController(CraUserModel.fromJson(craUser), _apiService);
      setRoutes(_userTypeController!.routes);
      return;
    }
    print('Neither user or cra user is cached.');
  }
}

abstract class Auth extends ChangeNotifier {
  User? get profile;
  List<GoRoute> get routes;
  Future cacheUser();
  void logout();
  bool isVerified();
}
