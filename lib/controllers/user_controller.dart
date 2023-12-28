import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends Auth {
  UserController(this._currentUser, this._apiService);
  ApiService _apiService;
  UserModel _currentUser;
  late SharedPreferences _pref;
  final _userRoutes = [
    GoRoute(
      name: 'MainDashboard',
      path: '/lobby',
      builder: (context, params) => NavBarPage(initialPage: 'MainDashboard'),
      routes: [
        GoRoute(
          name: 'LobbyCreation',
          path: 'create',
          builder: (context, state) {
            final selectedDestination = state.extra ?? '';
            return LobbyCreationWidget(
              destination: selectedDestination as String,
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
            return LobbyPageWidget(
              currentLobbyId: state.pathParameters['lobbyId']!,
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

  @override
  List<GoRoute> get routes => _userRoutes;

  @override
  User? get profile => _currentUser;

  @override
  Future cacheUser() async {
    _pref = await SharedPreferences.getInstance();
    String user = jsonEncode(_currentUser?.toJson());
    _pref.setString('user', user);
  }

  @override
  void logout() async {
    _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }

  @override
  bool isVerified() {
    return _currentUser?.verification != null ? true : false;
  }

  /* 
    Lobby related methods (Chat has its own implementation, see ChatWidget)
    - CRUD Lobby
    - CRUD Poll
    - CUD Participants
  */
  List<LobbyModel> get pendingLobbies => _currentUser!.pendingLobby;
  List<LobbyModel> get activeLobbies => _currentUser!.activeLobby;
  List<Map<String, String>> get friends => _currentUser!.friends
      .where((element) => element['status'] == 'Accepted')
      .toList();
  List<Map<String, String>> get pendingFriends => _currentUser!.friends
      .where((element) => element['status'] != 'Accepted')
      .toList();

  void refetchLobbies() async {
    try {
      final result = await _apiService.getLobbies(_currentUser!.id);
      _currentUser!.pendingLobby = result.data!['pending']!;
      _currentUser!.activeLobby = result.data!['active']!;
      notifyListeners();
    } catch (e) {
      print('Error in fetching lobbies: $e');
    }
  }

  // Fetch specific lobby
  Future<LobbyModel?> fetchLobby(String lobbyId) async {
    final res = await _apiService.getLobby(_currentUser!.id, lobbyId);
    if (res.code == HttpStatus.ok)
      return res.data;
    else
      return null;
  }

  // Create lobby TODO: implemented
  Future<LobbyModel?> createLobby(LobbyModel lobby) async {
    try {
      final result = await _apiService.createLobby(lobby, _currentUser!.id);
      _currentUser?.activeLobby.add(result.data!);
      super.notifyListeners();
      return result.data;
    } catch (e) {
      print('Error in creating lobby: $e');
    }
    return null;
  }

  // Edit lobby TODO: implemented
  Future<bool> editLobby(LobbyModel lobby) async {
    try {
      final result =
          await _apiService.editLobby(lobby, _currentUser!.id, lobby.id!);
      final index = _currentUser!.activeLobby
          .indexWhere((element) => element.id == lobby.id);
      _currentUser!.activeLobby[index] = result.data!;
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in editing lobby: $e');
      print(stack);
    }
    return false;
  }

  // Delete specific lobby TODO: implemented
  Future<bool> deleteLobby(String lobbyId) async {
    try {
      await _apiService.deleteLobby(_currentUser.id, lobbyId);
      _currentUser.activeLobby.removeWhere((element) => element.id == lobbyId);
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in deleting lobby: $e');
      print(stack);
    }
    return false;
  }

// Leave from a lobby TODO: implemented
  Future<bool> leaveLobby(String lobbyId) async {
    try {
      await _apiService.leaveLobby(_currentUser!.id, lobbyId);
      _currentUser!.activeLobby.removeWhere((element) => element.id == lobbyId);
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error leaving lobby: $e');
      print(stack);
    }
    return false;
  }

  // HOST Add Expenses TODO: implemented
  Future<bool> putExpenses(ExpenseModel expenseModel, String lobbyId) async {
    try {
      final result = await _apiService.putExpenses(
          expenseModel, _currentUser!.id, lobbyId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.expense = result.data?['expenses'];
      currentLobby.participants = result.data?['participants'];
      super.notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in adding expense: $e');
      print(stack);
    }
    return false;
  }

  //Get Expenses
  Future<ResponseModel<ExpenseModel>> getExpenses(String lobbyId) async {
    return await _apiService.getExpenses(_currentUser!.id, lobbyId);
  }

  // HOST Delete Expenses
  Future<bool> deleteExpenses(String lobbyId) async {
    try {
      final result =
          await _apiService.deleteExpenses(_currentUser!.id, lobbyId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.expense = result.data;
      super.notifyListeners();
      return true;
    } catch (e) {
      print('Error in deleting expense: $e');
    }
    return false;
  }

  // HOST Delete SPECIFIC Expense TODO: implemented
  Future<bool> deleteSpecificExpense(String lobbyId, String label) async {
    try {
      final result = await _apiService.deleteSpecificExpense(
          _currentUser!.id, lobbyId, label);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.expense = result.data?['expenses'];
      currentLobby.participants = result.data?['participants'];
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in deleting expense: $e');
      print(stack);
    }
    return false;
  }

  // Get all poll of a lobby
  Future<List<PollModel>?> getPoll(String lobbyId) async {
    final response = await _apiService.getPoll(_currentUser!.id, lobbyId);
    return response.data;
  }

  // Add/create a poll of a lobby TODO: implemented
  Future<bool> createPoll(PollModel poll, String lobbyId) async {
    try {
      final response =
          await _apiService.postPoll(poll, _currentUser!.id, lobbyId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.poll?.add(response.data!);
      super.notifyListeners();
      return true;
    } catch (e) {
      print('Error in creating poll: $e');
    }
    return false;
  }

  // Vote to a poll TODO: implemented
  Future<bool> votePoll(String choice, String lobbyId) async {
    try {
      await _apiService.votePoll({'title': choice}, _currentUser!.id, lobbyId);
      super.notifyListeners();

      return true;
    } catch (e) {
      print('Error in voting poll: $e');
    }
    return false;
  }

  // Close corresponding poll TODO: implemented
  Future<bool> closePoll(String lobbyId, String pollId) async {
    try {
      await _apiService.closePoll(_currentUser!.id, lobbyId, pollId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      final poll =
          currentLobby.poll?.firstWhere((element) => element.id == pollId);
      poll?.isOpen = !poll.isOpen!;
      super.notifyListeners();
      return true;
    } catch (e) {
      print('Error in closing poll: $e');
    }
    return false;
  }

  // Delete corresponding poll TODO: implemented
  Future<bool> deletePoll(String lobbyId, String pollId) async {
    try {
      await _apiService.deletePoll(_currentUser!.id, lobbyId, pollId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.poll?.removeWhere((element) => element.id == pollId);
      super.notifyListeners();
      return true;
    } catch (e) {
      print('Error in deleting poll: $e');
    }
    return false;
  }

  // Fetch participants of a lobby
  Future<List<ParticipantModel>> getParticipants(String lobbyId) async {
    final response =
        await _apiService.getParticipants(_currentUser!.id, lobbyId);
    return response.data!;
  }

  // Invite participant/s to a lobby TODO: implemented
  Future<bool> inviteParticipants(
      List<ParticipantModel> participants, String lobbyId) async {
    try {
      final result = await _apiService.inviteParticipants(
          participants, _currentUser!.id, lobbyId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.participants = result.data!;
      super.notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in inviting participants: $e');
      print(stack);
    }
    return false;
  }

  // Remove participant from the lobby TODO: implemented
  Future<bool> removeParticipant(String lobbyId, String participantId) async {
    try {
      await _apiService.removeParticipant(
          _currentUser!.id, lobbyId, participantId);
      final currentLobby = _currentUser!.activeLobby
          .firstWhere((element) => element.id == lobbyId);
      currentLobby.participants
          ?.removeWhere((element) => element.id == participantId);
      super.notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in removing participant: $e');
      print(stack);
    }
    return false;
  }

  // Accept invitation to join a lobby
  Future<void> acceptLobbyInvitation(String lobbyId) async {
    await _apiService
        .acceptLobbyInvitation({'lobbyId': lobbyId}, _currentUser!.id);
  }

  // Decline invitation to join a lobby
  Future<void> declineLobbyInvitation(String lobbyId) async {
    await _apiService
        .declineLobbyInvitation({'lobbyId': lobbyId}, _currentUser!.id);
  }

  /* 

    -----End of Lobby relations----- 

  */

  /* 
    Rentals related
  */
  List<RentalModel> get rentals => _currentUser.rentals!;

  // Fetch user's rentals
  Future<bool> refetchRentals() async {
    try {
      final result = await _apiService.getRentals(_currentUser!.id);
      _currentUser.rentals = result.data;
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in fetching user rentals: $e');
      print(stack);
    }
    return false;
  }

  Future<bool> linkRentalToLobby(RentalModel rental, String lobbyId) async {
    try {
      final result = await _apiService.linkRentalToLobby(
        rental,
        _currentUser!.id,
        lobbyId,
      );
      final currentRental = _currentUser.rentals
          ?.firstWhere((element) => element.id == rental.id);
      currentRental?.linkedLobbyId = lobbyId;
      return true;
    } catch (e, stack) {
      print('Error in linking to lobby: $e');
      print(stack);
    }
    return false;
  }

  /*

    -----End of Rentals relations-----

  */

  // Invite user as a friend
  Future<void> inviteFriend(String friendEmail) async {
    await _apiService.inviteFriend({'email': friendEmail}, _currentUser!.id);
  }

  // Fetch user's friend list
  Future<ResponseModel<List<Map<String, String>>>?> getFriends() {
    return _apiService.getFriends(_currentUser!.id);
  }

  // Accept friend request
  Future<void> acceptFriendRequest(String friendId) async {
    await _apiService.acceptFriendRequest(_currentUser!.id, friendId);
  }

  // Remove friend request
  Future<void> removeFriendRequest(String friendId) async {
    await _apiService.removeFriendRequest(_currentUser!.id, friendId);
  }

  // Fetch available cars
  Future<List<CarModel>> getAvailableCars() async {
    final response = await _apiService.getAvailableCars(_currentUser!.id);
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
      _currentUser!.id,
      licensePlate: carRental.licensePlate!,
      startRental: carRental.startRental!,
      endRental: carRental.endRental!,
      duration: carRental.duration!,
      files: converted,
    );
  }

  // Edit user profile
  Future<UserModel?> editAccount(String firstName, String lastName) async {
    final request = {'firstName': firstName, 'lastName': lastName};
    final result = await _apiService.editAccount(request, _currentUser!.id);
    return result.data;
  }

  // Change password
  Future<ResponseModel> changePassword(
      String currentPassword, String nPassword) async {
    final request = {'password': currentPassword, 'newPassword': nPassword};
    return await _apiService.changePassword(request, _currentUser!.id);
  }
}
