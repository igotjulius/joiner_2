import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PollItemModel extends FlutterFlowModel {
  ///  Local state fields for this component.
  PollStateNotifier? pollStateNotifier;

  Color selected = const Color(0xFFF2F2F2);

  Color selectedText = Colors.black;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class PollStateNotifier extends ChangeNotifier {
  String? lobbyId;
  List<PollModel>? polls;
  PollStateNotifier({this.lobbyId, this.polls});

  // Fetch all polls of a lobby
  void getPoll() async {
    polls = await UserController.getPoll(lobbyId!);
    notifyListeners();
  }

  void setPoll(List<PollModel> polls) {
    this.polls = polls;
    notifyListeners();
  }

  // Add poll
}
