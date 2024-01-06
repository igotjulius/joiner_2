import 'package:flutter/material.dart';
import 'package:joiner_1/models/user_model.dart';
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
                onChanged: (value) => setState(() {
                  _model.emailError = null;
                }),
              ),
              CustomTextInput(
                label: 'Address',
                controller: _model.addressController,
                validator: isEmpty,
              ),
              CustomTextInput(
                label: 'Contact no.',
                controller: _model.contactController,
                keyboardType: TextInputType.phone,
                validator: validateMobile,
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
                height: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserSignUpMoleModel {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String? emailError;

  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
  }

  String? confirmPass(String? value) {
    return confirmPassword(value, passwordController.text);
  }

  UserModel getUserInput() {
    return UserModel(
      id: '',
      firstName: fNameController.text.trim(),
      lastName: lNameController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      contactNo: contactController.text.trim(),
      password: passwordController.text.trim(),
      friends: [],
      pendingLobby: [],
      activeLobby: [],
      rentals: [],
    );
  }
}
