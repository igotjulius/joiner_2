import 'package:flutter/material.dart';
import 'package:joiner_1/service/api_service.dart';

export 'utils.dart';

const environment = 'OFFLINE';

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t) => this.isEmpty
      ? []
      : (enumerate.map((e) => [e.value, t]).expand((i) => i).toList()
        ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);
}

DateTime get getCurrentTimestamp => DateTime.now();

String getImageUrl(String imageUrl) {
  if (imageUrl.startsWith('http'))
    return imageUrl;
  else
    return '$serverUrl$imageUrl';
}

extension StringExtension on String {
  String toTitleCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

String? isEmpty(String? value) {
  if (value == null || value.trim().isEmpty) return 'Field is empty';
  return null;
}

String? validateMobile(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  final trimmed = isEmpty(value);
  if (trimmed != null)
    return 'Please enter mobile number';
  else if (!regExp.hasMatch(value!)) return 'Please enter valid mobile number';
  return null;
}

String? validatePassword(String? value) {
  final trimmed = isEmpty(value);
  if (trimmed != null) return trimmed;
  if (value!.length < 5)
    return 'Password length must be greater than 6 characters';
  return null;
}

String? confirmPassword(
    String? value, TextEditingController passwordController) {
  final trimmed = isEmpty(value);
  if (trimmed != null) return trimmed;
  if (value != passwordController.text) return 'Passwords don\'t match';
  return null;
}

String? validateEmail(String? value) {
  final trimmed = isEmpty(value);
  if (trimmed != null) return trimmed;
  if (RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value!))
    return null;
  else
    return 'Email is not valid';
}

SnackBar showSuccess(String message) {
  return SnackBar(
    content: Text(message),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  );
}

SnackBar showError(String message, Color errorColor) {
  return SnackBar(
    content: Text(message),
    backgroundColor: errorColor,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  );
}

Future showDialogLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
