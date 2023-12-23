import 'package:flutter/material.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';

class LobbyProvider extends ChangeNotifier {
  late LobbyModel _currentLobby;
  LobbyProvider.current(this._currentLobby);
  LobbyProvider.test(this._allLobbies);

  Map<String, List<LobbyModel>>? _allLobbies;
  Map<String, List<LobbyModel>>? get allLobbies => _allLobbies;

  List<LobbyModel>? _activeLobbies;
  List<LobbyModel>? get activeLobbies => _activeLobbies;
  void setLinkableLobbies(List<LobbyModel> lobbies) {
    _activeLobbies = lobbies;
  }

  void addActiveLobby(LobbyModel lobby) {
    _allLobbies?['activeLobby']?.add(lobby);
    notifyListeners();
  }

  void removeLobby(LobbyModel lobby) {
    _allLobbies?['activeLobby']
        ?.removeWhere((element) => element.id == lobby.id);
    notifyListeners();
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

  ExpenseModel get expenses => _currentLobby.expense!;
  void addExpense(String label, double amount) {
    _currentLobby.expense?.items?.addAll({label: amount});
    notifyListeners();
  }

  void removeExpense(String label) {
    _currentLobby.expense?.items?.removeWhere((key, value) => key == label);
    notifyListeners();
  }

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
  void removeParticipant(String userId) {
    _currentLobby.participants!
        .removeWhere((element) => element.userId == userId);
    notifyListeners();
  }
}
