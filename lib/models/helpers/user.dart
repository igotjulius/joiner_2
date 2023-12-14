import 'dart:io';

import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/service/api_service.dart';

abstract class User {
  final String? id, firstName, lastName, email, password, contactNo, address;
  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.contactNo,
    this.address,
  });

  static Future<String?> registerUser(User nUser) async {
    if (nUser is UserModel) return await UserController.registerUser(nUser);
    if (nUser is CraUserModel) return await CraController.registerCra(nUser);
    return null;
  }

  static Future<User?> loginUser(User user) async {
    final result = await apiService
        .loginUser({'email': user.email!, 'password': user.password!});
    if (result.code == HttpStatus.ok) {
      if (result.message == 'CraUser')
        FFAppState().setIsCra(true);
      else
        FFAppState().setIsCra(false);
      AppStateNotifier.instance.setRoutes();
      FFAppState().setCurrentUser(result.data);
    }
    return result.data;
  }

  Map<String, dynamic> toJson();
}
