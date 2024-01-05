import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  if (imageUrl.startsWith('https'))
    return imageUrl;
  else
    return '$serverUrl$imageUrl';
}

extension StringExtension on String {
  String toTitleCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

Widget withCurrency(Text text) {
  return Row(
    children: [
      Icon(
        MdiIcons.currencyPhp,
        color: Colors.black87,
        size: 14,
      ),
      text,
    ],
  );
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

String? datesValidator(String? value, int duration) {
  var validate = isEmpty(value);
  if (validate != null) return validate;
  if (duration < 1) return 'Minimum rent duration is one day';
  return null;
}

String? validatePassword(String? value) {
  final trimmed = isEmpty(value);
  if (trimmed != null) return trimmed;
  if (value!.length < 6) return 'Minimum 6 characters';
  return null;
}

String? confirmPassword(String? value, String? value2) {
  final trimmed = isEmpty(value);
  if (trimmed != null) return trimmed;
  if (value != value2) return 'Passwords don\'t match';
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

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

CustomTransitionPage topToBottomTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

CustomTransitionPage bottomToTopTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset.zero;
      const end = Offset(0.0, -1.0);
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}


