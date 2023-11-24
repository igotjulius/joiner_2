import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

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
    _model = createModel(context, () => CraSignUpMoleModel());
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
            ],
          ),
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

  String? confirmPass(String? value) {
    return confirmPassword(value, passwordController!);
  }
}
