import 'package:dio/dio.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/friend_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/service/generic_response.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
// const String serverUrl =
//     'http://10.0.2.2:443/'; // For mobile emulator run on the host machine
/*
  For physical phones, address might change.
  Run ipconfig from the host machine to configure the ip address of the server.
  Make sure that the physical phone and host machine are in the same network.
*/
// const String serverUrl = 'http://192.168.137.1:443/';
const String serverUrl = 'http://localhost:443/';
 //const String serverUrl = 'https://joiner-backend-v4.onrender.com/';

// final apiService = ApiService(Dio(), baseUrl: serverUrl);
// ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // User Api's
  // Register user
  @POST('user/register')
  Future<ResponseModel> registerUser(
    @Body() User nUser, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Login user, could be general user or cra user
  @POST('login')
  Future<ResponseModel<User?>> loginUser(
    @Body() Map<String, String> credentials, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Verify email of a user, could be general user or cra user
  @POST('verify')
  Future<ResponseModel<User?>> verify(
    @Body() Map<String, String> request,
  );

  // Resend verification code
  @POST('sendVerification')
  Future<void> resendVerification(
    @Body() Map<String, String> email,
  );

  // Create lobby
  @POST('user/{userId}/lobby')
  Future<ResponseModel<LobbyModel?>> createLobby(
    @Body() LobbyModel lobby,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Edit lobby
  @PUT('user/{userId}/lobby/{lobbyId}')
  Future<ResponseModel<LobbyModel>> editLobby(
    @Body() LobbyModel lobby,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Fetch user lobby
  @GET('user/{userId}/lobby')
  Future<ResponseModel<Map<String, List<LobbyModel>>>> getLobbies(
      @Path('userId') String userId);

  // Fetch specific lobby
  @GET('user/{userId}/lobby/{lobbyId}')
  Future<ResponseModel<LobbyModel>> getLobby(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Delete a specific lobby
  @DELETE('user/{userId}/lobby/{lobbyId}')
  Future<void> deleteLobby(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Create message
  @POST('user/{userId}/lobby/{lobbyId}/conversation/{conversationId}/message')
  Future<void> createMessage(
    @Body() MessageModel message,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get Conversation
  @GET('user/{userId}/lobby/{lobbyId}/conversation/{conversationId}')
  Future<ResponseModel<List<MessageModel>?>> getConversation(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId,
  );

  // Get all available cars
  @POST('user/{userId}/rent/car/available')
  Future<ResponseModel<List<CarModel>>> getAvailableCars(
    @Body() Map<String, dynamic> body,
    @Path('userId') String userId, {
    @Query('filter') String? queryString,
  });

  // Get all participants
  @GET('user/{userId}/lobby/{lobbyId}/participants')
  Future<ResponseModel<List<ParticipantModel>>> getParticipants(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Add a participant/s to a lobby
  @POST('user/{userId}/lobby/{lobbyId}/invitation')
  Future<ResponseModel<List<ParticipantModel>?>> inviteParticipants(
    @Body() List<ParticipantModel> participants,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Remove a participant from the lobby
  @DELETE('user/{userId}/lobby/{lobbyId}/participant/{participantId}')
  Future<ResponseModel<List<ParticipantModel>>> removeParticipant(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('participantId') String participantId,
  );

  // Leave from a lobby
  @POST('user/{userId}/lobby/{lobbyId}/leave')
  Future<void> leaveLobby(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Accept an invite to join a lobby
  @POST('user/{userId}/invitation/accept')
  Future<void> acceptLobbyInvitation(
    @Body() Map<String, String> map,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Decline an invite to join a lobby
  @POST('user/{userId}/invitation/decline')
  Future<void> declineLobbyInvitation(
    @Body() Map<String, String> map,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Invite a friend (send friend request)
  @POST('user/{userId}/social')
  Future<ResponseModel<FriendModel>> inviteFriend(
    @Body() Map<String, String> user,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get user's friends
  @GET('user/{userId}/social')
  Future<ResponseModel<List<FriendModel>>> getFriends(
    @Path('userId') String userId,
  );

  // Accept friend request
  @POST('user/{userId}/social/{friendId}')
  Future<void> acceptFriendRequest(
    @Path('userId') String userId,
    @Path('friendId') String friendId,
  );

  // Remove friend request
  @DELETE('user/{userId}/social/{friendId}')
  Future<ResponseModel> removeFriendRequest(
    @Path('userId') String userId,
    @Path('friendId') String friendId,
  );

  // Fetch user's rentals
  @GET('user/{userId}/rent')
  Future<ResponseModel<List<RentalModel>>> getRentals(
    @Path('userId') String userId,
  );

  // Edit user profile
  @POST('user/{userId}/account')
  Future<ResponseModel> editAccount(
    @Body() Map<String, String> update,
    @Path('userId') String userId,
  );

  // Change password
  @POST('user/{userId}/changePassword')
  Future<ResponseModel<String>> changePassword(
    @Body() Map<String, String> request,
    @Path('userId') String userId,
  );

  // Get all Polls
  @GET('user/{userId}/lobby/{lobbyId}/poll')
  Future<ResponseModel<List<PollModel>>> getPoll(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Post Poll
  @POST('user/{userId}/lobby/{lobbyId}/poll')
  Future<ResponseModel<PollModel>> postPoll(
    @Body() PollModel poll,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Vote to a poll
  @PUT('user/{userId}/lobby/{lobbyId}/poll')
  Future<ResponseModel<PollModel>> votePoll(
    @Body() Map<String, String> choice,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Close a poll
  @PUT('user/{userId}/lobby/{lobbyId}/poll/{pollId}')
  Future<ResponseModel<PollModel>> closePoll(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('pollId') String pollId,
  );

  // Delete a poll
  @DELETE('user/{userId}/lobby/{lobbyId}/poll/{pollId}')
  Future<ResponseModel<List<PollModel>>> deletePoll(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('pollId') String pollId,
  );

  // Rent a car
  @MultiPart()
  @POST('user/{userId}/rent/car')
  Future<ResponseModel<String>> postRental(
    @Path('userId') String craUserId, {
    @Part() required String licensePlate,
    @Part() required String startRental,
    @Part() required String endRental,
    @Part() required int duration,
    @Part() List<MultipartFile>? files,
  });

  // Link rental to a lobby
  @POST('user/{userId}/rent/{lobbyId}')
  Future<ResponseModel> linkRentalToLobby(
    @Body() RentalModel rental,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Split expenses equally or not, resets each participant's contribution
  @POST('user/{userId}/lobby/{lobbyId}/expense')
  Future<ResponseModel<Map<String, dynamic>>> resetExpenses(
    @Body() ExpenseModel body,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Add expenses
  @PUT('user/{userId}/lobby/{lobbyId}/expense')
  Future<ResponseModel<Map<String, dynamic>>> putExpenses(
    @Body() ExpenseModel expense,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get Expenses
  @GET('user/{userId}/lobby/{lobbyId}/expense')
  Future<ResponseModel<ExpenseModel>> getExpenses(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // HOST Delete Expenses
  @DELETE('user/{userId}/lobby/{lobbyId}/expense')
  Future<ResponseModel<ExpenseModel>> deleteExpenses(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // HOST Delete SPECIFIC Expense
  @DELETE('user/{userId}/lobby/{lobbyId}/expense/{label}')
  Future<ResponseModel<Map<String, dynamic>>> deleteSpecificExpense(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('label') String label,
  );

  @POST('user/{userId}/lobby/{lobbyId}/budget/{participantId}')
  Future<ResponseModel<ParticipantModel>> increaseContribution(
    @Body() Map<String, double> body,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('participantId') String participantId,
  );

  // CRA API's
  // Register CRA
  @POST('cra/register')
  Future<ResponseModel> registerCra(
    @Body() User nCraUser, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Login CRA
  @POST('cra/login')
  Future<ResponseModel<User>> loginCra(
    @Body() Map<String, dynamic> map, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get all cars of corresponding CRA
  @GET('cra/{craUserId}/car')
  Future<ResponseModel<List<CarModel>?>> getCraCars(
    @Path('craUserId') String craUserId,
  );

  // Get specific car
  @GET('cra/{craUserId}/car/{licensePlate}')
  Future<ResponseModel<CarModel?>> getCraCar(
    @Path('craUserId') String craUserId,
    @Path('licensePlate') String licensePlate,
  );

  // Fetch Cra's rentals
  @GET('cra/{craUserId}/rentals')
  Future<ResponseModel<List<RentalModel>?>> getCraRentals(
    @Path('craUserId') String craUserId,
  );

  // Registering a car and uploading an image
  @MultiPart()
  @POST('cra/{craUserId}/register/car')
  Future<ResponseModel<CarModel>> registerCar(
    @Path('craUserId') String craUserId, {
    @Part() required String licensePlate,
    @Part() required String ownerId,
    @Part() required String ownerName,
    @Part() required String vehicleType,
    @Part() required String availability,
    @Part() required String startDate,
    @Part() required String endDate,
    @Part() required double price,
    @Part() List<MultipartFile>? files,
  });

  // Editing a car
  @MultiPart()
  @PUT('cra/{craUserId}/car/{licensePlate}')
  Future<ResponseModel<CarModel>> editCar(
    @Path('craUserId') String craUserId,
    @Path('licensePlate') String carLicensePlate, {
    @Part() required String licensePlate,
    @Part() required String vehicleType,
    @Part() required String availability,
    @Part() required String startDate,
    @Part() required String endDate,
    @Part() required double price,
    @Part() List<MultipartFile>? files,
  });

  // Delete a car
  @DELETE('cra/{craUserId}/car/{licensePlate}')
  Future<ResponseModel> deleteCar(
    @Path('craUserId') String craUserId,
    @Path('licensePlate') String licensePlate,
  );

  // Edit cra profile
  @POST('cra/{craUserId}/account')
  Future<ResponseModel> editCraAccount(
    @Body() Map<String, String> update,
    @Path('craUserId') String craUserId,
  );

  // Change cra password
  @POST('cra/{craUserId}/changePassword')
  Future<ResponseModel<String>> changeCraPassword(
    @Body() Map<String, String> update,
    @Path('craUserId') String craUserId,
  );
}
