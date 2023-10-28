import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class UserSignUpMole extends StatefulWidget {
  const UserSignUpMole({super.key});

  @override
  State<UserSignUpMole> createState() => _UserSignUpMoleState();
}

class _UserSignUpMoleState extends State<UserSignUpMole> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextInput(label: 'First name'),
          CustomTextInput(label: 'Last name'),
          CustomTextInput(label: 'Email'),
          CustomTextInput(label: 'Password'),
          CustomTextInput(label: 'Confirm password'),
        ],
      ),
    );
  }
}

class UserSignUpMoleModel extends FlutterFlowModel {
  TextEditingController? fNameController;
  TextEditingController? lNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPassController;

  @override
  void initState(BuildContext context) {
    fNameController ??= TextEditingController();
    lNameController ??= TextEditingController();
    emailController ??= TextEditingController();
    passwordController ??= TextEditingController();
    confirmPassController ??= TextEditingController();
  }

  @override
  void dispose() {}
}
