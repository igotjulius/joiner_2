import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';

class ParticipantModel extends FlutterFlowModel {
  bool isChecked = false;
  String? friendId;
  String? lobbyId;

  ParticipantModel({this.friendId});

  @override
  void dispose() {}

  @override
  void initState(BuildContext context) {}

  void removeParticipant() {
    UserController.removeParticipant(lobbyId!, friendId!);
  }
}
