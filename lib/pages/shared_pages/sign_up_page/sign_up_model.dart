import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

class SignUpPageModel extends FlutterFlowModel {
  late UserSignUpMoleModel userModel;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<String?> signUp() async {
    late User nUser;
    nUser = UserModel(
      firstName: userModel.fNameController.text,
      lastName: userModel.lNameController.text,
      email: userModel.emailController.text,
      password: userModel.passwordController.text,
    );
    return await User.registerUser(nUser);
  }
}
