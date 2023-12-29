import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/pages/shared_pages/login_page/login_page_widget.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_widget.dart';
import 'package:joiner_1/pages/shared_pages/verification/verification_widget.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  final ApiService _apiService = ApiService(Dio());
  Auth? _userTypeController;
  Auth? get userTypeController => _userTypeController;

  static List<GoRoute> _routes = baseRoutes();
  static List<GoRoute> baseRoutes() {
    return [
      GoRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => LoginPageWidget(),
          pageBuilder: (context, state) => topToBottomTransition<void>(
              context: context, state: state, child: LoginPageWidget())),
      GoRoute(
          name: 'Sign Up',
          path: '/sign-up',
          builder: (context, params) => SignUpPageWidget(),
          pageBuilder: (context, state) => topToBottomTransition<void>(
              context: context, state: state, child: SignUpPageWidget())),
      GoRoute(
          name: 'Verification',
          path: '/verification',
          builder: (context, params) => VerificationWidget(),
          pageBuilder: (context, state) => topToBottomTransition<void>(
              context: context, state: state, child: SignUpPageWidget())),
    ];
  }

  List<GoRoute> get routes => _routes;
  // TODO: implemented
  void setRoutes() {
    _routes = baseRoutes();
    if (_userTypeController?.profile?.verification?['createdAt'] == null)
      _routes.addAll(_userTypeController!.routes);
    notifyListeners();
  }

  // Register CRA // TODO: implemented
  Future<String?> registerCra(User nUser) async {
    final result = await _apiService.registerCra(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Register Joiner // TODO: implemented
  Future<String?> registerUser(User nUser) async {
    final result = await _apiService.registerUser(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Verify // TODO: implemented
  Future<bool> verify(String verificationCode) async {
    try {
      final result = await _apiService.verify(
        {
          'code': verificationCode,
          'email': _userTypeController!.profile!.email
        },
      );
      if (result.code != HttpStatus.ok) return false;
      if (result.message == 'CraUser Verified')
        _userTypeController?.profile = result.data as CraUserModel;
      else if (result.message == 'Verified')
        _userTypeController?.profile = result.data as UserModel;
      setRoutes();
      return true;
    } catch (e, stack) {
      print('Error in verifying email: $e');
      print(stack);
    }
    return false;
  }

  // Resend verification code // TODO: implemented
  void resendVerification() async {
    await _apiService
        .resendVerification({'email': _userTypeController!.profile!.email});
  }

  // Login CRA/Joiner // TODO: implemented
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
      setRoutes();
    }
    return result.data;
  }

  // TODO: implemented
  Future<bool> logout() async {
    try {
      await _userTypeController?.logout();
      _userTypeController = null;
      _routes = baseRoutes();
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in logging out: $e');
      print(stack);
    }
    return false;
  }

  // TODO: implemented
  Future initializePersistedState() async {
    final _pref = await SharedPreferences.getInstance();
    var cachedUser = _pref.getString('user');
    if (cachedUser != null) {
      Map<String, dynamic> user = jsonDecode(cachedUser);
      _userTypeController =
          UserController(UserModel.fromJson(user), _apiService);
      setRoutes();
      return;
    }
    cachedUser = _pref.getString('craUser');
    if (cachedUser != null) {
      Map<String, dynamic> craUser = jsonDecode(cachedUser);
      _userTypeController =
          CraController(CraUserModel.fromJson(craUser), _apiService);
      setRoutes();
      return;
    }
    print('Neither user or cra user is cached.');
  }
}

abstract class Auth extends ChangeNotifier {
  User? get profile;
  set profile(User? user);
  List<GoRoute> get routes;
  Future<bool> cacheUser();
  Future<bool> logout();
  Future<bool> changePassword(String currentPassword, String nPassword);
  Future<bool> editAccount(String firstName, String lastName);
  void refetchRentals();
  List<RentalModel> get rentals;
}
