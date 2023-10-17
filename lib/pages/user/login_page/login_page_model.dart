import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
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

  late FFAppState appState;
  late AppStateNotifier navState;

  void initState(BuildContext context) {
    appState = context.read<FFAppState>();
    navState = context.read<AppStateNotifier>();
  }

  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.
  void loginUser() async {
    if (appState.isCra) {
      CraController.loginCra(
          textController1.text, textController2.text, appState);
    } else {
      UserController.loginUser(
          UserModel(
              email: textController1.text, password: textController2.text),
          appState);
    }
  }

  void setRoutes() {
    navState.setRoutes(appState.isCra);
  }

  /// Additional helper methods are added here.
}
