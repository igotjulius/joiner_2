import 'dart:async';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/utils/utils.dart' as utils;
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LoginPageModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  bool _isCra = false;
  bool get isCra => _isCra;
  void setIsCra(bool value) {
    _isCra = value;
  }

  // State field(s) for TextField widget.
  TextEditingController? emailController;
  // State field(s) for TextField widget.
  TextEditingController? passwordController;

  void dispose() {
    unfocusNode.dispose();
    emailController?.dispose();
    passwordController?.dispose();
  }

  /// Action blocks are added here.
  Future<bool> loginUser(BuildContext context) async {
    FFAppState appState = context.read<FFAppState>();
    late User user;

    if (!appState.isCra) {
      user = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );
    } else {
      user = CraUserModel(
        email: emailController.text,
        password: passwordController.text,
      );
    }
    final currentUser = await User.loginUser(user);

    if (currentUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        showSuccess('Login successful'),
      );

      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      showError(
        'Invalid username/password',
        Theme.of(context).colorScheme.error,
      ),
    );
    return false;
  }

  /// Additional helper methods are added here.
  String? validateEmail(String? email) {
    return utils.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return utils.isEmpty(password);
  }
}
