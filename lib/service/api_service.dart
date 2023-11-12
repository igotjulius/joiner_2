import 'package:dio/dio.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import '../models/user_model.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

//
part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
// const String serverUrl = 'http://10.0.2.2:443/'; // For mobile
const String serverUrl = 'http://localhost:443/';
// const String serverUrl = 'https://joiner-backend-v3.onrender.com/';

final apiService =
    ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // User Api's
  // Register user
  @POST('user/register')
  Future<String> registerUser(
    @Body() Map<String, String> nUser, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Login user
  @POST('user/login')
  Future<ResponseModel<User>> loginUser(
    @Body() Map<String, String> map, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Create lobby
  @POST('user/{userId}/lobby')
  Future<ResponseModel> createLobby(
    @Body() LobbyModel lobby,
    @Path('userId') String userId, {
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
  @GET('user/{userId}/rent/car?availability={availability}')
  Future<ResponseModel<List<CarModel>>> getAvailableCars(
    @Path('userId') String userId, {
    @Query('availability') String availability = 'Available',
  });

  // Create new budget category
  @POST('user/{userId}/lobby/{lobbyId}/budget')
  Future<void> addBudget(
    @Body() Map<String, dynamic> map,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get all participants
  @GET('user/{userId}/lobby/{lobbyId}/participants')
  Future<ResponseModel<List<ParticipantModel>>> getParticipants(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Add a participant/s to a lobby
  @POST('user/{userId}/lobby/{lobbyId}/invitation')
  Future<void> inviteParticipants(
    @Body() List<ParticipantModel> participants,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Remove a participant from the lobby
  @DELETE('user/{userId}/lobby/{lobbyId}/participant/{participantId}')
  Future<void> removeParticipant(
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
  Future<void> inviteFriend(
    @Body() Map<String, String> user,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get user's friends
  @GET('user/{userId}/social')
  Future<ResponseModel<List<Map<String, String>>>?> getFriends(
    @Path('userId') String userId,
  );

  // Accept friend request
  @POST('user/{userId}/social/{friendId}')
  Future<void> acceptFriendRequest(
    @Path('userId') String userId,
    @Path('friendId') String friendId,
  );

  // Fetch user's rentals
  @GET('user/{userId}/rent')
  Future<ResponseModel<List<RentalModel>>> getRentals(
    @Path('userId') String userId,
  );

  // Get user profile
  @GET('user/{userId}/profile')
  Future<UserModel> getAccount(@Path('userId') String userId);

  // Get all Polls
  @GET('user/{userId}/lobby/{lobbyId}/poll')
  Future<ResponseModel<List<PollModel>>> getPoll(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
  );

  // Post Poll
  @POST('user/{userId}/lobby/{lobbyId}/poll')
  Future<ResponseModel<List<PollModel>>> postPoll(
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

  // Create Car Rentals
  @POST('user/{userId}/rent/car')
  Future<ResponseModel<String>> postRental(
    @Body() CarRentalModel carRental,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // CRA API's
  // Register CRA
  @POST('cra/register')
  Future<void> registerCra(
    @Body() Map<String, String> map, {
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

  // CHECK =>
  // Register a car
  @POST('cra/{craUserId}/car')
  Future<ResponseModel> addCar(
    @Body() CarModel car,
    @Path('craUserId') String craUserId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  //Edit car availability
  @PUT('cra/{craUserId}/car/{licensePlate}')
  Future<ResponseModel> editAvailability(
    @Body() CarModel car,
    @Path('craUserId') String craUserId,
    @Path('licensePlate') String licensePlate,
  );

  // Fetch Cra's rentals
  @GET('cra/{craUserId}/rent')
  Future<ResponseModel<List<RentalModel>>> getCraRentals(
    @Path('craUserId') String craUserId,
  );

  //
}
