import 'dart:async';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPageModel {
  TextEditingController emailController =
      TextEditingController(text: '1@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Future<User?> loginUser() async {
  //   final result = await AuthController.loginUser(
  //       emailController.text, passwordController.text);
  //   return result;
  // }
}
