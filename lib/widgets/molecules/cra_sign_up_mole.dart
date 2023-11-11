import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class CraSignUpMole extends StatefulWidget {
  const CraSignUpMole({super.key});

  @override
  State<CraSignUpMole> createState() => _CraSignUpMoleState();
}

class _CraSignUpMoleState extends State<CraSignUpMole> {
  late CraSignUpMoleModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CraSignUpMoleModel());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
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
              label: 'Address',
              controller: _model.addressController,
            ),
            CustomTextInput(
              label: 'Contact no.',
              controller: _model.contactController,
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

class CraSignUpMoleModel extends FlutterFlowModel {
  TextEditingController? fNameController;
  TextEditingController? lNameController;
  TextEditingController? emailController;
  TextEditingController? addressController;
  TextEditingController? contactController;
  TextEditingController? passwordController;
  TextEditingController? confirmPassController;

  @override
  void initState(BuildContext context) {
    fNameController ??= TextEditingController();
    lNameController ??= TextEditingController();
    emailController ??= TextEditingController();
    addressController ??= TextEditingController();
    contactController ??= TextEditingController();
    passwordController ??= TextEditingController();
    confirmPassController ??= TextEditingController();
  }

  @override
  void dispose() {
    fNameController?.dispose();
    lNameController?.dispose();
    emailController?.dispose();
    addressController?.dispose();
    contactController?.dispose();
    passwordController?.dispose();
    confirmPassController?.dispose();
  }
}
