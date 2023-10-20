import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/car_item_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/atoms/participant.dart';
import 'package:joiner_1/widgets/molecules/poll_item.dart';
import 'package:joiner_1/widgets/molecules/widget_lobby.dart';
import '../models/user_model.dart';

class UserController {
  //TODO: change to dynamic
  static late String _userId = FFAppState().pref!.getString('userId')!;

  // Login user
  static void loginUser(UserModel user, FFAppState appState) async {
    await apiService.loginUser(user).then((response) {
      if (response.code == HttpStatus.ok) {
        final UserModel user = response.data!;
        appState.setCurrentUser(user);
        _userId = user.id!;
      }
    });
  }

  // Get user lobbies
  static FutureBuilder<ResponseModel<Map<String, List<LobbyModel>>>>
      userLobbies(FFAppState appState) {
    return FutureBuilder(
      future: apiService.getLobby(_userId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.code == HttpStatus.ok) {
            final Map<String, List<LobbyModel>> result = snapshot.data!.data!;
            // final activeLobbies = result['active']!;
            final {'active': activeLobbies, 'pending': pendingLobbies} = result;
            return activeLobbies.length == 0
                ? Text('No active lobbies')
                : WidgetLobby(activeLobbies);
          } else {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(snapshot.data!.message!),
                ),
              ],
            );
          }
        } else
          return Dialog(child: SizedBox.shrink());
      }),
    );
  }

  // Create lobby
  static Future<void> createLobby(
      LobbyModel lobby, BuildContext context) async {
    await apiService.createLobby(lobby, _userId).then(
      (response) {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(response.message!),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Create message
  static Future<void> createMessage(MessageModel message, BuildContext context,
      String lobbyId, String conversationId) async {
    await apiService
        .createMessage(message, _userId, lobbyId, conversationId)
        .catchError((error) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text('Message not sent.'),
        ),
      );
    });
  }

  // Get conversation
  static FutureBuilder<ResponseModel<List<MessageModel>?>> getConversation(
      String lobbyId, String conversationId) {
    return FutureBuilder(
      future: apiService.getConversation(_userId, lobbyId, conversationId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel>? result = snapshot.data!.data;
          if (result == null)
            return Center(
              child: Text('Say hi!'),
            );
          return ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10, bottom: 7, top: 5),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      result[index].message!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Get all poll of a lobby
  static FutureBuilder<List<PollModel>> getPoll(
      Function callback, String lobbyId) {
    return FutureBuilder(
        future: apiService.getPoll(_userId, lobbyId),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<PollModel> polls = snapshot.data!;
            return ListView.builder(
              itemCount: polls.length,
              itemBuilder: (context, index) {
                return PollItem(callback, poll: polls[index], lobby: lobbyId);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }

  // Add/create a poll of a lobby
  static void postPoll(PollModel poll, String lobbyId) {
    apiService.postPoll(poll, _userId, lobbyId);
  }

  // Delete corresponding poll
  static void deletePoll(String lobbyId, String pollId) {
    apiService.deletePoll(_userId, lobbyId, pollId);
  }

  // Add/create a budget to a lobby
  static Future<void> addBudget(
      String label, double amount, String lobbyId) async {
    await apiService
        .addBudget({'label': label, 'amount': amount}, _userId, lobbyId);
  }

  // Get participants of a lobby
  static FutureBuilder<ResponseModel<List<ParticipantModel>>> getParticipants(
      String lobbyId) {
    return FutureBuilder(
      future: apiService.getParticipants(_userId, lobbyId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data!.data;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: result!.length,
              itemBuilder: (context, index) {
                return ParticipantsAtom(result[index].name);
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  // Invite participant/s to a lobby
  static Future<void> inviteParticipants(List<ParticipantModel> participants,
      String userId, String lobbyId) async {
    await apiService.inviteParticipants(participants, userId, lobbyId);
  }

  // Invite user a friend
  static Future<void> inviteFriend(String friendEmail) async {
    await apiService.inviteFriend({'email': friendEmail}, _userId);
  }

  static Future<ResponseModel<List<Map<String, String>>>?> getFriends() {
    return apiService.getFriends(_userId);
  }

  // Accept friend request
  static Future<void> acceptFriendRequest(String friendId) async {
    await apiService.acceptFriendRequest(_userId, friendId);
  }

  // Get available cars
  static FutureBuilder<ResponseModel<List<CarModel>>> getAvailableCars(
      Function callback) {
    return FutureBuilder(
      future: apiService.getAvailableCars(_userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.data!.isEmpty)
            return Center(
              child: Text('No available cars for today :('),
            );
          final cars = snapshot.data!.data!;
          double width = MediaQuery.of(context).size.width / 2;
          return GridView.extent(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            maxCrossAxisExtent: width,
            children: List.generate(
              cars.length,
              (i) => CarItemWidget(callback, car: cars[i]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Book corresponding car
  static Future<void> bookCar(String licensePlate) async {
    await apiService
        .bookCar({'licensePlate': licensePlate}, _userId).catchError((error) {
      print(error);
    });
  }
}
