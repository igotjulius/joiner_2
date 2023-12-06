import 'package:flutter/material.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';

class LobbyProvider extends ChangeNotifier {
  LobbyModel _currentLobby;
  LobbyProvider(this._currentLobby);

  List<LobbyModel>? _activeLobbies;
  List<LobbyModel>? get activeLobbies => _activeLobbies;
  void setLinkableLobbies(List<LobbyModel> lobbies) {
    _activeLobbies = lobbies;
  }

  void updateCachedLobby(LobbyModel uLobby) {
    for (int i = 0; i < _activeLobbies!.length; i++) {
      if (_activeLobbies?[i].id == uLobby.id) {
        _activeLobbies?[i] = uLobby;
        break;
      }
    }
    notifyListeners();
  }

  // Get current lobby
  LobbyModel get currentLobby => _currentLobby;
  void setCurrentLobby(LobbyModel nLobby) {
    _currentLobby = nLobby;
    notifyListeners();
  }

  // Get lobby id
  String get lobbyId => _currentLobby.id!;

  // Get polls of current lobby
  List<PollModel> get polls => _currentLobby.poll!;

  // Add a poll
  void addPoll(PollModel nPoll) {
    _currentLobby.poll!.add(nPoll);
    notifyListeners();
  }

  // Remove a poll
  void removePoll(int index) {
    _currentLobby.poll!.removeAt(index);
    notifyListeners();
  }

  // Close a poll
  void closePoll(int index, PollModel uPoll) {
    _currentLobby.poll![index] = uPoll;
    notifyListeners();
  }

  // Get involved participants of a lobby
  List<ParticipantModel> get participants => _currentLobby.participants!;

  // Add a participant/s
  void addParticipants(List<ParticipantModel> participants) {
    _currentLobby.participants!.addAll(participants);
    notifyListeners();
  }

  // Remove a participant
  void removeParticipant(int index) {
    _currentLobby.participants!.removeAt(index);
    notifyListeners();
  }
}
