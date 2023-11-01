import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class SurveyPollModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  List<TextEditingController>? choices;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    choices = [];
  }

  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.
  Future<List<PollModel>?> createPoll(String lobbyId) async {
    List<String> choices = [];
    this.choices!.forEach((element) => choices.add(element.text));
    return UserController.postPoll(
      PollModel(
        question: textController1.text,
        choices: choices,
      ),
      lobbyId,
    );
  }

  /// Additional helper methods are added here.
}
