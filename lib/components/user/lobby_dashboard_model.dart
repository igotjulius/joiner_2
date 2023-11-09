import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/lobby_model.dart';

class LobbyDashboardModel extends FlutterFlowModel {
  LobbyModel? currentLobby;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchLobby(String lobbyId) async {
    currentLobby = await UserController.getLobby(lobbyId);
    updatePage(() {});
  }

  double totalBudget (){
    double total = 0;
    currentLobby!.budget!.forEach((key, value) {
      total += value;
     });

     return total;
  }
}
