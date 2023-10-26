import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();
  SharedPreferences? pref;
  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    pref = await SharedPreferences.getInstance();
    if (pref!.getBool('isCra') != null) {
      pref!.getBool('isCra')!
          ? _currentUser = new CraUserModel(
              id: pref!.getString('userId'),
              firstName: pref!.getString('firstName'),
              lastName: pref!.getString('lastName'),
              email: pref!.getString('email'),
            )
          : _currentUser = new UserModel(
              id: pref!.getString('userId'),
              firstName: pref!.getString('firstName'),
              lastName: pref!.getString('lastName'),
              email: pref!.getString('email'),
            );
    }
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  User? _currentUser;
  User? get currentUser => _currentUser;
  void setCurrentUser(User? currentUser) {
    _currentUser = currentUser;

    if (_currentUser != null) {
      pref!.setString('userId', currentUser!.id!);
      pref!.setString('firstName', currentUser.firstName!);
      pref!.setString('lastName', currentUser.lastName!);
      pref!.setString('email', currentUser.email!);
      pref!.setBool('isCra', _isCra);
    }

    notifyListeners();
  }

  bool _isCra = false;
  bool get isCra => _isCra;
  void setIsCra(bool val) {
    _isCra = val;
    notifyListeners();
  }
}
