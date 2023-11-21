import 'package:joiner_1/components/user/budget_model.dart';
import 'package:joiner_1/components/user/chat_model.dart';
import 'package:joiner_1/components/user/joiners_model.dart';
import 'package:joiner_1/components/user/lobby_dashboard_model.dart';
import 'package:joiner_1/components/user/poll_item_model.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart' as ModelLobby;
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LobbyModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for Lobby Dashboard component
  late LobbyDashboardModel lobbyDashboardModel;
  // Model for Chat component.
  late ChatModel chatModel;
  // Model for BudgetGraph component.
  late BudgetModel budgetGraphModel;
  // Model for Poll component.
  late PollItemModel pollModel;
  // Model for Joiners component.
  late JoinersModel joinersModel;

  ModelLobby.LobbyModel? currentLobby;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    lobbyDashboardModel = createModel(context, () => LobbyDashboardModel());
    chatModel = createModel(context, () => ChatModel());
    budgetGraphModel = createModel(context, () => BudgetModel());
    pollModel = createModel(context, () => PollItemModel());
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
  Future<ModelLobby.LobbyModel?> fetchLobby(String lobbyId) async {
    return await UserController.getLobby(lobbyId);
  }

  void leaveLobby(String lobbyId) async {
    await UserController.leaveLobby(lobbyId);
  }

  /// Additional helper methods are added here.
}