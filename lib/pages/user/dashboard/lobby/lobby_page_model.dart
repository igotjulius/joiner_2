import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/joiners_model.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/lobby_dashboard/lobby_dashboard_model.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/poll_comp_model.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/chat/chat_widget.dart';
import 'package:flutter/material.dart';

class LobbyPageModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;

  // Model for Lobby Dashboard component
  LobbyDashboardModel? lobbyDashboardModel;
  // Model for Chat component.
  ChatModel? chatModel;
  // Model for Poll component.
  PollCompModel? pollModel;
  // Model for Joiners component.
  JoinersModel? joinersModel;

  LobbyModel? currentLobby;

  /// Initialization and disposal methods.
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    chatModel?.dispose();
    pollModel?.dispose();
    joinersModel?.dispose();
  }

  /// Action blocks are added here.
  void initModel(LobbyModel currentLobby) {
    this.currentLobby = currentLobby;
    lobbyDashboardModel = LobbyDashboardModel(currentLobby);
    chatModel = ChatModel();
    pollModel = PollCompModel();
    joinersModel = JoinersModel();
  }

  Future<LobbyModel?> fetchLobby(String lobbyId) async {
    return await UserController.getLobby(lobbyId);
  }

  void leaveLobby(String lobbyId) async {
    await UserController.leaveLobby(lobbyId);
  }

  /// Additional helper methods are added here.
}
