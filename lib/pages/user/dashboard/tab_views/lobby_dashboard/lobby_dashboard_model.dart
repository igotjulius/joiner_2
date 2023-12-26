import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';

class LobbyDashboardModel {
  LobbyModel? currentLobby;
  LobbyDashboardModel(this.currentLobby);

  Future<void> fetchLobby(String lobbyId) async {
    // currentLobby = await UserController.getLobby(lobbyId);
  }

  double totalBudget() {
    double total = 0;
    currentLobby?.expense?.items?.forEach((key, value) {
      total += value;
    });

    return total;
  }

  String hostParticipant() {
    String host = '';
    currentLobby!.participants!.forEach((element) {
      if (element.type!.toString() == 'Host')
        host = '${element.firstName} ${element.lastName}';
    });

    return host;
  }

  List<ParticipantModel> getAllParticipants() {
    List<ParticipantModel> participantsList = [];

    currentLobby!.participants!.forEach((element) {
      if (element.type!.toString() != 'Host') {
        participantsList.add(element);
      }
    });

    return participantsList;
  }
}
