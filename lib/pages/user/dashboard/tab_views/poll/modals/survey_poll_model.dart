import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class SurveyPollModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  TextEditingController? questionController;
  List<TextEditingController>? choicesController = [];

  void dispose() {
    questionController?.dispose();
    choicesController?.forEach((controller) {
      controller.dispose();
    });
  }

  /// Action blocks are added here.
  Future<PollModel?> createPoll(String lobbyId) async {
    List<String> choices = [];
    choicesController!.forEach((element) {
      if (element.text.trim().isNotEmpty) return choices.add(element.text);
    });
    final nPoll = PollModel(
      question: questionController.text,
      choices: choices,
    );
    final result = await UserController.postPoll(
      nPoll,
      lobbyId,
    );
    return result;
  }

  /// Additional helper methods are added here.
}
