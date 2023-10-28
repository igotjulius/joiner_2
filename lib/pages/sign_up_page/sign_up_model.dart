import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

class SignUpPageModel extends FlutterFlowModel {
  TabController? tabController;

  late CRASignUpMoleModel craModel;
  late UserSignUpMoleModel userModel;

  @override
  void initState(BuildContext context) {
    craModel = createModel(context, () => CRASignUpMoleModel());
    userModel = createModel(context, () => UserSignUpMoleModel());
  }

  @override
  void dispose() {
    tabController?.dispose();
  }

  Future signUp() async {
    if (tabController?.index == 0) {
      final nUser = {
        'firstName': userModel.fNameController.text,
        'lastName': userModel.lNameController.text,
        'email': userModel.emailController.text,
        'password': userModel.passwordController.text,
      };
      await UserController.registerUser(nUser);
    } else {
      final nUser = {
        'firstName': craModel.fNameController.text,
        'lastName': craModel.lNameController.text,
        'email': craModel.emailController.text,
        'address': craModel.addressController.text,
        'contactNo': craModel.contactController.text,
        'password': craModel.passwordController.text,
      };
      await CraController.registerCra(nUser);
    }
  }
}
