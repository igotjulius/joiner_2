import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/participant_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class JoinersModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  bool checkboxVal = false;
  List<ParticipantModel>? participants;

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  Widget getParticipants(String lobbyId) {
    return UserController.getParticipants(lobbyId);
  }

  /// Additional helper methods are added here.
}
