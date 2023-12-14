import 'package:flutter/material.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

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
    _model = context.read<UserSignUpMoleModel>();
    _model.initState();
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
                validator: isEmpty,
              ),
              CustomTextInput(
                label: 'Last name',
                controller: _model.lNameController,
                validator: isEmpty,
              ),
              CustomTextInput(
                label: 'Email',
                controller: _model.emailController,
                validator: validateEmail,
                errorText: _model.emailError,
                onChanged: (value) {
                  _model.emailError = null;
                  setState(() {});
                },
              ),
              CustomTextInput(
                label: 'Password',
                controller: _model.passwordController,
                obscureText: true,
                validator: validatePassword,
              ),
              CustomTextInput(
                label: 'Confirm password',
                controller: _model.confirmPassController,
                obscureText: true,
                validator: _model.confirmPass,
              ),
            ].divide(
              SizedBox(
                height: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserSignUpMoleModel {
  TextEditingController? fNameController;
  TextEditingController? lNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPassController;
  String? emailError;

  void initState() {
    fNameController ??= TextEditingController();
    lNameController ??= TextEditingController();
    emailController ??= TextEditingController();
    passwordController ??= TextEditingController();
    confirmPassController ??= TextEditingController();
  }

  void dispose() {
    fNameController?.dispose();
    lNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    confirmPassController?.dispose();
  }

  String? confirmPass(String? value) {
    return confirmPassword(value, passwordController!.text);
  }
}
