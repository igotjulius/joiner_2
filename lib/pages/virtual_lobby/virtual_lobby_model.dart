import '/components/empty_lobby_widget.dart';
import '/components/filled_lobby_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
