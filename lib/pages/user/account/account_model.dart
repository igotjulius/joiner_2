import 'package:joiner_1/models/user_model.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AccountModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool editMode = false;
  UserModel? currentUser;

  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.
  void logout(BuildContext context) {
    final appState = context.read<FFAppState>();
    appState.setCurrentUser(null);
    appState.pref!.clear();
    context.goNamed('Login');
  }

  /// Additional helper methods are added here.
}
