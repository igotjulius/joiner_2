import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class UserSignUpMole extends StatefulWidget {
  const UserSignUpMole({super.key});

  @override
  State<UserSignUpMole> createState() => _UserSignUpMoleState();
}

class _UserSignUpMoleState extends State<UserSignUpMole> {
  late UserSignUpMoleModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserSignUpMoleModel());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            CustomTextInput(
              label: 'First name',
              controller: _model.fNameController,
            ),
            CustomTextInput(
              label: 'Last name',
              controller: _model.lNameController,
            ),
            CustomTextInput(
              label: 'Email',
              controller: _model.emailController,
            ),
            CustomTextInput(
              label: 'Password',
              controller: _model.passwordController,
              obscureText: true,
            ),
            CustomTextInput(
              label: 'Confirm password',
              controller: _model.confirmPassController,
              obscureText: true,
            ),
          ],
        ),
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
