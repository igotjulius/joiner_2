import 'package:flutter/material.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/poll_model.dart';

class LobbyProvider extends ChangeNotifier {
  final LobbyModel _currentLobby;
  LobbyProvider(this._currentLobby);

  // Get polls of current lobby
  List<PollModel> get getPolls => _currentLobby.poll!;
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
}
