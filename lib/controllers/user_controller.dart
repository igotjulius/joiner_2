import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:http_parser/http_parser.dart';

class UserController {
  static late Map<String, String> user = {
    'userId': '',
  };

  // Register user
  static Future<String?> registerUser(User nUser) async {
    final result = await apiService.registerUser(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Fetch user lobbies
  static Future<Map<String, List<LobbyModel>>> getLobbies() async {
    final response = await apiService.getLobbies(user['userId']!);
    return response.data!;
  }

  // Fetch specific lobby
  static Future<LobbyModel?> getLobby(String lobbyId) async {
    final res = await apiService.getLobby(user['userId']!, lobbyId);
    if (res.code == HttpStatus.ok)
      return res.data;
    else
      return null;
  }

  // Create lobby
  static Future<LobbyModel?> createLobby(
      LobbyModel lobby, BuildContext context) async {
    final result = await apiService.createLobby(lobby, user['userId']!);
    return result.data;
  }

  static Future<LobbyModel?> editLobby(LobbyModel lobby) async {
    final result =
        await apiService.editLobby(lobby, user['userId']!, lobby.id!);
    return result.data;
  }

  // Delete specific lobby
  static Future<void> deleteLobby(String lobbyId) async {
    await apiService.deleteLobby(user['userId']!, lobbyId);
  }

  // Get all poll of a lobby
  static Future<List<PollModel>?> getPoll(String lobbyId) async {
    final response = await apiService.getPoll(user['userId']!, lobbyId);
    return response.data;
  }

  // Add/create a poll of a lobby
  static Future<PollModel> postPoll(PollModel poll, String lobbyId) async {
    final response = await apiService.postPoll(poll, user['userId']!, lobbyId);
    return response.data!;
  }

  // Vote to a poll
  static Future<PollModel> votePoll(String choice, String lobbyId) async {
    final response =
        await apiService.votePoll({'title': choice}, user['userId']!, lobbyId);
    return response.data!;
  }

  // Close corresponding poll
  static Future<PollModel> closePoll(String lobbyId, String pollId) async {
    final response =
        await apiService.closePoll(user['userId']!, lobbyId, pollId);
    return response.data!;
  }

  // Delete corresponding poll
  static Future<List<PollModel>?> deletePoll(
      String lobbyId, String pollId) async {
    final response =
        await apiService.deletePoll(user['userId']!, lobbyId, pollId);
    return response.data;
  }

  // Fetch participants of a lobby
  static Future<List<ParticipantModel>> getParticipants(String lobbyId) async {
    final response = await apiService.getParticipants(user['userId']!, lobbyId);
    return response.data!;
  }

  // Invite participant/s to a lobby
  static Future<void> inviteParticipants(
      List<ParticipantModel> participants, String lobbyId) async {
    await apiService.inviteParticipants(participants, user['userId']!, lobbyId);
  }

  // Remove participant from the lobby
  static Future<void> removeParticipant(
      String lobbyId, String participantId) async {
    await apiService.removeParticipant(user['userId']!, lobbyId, participantId);
  }

  // Leave from a lobby
  static Future<void> leaveLobby(String lobbyId) async {
    await apiService.leaveLobby(user['userId']!, lobbyId);
  }

  // Accept invitation to join a lobby
  static Future<void> acceptLobbyInvitation(String lobbyId) async {
    await apiService
        .acceptLobbyInvitation({'lobbyId': lobbyId}, user['userId']!);
  }

  // Decline invitation to join a lobby
  static Future<void> declineLobbyInvitation(String lobbyId) async {
    await apiService
        .declineLobbyInvitation({'lobbyId': lobbyId}, user['userId']!);
  }

  // Invite user as a friend
  static Future<void> inviteFriend(String friendEmail) async {
    await apiService.inviteFriend({'email': friendEmail}, user['userId']!);
  }

  // Fetch user's friend list
  static Future<ResponseModel<List<Map<String, String>>>?> getFriends() {
    return apiService.getFriends(user['userId']!);
  }

  // Accept friend request
  static Future<void> acceptFriendRequest(String friendId) async {
    await apiService.acceptFriendRequest(user['userId']!, friendId);
  }

  // Remove friend request
  static Future<void> removeFriendRequest(String friendId) async {
    await apiService.removeFriendRequest(user['userId']!, friendId);
  }

  // Fetch available cars
  static Future<List<CarModel>> getAvailableCars() async {
    final response = await apiService.getAvailableCars(user['userId']!);
    return response.data!;
  }

  // User Renting a Car
  static Future<ResponseModel<String>> postRental(
      CarRentalModel carRental, XFile image) async {
    List<MultipartFile> converted = [];
    converted.add(MultipartFile.fromBytes(
      await image.readAsBytes(),
      filename: image.name,
      contentType: MediaType('application', 'octet-stream'),
    ));
    return await apiService.postRental(
      user['userId']!,
      licensePlate: carRental.licensePlate!,
      startRental: carRental.startRental!,
      endRental: carRental.endRental!,
      duration: carRental.duration!,
      files: converted,
    );
  }

  // Fetch user's rentals
  static Future<ResponseModel<List<RentalModel>>> getRentals() async {
    return await apiService.getRentals(user['userId']!);
  }

  static Future<bool> linkRentalToLobby(
      RentalModel rental, String lobbyId) async {
    final result = await apiService.linkRentalToLobby(
      rental,
      user['userId']!,
      lobbyId,
    );
    return result.code == HttpStatus.ok ? true : false;
  }

  //Add Expenses
  static Future<ResponseModel<ExpenseModel>> putExpenses(
      ExpenseModel expenseModel, String lobbyId) async {
    return await apiService.putExpenses(expenseModel, user['userId']!, lobbyId);
  }

  //Get Expenses
  static Future<ResponseModel<ExpenseModel>> getExpenses(String lobbyId) async {
    return await apiService.getExpenses(user['userId']!, lobbyId);
  }

  //HOST Delete Expenses
  static Future<ResponseModel<ExpenseModel>> deleteExpenses(
      String lobbyId) async {
    return await apiService.deleteExpenses(user['userId']!, lobbyId);
  }

  //HOST Delete SPECIFIC Expense
  static Future<ResponseModel<ExpenseModel>> deleteSpecificExpense(
      String lobbyId, String label) async {
    return await apiService.deleteSpecificExpense(
        user['userId']!, lobbyId, label);
  }

  // Edit user profile
  static Future<UserModel?> editAccount(
      String firstName, String lastName) async {
    final request = {'firstName': firstName, 'lastName': lastName};
    final result = await apiService.editAccount(request, user['userId']!);
    return result.data;
  }

  // Change password
  static Future<ResponseModel> changePassword(
      String currentPassword, String nPassword) async {
    final request = {'password': currentPassword, 'newPassword': nPassword};
    return await apiService.changePassword(request, user['userId']!);
  }
}
