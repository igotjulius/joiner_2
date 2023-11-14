import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class UserSignUpMole extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  UserSignUpMole({super.key, required this.formKey});

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
    return Container(
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextInput(
                label: 'First name',
                controller: _model.fNameController,
                validator: _model.checkEmpty,
              ),
              CustomTextInput(
                label: 'Last name',
                controller: _model.lNameController,
                validator: _model.checkEmpty,
              ),
              CustomTextInput(
                label: 'Email',
                controller: _model.emailController,
                validator: _model.validateEmail,
              ),
              CustomTextInput(
                label: 'Password',
                controller: _model.passwordController,
                obscureText: true,
                validator: _model.checkEmpty,
              ),
              CustomTextInput(
                label: 'Confirm password',
                controller: _model.confirmPassController,
                obscureText: true,
                validator: _model.confirmPassword,
              ),
            ],
          ),
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

  String? checkEmpty(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Field should not be empty';
    else
      return null;
  }

  String? confirmPassword(String? value) {
    final trimmed = checkEmpty(value);
    if (trimmed != null) return trimmed;
    if (value != passwordController?.text) return 'Passwords don\'t match';
    return null;
  }

  String? validateEmail(String? value) {
    final trimmed = checkEmpty(value);
    if (trimmed != null) return trimmed;
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!))
      return null;
    else
      return 'Email address is not supported.';
  }
}
