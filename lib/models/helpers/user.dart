import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/user_model.dart';

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
    var result;
    if (nUser is UserModel) result = await UserController.registerUser(nUser);
    if (nUser is CraUserModel) result = await CraController.registerCra(nUser);
    return result;
  }

  static Future<User?> loginUser(User user) async {
    var result;
    result = await UserController.loginUser(user);
    // if (user is UserModel)
    if (user is CraUserModel) result = await CraController.loginCra(user);
    return result;
  }

  Map<String, dynamic> toJson();
}
