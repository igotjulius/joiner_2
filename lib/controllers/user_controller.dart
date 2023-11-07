import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/car_item_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/atoms/participant_atom.dart';
import 'package:joiner_1/widgets/molecules/lobby_invitation_mole.dart';
import 'package:joiner_1/widgets/molecules/active_lobby_mole.dart';

class UserController {
  static late String _userId = FFAppState().pref!.getString('userId')!;

  // Register user
  static Future<void> registerUser(Map<String, String> nUser) async {
    await apiService.registerUser(nUser);
  }

  // Login user
  static Future<User?> loginUser(String email, String password) async {
    User? user;
    await apiService.loginUser({'email': email, 'password': password}).then(
      (response) {
        if (response.code == HttpStatus.ok) {
          user = response.data!;
          _userId = user!.id!;
        }
      },
    );
    return user;
  }

  // Fetch user lobbies
  static FutureBuilder<ResponseModel<Map<String, List<LobbyModel>>>>
      userLobbies(FFAppState appState) {
    return FutureBuilder(
      future: apiService.getLobbies(_userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.code == HttpStatus.ok) {
            final Map<String, List<LobbyModel>> result = snapshot.data!.data!;
            // final activeLobbies = result['active']!;
            final {'active': activeLobbies, 'pending': pendingLobbies} = result;

            return Column(
              children: [
                if (pendingLobbies.length != 0)
                  Column(
                    children: [
                      Text('Invitations'),
                      LobbyInvitationMolecule(lobbies: pendingLobbies),
                    ],
                  ),
                Column(
                  children: [
                    activeLobbies.length == 0
                        ? Text('No active lobbies')
                        : ActiveLobbyMolecule(activeLobbies),
                  ],
                ),
              ],
            );
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
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Fetch specific lobby
  static Future<LobbyModel?> getLobby(String lobbyId) async {
    final res = await apiService.getLobby(_userId, lobbyId);
    if (res.code == HttpStatus.ok)
      return res.data;
    else
      return null;
  }

  // Create lobby
  static Future<void> createLobby(
      LobbyModel lobby, BuildContext context) async {
    await apiService.createLobby(lobby, _userId).then(
      (response) {
        showSnackbar(context, response.message!);
        context.goNamed('VirtualLobby');
        /* showDialog(
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
      */
      },
    );
  }

  // Delete specific lobby
  static Future<void> deleteLobby(String lobbyId) async {
    await apiService.deleteLobby(_userId, lobbyId);
  }

  // Create message
  static Future<void> createMessage(MessageModel message, BuildContext context,
      String userId, String lobbyId, String conversationId) async {
    await apiService
        .createMessage(message, userId, lobbyId, conversationId)
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
      String userId, String lobbyId, String conversationId) {
    return FutureBuilder(
      future: apiService.getConversation(userId, lobbyId, conversationId),
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
              MessageModel message = result[index];
              bool isUserMessage = _userId == message.creatorId;
              return Align(
                alignment: isUserMessage
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    right: isUserMessage ? 10 : 0,
                    left: isUserMessage ? 0 : 10,
                    bottom: 7,
                    top: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3, bottom: 3),
                        child: Text(
                          isUserMessage ? '' : result[index].creator!,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isUserMessage ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          result[index].message!,
                          style: TextStyle(
                              color:
                                  isUserMessage ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
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
  static Future<List<PollModel>?> getPoll(String lobbyId) async {
    final response = await apiService.getPoll(_userId, lobbyId);
    return response.data;
  }

  // Add/create a poll of a lobby
  static Future<List<PollModel>?> postPoll(
      PollModel poll, String lobbyId) async {
    final response = await apiService.postPoll(poll, _userId, lobbyId);
    return response.data;
  }

  // Vote to a poll
  static Future<PollModel> votePoll(String choice, String lobbyId) async {
    final response =
        await apiService.votePoll({'title': choice}, _userId, lobbyId);
    return response.data!;
  }

  // Close corresponding poll
  static Future<PollModel> closePoll(String lobbyId, String pollId) async {
    final response = await apiService.closePoll(_userId, lobbyId, pollId);
    return response.data!;
  }

  // Delete corresponding poll
  static Future<List<PollModel>?> deletePoll(
      String lobbyId, String pollId) async {
    final response = await apiService.deletePoll(_userId, lobbyId, pollId);
    return response.data;
  }

  // Add/create a budget to a lobby
  static Future<void> addBudget(
      String label, double amount, String lobbyId) async {
    await apiService
        .addBudget({'label': label, 'amount': amount}, _userId, lobbyId);
  }

  // Fetch participants of a lobby
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
                return ParticipantAtom(
                  name: result[index].name,
                  suffixLabel: result[index].joinStatus,
                );
              });
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  // Invite participant/s to a lobby
  static Future<void> inviteParticipants(
      List<ParticipantModel> participants, String lobbyId) async {
    await apiService.inviteParticipants(participants, _userId, lobbyId);
  }

  // Accept invitation to join a lobby
  static Future<void> acceptLobbyInvitation(String lobbyId) async {
    await apiService.acceptLobbyInvitation({'lobbyId': lobbyId}, _userId);
  }

  // Decline invitation to join a lobby
  static Future<void> declineLobbyInvitation(String lobbyId) async {
    await apiService.declineLobbyInvitation({'lobbyId': lobbyId}, _userId);
  }

  // Invite user a friend
  static Future<void> inviteFriend(String friendEmail) async {
    await apiService.inviteFriend({'email': friendEmail}, _userId);
  }

  // Fetch user's friend list
  static Future<ResponseModel<List<Map<String, String>>>?> getFriends() {
    return apiService.getFriends(_userId);
  }

  // Accept friend request
  static Future<void> acceptFriendRequest(String friendId) async {
    await apiService.acceptFriendRequest(_userId, friendId);
  }

  // Fetch available cars
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

  // Users Renting a Car
  static Future<ResponseModel<String>> postRental(
      CarRentalModel carRental) async {
    return await apiService.postRental(carRental, _userId);
  }

  // Fetch user's rentals
  static Future<ResponseModel<List<RentalModel>>> getRentals() async {
    return await apiService.getRentals(_userId);
  }
}
