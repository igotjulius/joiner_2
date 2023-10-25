import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:provider/provider.dart';

class CraAccountModel extends FlutterFlowModel {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void logout(BuildContext context) {
    final appState = context.read<FFAppState>();
    appState.setCurrentUser(null);
    appState.pref!.clear();
    context.goNamed('Login');
  }
}