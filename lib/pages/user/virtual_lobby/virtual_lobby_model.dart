import 'package:joiner_1/components/user/empty_lobby_model.dart';
import 'package:joiner_1/components/user/filled_lobby_model.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class VirtualLobbyModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for EmptyLobby component.
  late EmptyLobbyModel emptyLobbyModel;
  // Model for FilledLobby component.
  late FilledLobbyModel filledLobbyModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emptyLobbyModel = createModel(context, () => EmptyLobbyModel());
    filledLobbyModel = createModel(context, () => FilledLobbyModel());
  }

  void dispose() {
    unfocusNode.dispose();
    emptyLobbyModel.dispose();
    filledLobbyModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
