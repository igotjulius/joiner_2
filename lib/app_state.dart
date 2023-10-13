import 'package:flutter/material.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();
  static SharedPreferences? pref;
  UserModel? _currentUser;

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    pref = await SharedPreferences.getInstance();
    String? userId = pref!.getString('userId');
    if (userId != null) {
      String? firstName = pref!.getString('firstName');
      String? lastName = pref!.getString('lastName');
      String? email = pref!.getString('email')!;
      _currentUser = UserModel(
          id: userId, firstName: firstName, lastName: lastName, email: email);
    }
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _isLobbyEmpty = true;
  bool get isLobbyEmpty => _isLobbyEmpty;
  set isLobbyEmpty(bool _value) {
    _isLobbyEmpty = _value;
  }

  UserModel? currentUser;

  UserModel getCurrentUser() {
    return _currentUser!;
  }

  void setCurrentUser(UserModel currentUser) async {
    await pref!.setString('userId', currentUser.id!);
    await pref!.setString('firstName', currentUser.firstName!);
    await pref!.setString('lastName', currentUser.lastName!);
    await pref!.setString('email', currentUser.email!);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
