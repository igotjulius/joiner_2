import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:http_parser/http_parser.dart';

class UserController {
  static late String _userId = FFAppState().pref!.getString('userId')!;

  // Register user
  static Future<String?> registerUser(User nUser) async {
    final result = await apiService.registerUser(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Login user
  static Future<User?> loginUser(User user) async {
    User? currentUser;
    await apiService
        .loginUser({'email': user.email!, 'password': user.password!}).then(
      (response) {
        if (response.code == HttpStatus.ok) {
          currentUser = response.data;
          _userId = currentUser!.id!;
        }
      },
    );
    return currentUser;
  }

  // Fetch user lobbies
  static Future<Map<String, List<LobbyModel>>> getLobbies() async {
    final response = await apiService.getLobbies(_userId);
    return response.data!;
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
        context.goNamed('MainDashboard');
      },
    );
  }

  // Delete specific lobby
  static Future<void> deleteLobby(String lobbyId) async {
    await apiService.deleteLobby(_userId, lobbyId);
  }

  // Get all poll of a lobby
  static Future<List<PollModel>?> getPoll(String lobbyId) async {
    final response = await apiService.getPoll(_userId, lobbyId);
    return response.data;
  }

  // Add/create a poll of a lobby
  static Future<PollModel> postPoll(PollModel poll, String lobbyId) async {
    final response = await apiService.postPoll(poll, _userId, lobbyId);
    return response.data!;
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
  static Future<List<ParticipantModel>> getParticipants(String lobbyId) async {
    final response = await apiService.getParticipants(_userId, lobbyId);
    return response.data!;
  }

  // Invite participant/s to a lobby
  static Future<void> inviteParticipants(
      List<ParticipantModel> participants, String lobbyId) async {
    await apiService.inviteParticipants(participants, _userId, lobbyId);
  }

  // Remove participant from the lobby
  static Future<void> removeParticipant(
      String lobbyId, String participantId) async {
    await apiService.removeParticipant(_userId, lobbyId, participantId);
  }

  // Leave from a lobby
  static Future<void> leaveLobby(String lobbyId) async {
    await apiService.leaveLobby(_userId, lobbyId);
  }

  // Accept invitation to join a lobby
  static Future<void> acceptLobbyInvitation(String lobbyId) async {
    await apiService.acceptLobbyInvitation({'lobbyId': lobbyId}, _userId);
  }

  // Decline invitation to join a lobby
  static Future<void> declineLobbyInvitation(String lobbyId) async {
    await apiService.declineLobbyInvitation({'lobbyId': lobbyId}, _userId);
  }

  // Invite user as a friend
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

  // Remove friend request
  static Future<void> removeFriendRequest(String friendId) async {
    await apiService.removeFriendRequest(_userId, friendId);
  }

  // Fetch available cars
  static Future<List<CarModel>> getAvailableCars() async {
    final response = await apiService.getAvailableCars(_userId);
    return response.data!;
  }

  // Users Renting a Car
  static Future<ResponseModel> postRental(
      CarRentalModel carRental, XFile image) async {
    List<MultipartFile> converted = [];
    converted.add(MultipartFile.fromBytes(
      await image.readAsBytes(),
      filename: image.name,
      contentType: MediaType('application', 'octet-stream'),
    ));
    return await apiService.postRental(
      _userId,
      licensePlate: carRental.licensePlate!,
      startRental: carRental.startRental!,
      endRental: carRental.endRental!,
      duration: carRental.duration!,
      files: converted,
    );
  }

  // Fetch user's rentals
  static Future<ResponseModel<List<RentalModel>>> getRentals() async {
    return await apiService.getRentals(_userId);
  }

  //Add Expenses
  static Future<ResponseModel<ExpenseModel>> putExpenses(
      ExpenseModel expenseModel, String lobbyId) async {
    return await apiService.putExpenses(expenseModel, _userId, lobbyId);
  }

  //Get Expenses
  static Future<ResponseModel<ExpenseModel>> getExpenses(String lobbyId) async {
    return await apiService.getExpenses(_userId, lobbyId);
  }

  //HOST Delete Expenses
  static Future<ResponseModel<ExpenseModel>> deleteExpenses(
      String lobbyId) async {
    return await apiService.deleteExpenses(_userId, lobbyId);
  }

  //HOST Delete SPECIFIC Expense
  static Future<ResponseModel<ExpenseModel>> deleteSpecificExpense(
      String lobbyId, String label) async {
    return await apiService.deleteSpecificExpense(_userId, lobbyId, label);
  }
}
