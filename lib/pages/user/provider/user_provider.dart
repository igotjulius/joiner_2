import 'package:flutter/material.dart';
import 'package:joiner_1/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._currentUser);
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;
}
