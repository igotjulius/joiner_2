import 'dart:async';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  bool _isCra = false;
  bool get isCra => _isCra;
  void setIsCra(bool value) {
    _isCra = value;
  }

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  /// Initialization and disposal methods.co

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.
  Future<void> loginUser(BuildContext context) async {
    FFAppState appState = context.read<FFAppState>();
    User? currentUser;
    appState.setIsCra(isCra);
    AppStateNotifier.instance.setRoutes();

    if (appState.isCra) {
      currentUser = await CraController.loginCra(
          textController1.text, textController2.text, appState);
    } else {
      currentUser = await UserController.loginUser(
          textController1.text, textController2.text);
    }
    if (currentUser != null) appState.setCurrentUser(currentUser);
  }

  /// Additional helper methods are added here.
}
