import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/main.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/pages/shared_pages/account/account_widget.dart';
import 'package:joiner_1/pages/shared_pages/rental_details/rental_details_widget.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/lobby_creation/lobby_creation_widget.dart';
import 'package:joiner_1/pages/user/dashboard/map_feature/map_feature.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/friends/friends_widget.dart';
import 'package:joiner_1/pages/user/friends/invite_friend/invite_friend_widget.dart';
import 'package:joiner_1/pages/user/rentals/car_booking/car_booking_widget.dart';
import 'package:joiner_1/pages/user/rentals/car_details/car_details_widget.dart';
import 'package:joiner_1/pages/user/rentals/listings/listings_widget.dart';
import 'package:joiner_1/pages/user/rentals/payment_result/result_widget.dart';
import 'package:joiner_1/pages/user/rentals/rentals_widget.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends AuthController implements Auth {
  UserController(this._currentUser, this._apiService) {
    final userRoutes = [
      GoRoute(
        name: 'MainDashboard',
        path: '/lobby',
        builder: (context, params) => NavBarPage(initialPage: 'MainDashboard'),
        routes: [
          GoRoute(
            name: 'LobbyCreation',
            path: 'create',
            builder: (context, state) {
              final selectedDestination = state.extra as String;
              return LobbyCreationWidget(
                destination: selectedDestination,
              );
            },
          ),
          GoRoute(
            name: 'BrowseMap',
            path: 'browseMap',
            builder: (context, state) => MapFeature(),
          ),
          GoRoute(
            name: 'Lobby',
            path: ':lobbyId',
            builder: (context, state) {
              final obj = state.extra as LobbyModel;
              return ChangeNotifierProvider(
                create: (_) => LobbyProvider(obj),
                child: LobbyPageWidget(
                  currentLobby: obj,
                  lobbyId: state.pathParameters['lobbyId'],
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: 'CarRentals',
        path: '/rentals',
        builder: (context, params) => NavBarPage(
          initialPage: 'CarRentals',
          page: RentalsWidget(),
        ),
        routes: [
          GoRoute(
            name: 'Listings',
            path: 'listings',
            builder: (context, params) => ListingsWidget(),
          ),
          GoRoute(
              name: 'CarDetails',
              path: 'carDetails',
              builder: (context, state) {
                CarModel obj = state.extra as CarModel;
                return CarDetails(car: obj);
              }),
          GoRoute(
            name: 'Booking',
            path: 'booking',
            builder: (context, state) {
              CarModel obj = state.extra as CarModel;
              return CarBookingWidget(car: obj);
            },
          ),
          GoRoute(
            name: 'RentalDetails',
            path: 'rentalDetails',
            builder: (context, state) {
              final RentalModel rental = state.extra as RentalModel;
              return RentalDetails(
                rental: rental,
              );
            },
          ),
          GoRoute(
            name: 'Result',
            path: ':paymentResult',
            builder: (context, state) {
              final result = state.pathParameters['paymentResult'] as String;
              return ResultWidget(
                result: result,
              );
            },
          ),
          GoRoute(
            path: 'success',
            builder: (context, state) => ResultWidget(result: 'success'),
          ),
        ],
      ),
      GoRoute(
        name: 'Friends',
        path: '/friends',
        builder: (context, params) => NavBarPage(
          initialPage: 'Friends',
          page: FriendsWidget(),
        ),
        routes: [
          GoRoute(
            name: 'InviteFriend',
            path: 'invite-request',
            builder: (context, params) => InviteFriendWidget(),
          ),
        ],
      ),
      GoRoute(
        name: 'Account',
        path: '/account',
        builder: (context, params) => NavBarPage(
          initialPage: 'Account',
          page: AccountWidget(),
        ),
      ),
    ];
    super.setRoutes(userRoutes);
  }
  ApiService _apiService;
  UserModel _currentUser;
  late SharedPreferences _pref;

  @override
  User get profile => _currentUser;

  @override
  Future cacheUser() async {
    _pref = await SharedPreferences.getInstance();
    String user = jsonEncode(_currentUser.toJson());
    _pref.setString('user', user);
  }

  @override
  void logout() async {
    _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }

  @override
  bool isVerified() {
    return _currentUser.verification != null ? true : false;
  }

  List<LobbyModel> get pendingLobbies => _currentUser.pendingLobby;
  List<LobbyModel> get activeLobbies => _currentUser.activeLobby;
  void refetchLobbies() async {
    final result = await _apiService.getLobbies(_currentUser.id);
    _currentUser.pendingLobby = result.data!['pendingLobby']!;
    _currentUser.activeLobby = result.data!['activeLobby']!;
    super.notifyListeners();
  }

  // Fetch specific lobby
  Future<LobbyModel?> fetchLobby(String lobbyId) async {
    final res = await _apiService.getLobby(_currentUser.id, lobbyId);
    if (res.code == HttpStatus.ok)
      return res.data;
    else
      return null;
  }

  // Create lobby
  Future<LobbyModel?> createLobby(
      LobbyModel lobby, BuildContext context) async {
    final result = await _apiService.createLobby(lobby, _currentUser.id);
    return result.data;
  }

  Future<LobbyModel?> editLobby(LobbyModel lobby) async {
    final result =
        await _apiService.editLobby(lobby, _currentUser.id, lobby.id!);
    return result.data;
  }

  // Delete specific lobby
  Future<void> deleteLobby(String lobbyId) async {
    await _apiService.deleteLobby(_currentUser.id, lobbyId);
  }

  // Get all poll of a lobby
  Future<List<PollModel>?> getPoll(String lobbyId) async {
    final response = await _apiService.getPoll(_currentUser.id, lobbyId);
    return response.data;
  }

  // Add/create a poll of a lobby
  Future<PollModel> postPoll(PollModel poll, String lobbyId) async {
    final response = await _apiService.postPoll(poll, _currentUser.id, lobbyId);
    return response.data!;
  }

  // Vote to a poll
  Future<PollModel> votePoll(String choice, String lobbyId) async {
    final response =
        await _apiService.votePoll({'title': choice}, _currentUser.id, lobbyId);
    return response.data!;
  }

  // Close corresponding poll
  Future<PollModel> closePoll(String lobbyId, String pollId) async {
    final response =
        await _apiService.closePoll(_currentUser.id, lobbyId, pollId);
    return response.data!;
  }

  // Delete corresponding poll
  Future<List<PollModel>?> deletePoll(String lobbyId, String pollId) async {
    final response =
        await _apiService.deletePoll(_currentUser.id, lobbyId, pollId);
    return response.data;
  }

  // Fetch participants of a lobby
  Future<List<ParticipantModel>> getParticipants(String lobbyId) async {
    final response =
        await _apiService.getParticipants(_currentUser.id, lobbyId);
    return response.data!;
  }

  // Invite participant/s to a lobby
  Future<void> inviteParticipants(
      List<ParticipantModel> participants, String lobbyId) async {
    await _apiService.inviteParticipants(
        participants, _currentUser.id, lobbyId);
  }

  // Remove participant from the lobby
  Future<void> removeParticipant(String lobbyId, String participantId) async {
    await _apiService.removeParticipant(
        _currentUser.id, lobbyId, participantId);
  }

  // Leave from a lobby
  Future<void> leaveLobby(String lobbyId) async {
    await _apiService.leaveLobby(_currentUser.id, lobbyId);
  }

  // Accept invitation to join a lobby
  Future<void> acceptLobbyInvitation(String lobbyId) async {
    await _apiService
        .acceptLobbyInvitation({'lobbyId': lobbyId}, _currentUser.id);
  }

  // Decline invitation to join a lobby
  Future<void> declineLobbyInvitation(String lobbyId) async {
    await _apiService
        .declineLobbyInvitation({'lobbyId': lobbyId}, _currentUser.id);
  }

  // Invite user as a friend
  Future<void> inviteFriend(String friendEmail) async {
    await _apiService.inviteFriend({'email': friendEmail}, _currentUser.id);
  }

  // Fetch user's friend list
  Future<ResponseModel<List<Map<String, String>>>?> getFriends() {
    return _apiService.getFriends(_currentUser.id);
  }

  // Accept friend request
  Future<void> acceptFriendRequest(String friendId) async {
    await _apiService.acceptFriendRequest(_currentUser.id, friendId);
  }

  // Remove friend request
  Future<void> removeFriendRequest(String friendId) async {
    await _apiService.removeFriendRequest(_currentUser.id, friendId);
  }

  // Fetch available cars
  Future<List<CarModel>> getAvailableCars() async {
    final response = await _apiService.getAvailableCars(_currentUser.id);
    return response.data!;
  }

  // User Renting a Car
  Future<ResponseModel<String>> postRental(
      CarRentalModel carRental, XFile image) async {
    List<MultipartFile> converted = [];
    converted.add(MultipartFile.fromBytes(
      await image.readAsBytes(),
      filename: image.name,
      contentType: MediaType('application', 'octet-stream'),
    ));
    return await _apiService.postRental(
      _currentUser.id,
      licensePlate: carRental.licensePlate!,
      startRental: carRental.startRental!,
      endRental: carRental.endRental!,
      duration: carRental.duration!,
      files: converted,
    );
  }

  // Fetch user's rentals
  Future<ResponseModel<List<RentalModel>>> getRentals() async {
    return await _apiService.getRentals(_currentUser.id);
  }

  Future<bool> linkRentalToLobby(RentalModel rental, String lobbyId) async {
    final result = await _apiService.linkRentalToLobby(
      rental,
      _currentUser.id,
      lobbyId,
    );
    return result.code == HttpStatus.ok ? true : false;
  }

  //Add Expenses
  Future<ResponseModel<ExpenseModel>> putExpenses(
      ExpenseModel expenseModel, String lobbyId) async {
    return await _apiService.putExpenses(
        expenseModel, _currentUser.id, lobbyId);
  }

  //Get Expenses
  Future<ResponseModel<ExpenseModel>> getExpenses(String lobbyId) async {
    return await _apiService.getExpenses(_currentUser.id, lobbyId);
  }

  //HOST Delete Expenses
  Future<ResponseModel<ExpenseModel>> deleteExpenses(String lobbyId) async {
    return await _apiService.deleteExpenses(_currentUser.id, lobbyId);
  }

  //HOST Delete SPECIFIC Expense
  Future<ResponseModel<ExpenseModel>> deleteSpecificExpense(
      String lobbyId, String label) async {
    return await _apiService.deleteSpecificExpense(
        _currentUser.id, lobbyId, label);
  }

  // Edit user profile
  Future<UserModel?> editAccount(String firstName, String lastName) async {
    final request = {'firstName': firstName, 'lastName': lastName};
    final result = await _apiService.editAccount(request, _currentUser.id);
    return result.data;
  }

  // Change password
  Future<ResponseModel> changePassword(
      String currentPassword, String nPassword) async {
    final request = {'password': currentPassword, 'newPassword': nPassword};
    return await _apiService.changePassword(request, _currentUser.id);
  }
}
