import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

class SignUpPageModel {
  TabController? tabController;
  late UserSignUpMoleModel userModel;
  late CraSignUpMoleModel craModel;

  void dispose() {
    tabController?.dispose();
  }

  Future<String?> signUp() async {
    late User nUser;
    // if (tabController?.index == 0) {
    //   nUser = UserModel(
    //     firstName: userModel.fNameController.text,
    //     lastName: userModel.lNameController.text,
    //     email: userModel.emailController.text,
    //     password: userModel.passwordController.text,
    //   );
    // } else {
    //   nUser = CraUserModel(
    //     firstName: craModel.fNameController.text,
    //     lastName: craModel.lNameController.text,
    //     email: craModel.emailController.text,
    //     address: craModel.addressController.text,
    //     contactNo: craModel.contactController.text,
    //     password: craModel.passwordController.text,
    //   );
    // }
    // return await User.registerUser(nUser);
  }
}
