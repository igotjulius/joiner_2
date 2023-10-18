import 'package:joiner_1/components/user/budget_graph_model.dart';
import 'package:joiner_1/components/user/chat_model.dart';
import 'package:joiner_1/components/user/joiners_model.dart';
import 'package:joiner_1/components/user/poll_model.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class ParticipantsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for Chat component.
  late ChatModel chatModel;
  // Model for BudgetGraph component.
  late BudgetGraphModel budgetGraphModel;
  // Model for Poll component.
  late PollModel pollModel;
  // Model for Joiners component.
  late JoinersModel joinersModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    chatModel = createModel(context, () => ChatModel());
    budgetGraphModel = createModel(context, () => BudgetGraphModel());
    pollModel = createModel(context, () => PollModel());
    joinersModel = createModel(context, () => JoinersModel());
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    chatModel.dispose();
    budgetGraphModel.dispose();
    pollModel.dispose();
    joinersModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}