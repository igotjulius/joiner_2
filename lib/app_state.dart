import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();
  static SharedPreferences? pref;
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  void setCurrentUser(UserModel? currentUser) {
    _currentUser = currentUser!;

    // await pref!.setString('userId', currentUser.id!);
    // await pref!.setString('firstName', currentUser.firstName!);
    // await pref!.setString('lastName', currentUser.lastName!);
    // await pref!.setString('email', currentUser.email!);

    notifyListeners();
  }

  bool _isCra = false;
  bool get isCra => _isCra;
  void setIsCra(bool val) {
    _isCra = val;
    notifyListeners();
  }

  List<FFRoute> _routes = [
    FFRoute(
      name: '_initialize',
      path: '/login',
      builder: (context, params) => LoginPageWidget(),
    )
  ];
  List<FFRoute> get routes => _routes;

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    pref = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
