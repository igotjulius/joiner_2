import 'package:joiner_1/components/user/survey_poll_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PollModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  Color selected = const Color(0xFFF2F2F2);

  Color selectedText = Colors.black;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  void addPoll(BuildContext context, Function setState, String lobbyId) {
    showDialog(
      context: context,
      builder: (context) {
        return SurveyPollWidget(setState, lobbyId);
      },
    );
  }

  Widget getPoll(Function setState, String lobbyId) {
    return UserController.getPoll(setState, lobbyId);
  }

  /// Additional helper methods are added here.
}
