import 'package:flutter/material.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class CraSignUpMole extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CraSignUpMole({super.key, required this.formKey});

  @override
  State<CraSignUpMole> createState() => _CraSignUpMoleState();
}

class _CraSignUpMoleState extends State<CraSignUpMole> {
  late CraSignUpMoleModel _model;

  @override
  void initState() {
    super.initState();
    _model = context.read<CraSignUpMoleModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
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

class CraSignUpMoleModel {
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
    addressController.dispose();
    contactController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
  }

  String? confirmPass(String? value) {
    return confirmPassword(value, passwordController.text);
  }

  CraUserModel getUserInput() {
    return CraUserModel(
      id: '',
      firstName: fNameController.text,
      lastName: lNameController.text,
      email: emailController.text,
      password: passwordController.text,
      vehicles: [],
      rentals: [],
    );
  }
}
