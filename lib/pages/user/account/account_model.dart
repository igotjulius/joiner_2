import 'package:joiner_1/models/user_model.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AccountModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool editMode = false;
  UserModel? currentUser;

  ///  State fields for stateful widgets in this page.

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  void logout(BuildContext context) {
    context.read<FFAppState>().setCurrentUser(null);
    context.goNamed('Login');
  }

  /// Additional helper methods are added here.
}
