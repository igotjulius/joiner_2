import 'package:dio/dio.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/account/account_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:retrofit/dio.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

//
part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
// const String serverUrl = 'http://localhost:443/';
const String serverUrl = 'https://joiner-backend-v3.onrender.com/';

final apiService =
    ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Login user
  @POST('user/login')
  Future<ResponseModel<UserModel>> loginUser(
    @Body() UserModel user, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Create lobby
  @POST('/user/{userId}/lobby')
  Future<ResponseModel> createLobby(
    @Body() LobbyModel lobby,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get user lobby
  @GET('/user/{userId}/lobby')
  Future<ResponseModel<Map<String, List<LobbyModel>>>> getLobby(
      @Path('userId') String userId);

  //Create message
  @POST('/user/{userId}/lobby/{lobbyId}/conversation/{conversationId}/message')
  Future<void> createMessage(
    @Body() MessageModel message,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  //Get Conversation
  @GET('/user/{userId}/lobby/{lobbyId}/conversation/{conversationId}')
  Future<ResponseModel<List<MessageModel>>> getConversation(
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId,
  );

  // Get user profile
  @GET('user/{userId}/profile')
  Future<UserModel> getAccount(@Path('userId') String userId);

  // Register user
  @POST('user/register')
  Future<String> registerUser(
    @Body() UserModel nUser, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  //Get Poll
  @GET('user/{userId}/lobby/{lobbyId}/poll')
  Future<List<PollModel>> getPoll(@Path('userId') String userId, @Path('lobbyId') String lobbyId);

  //Post Poll
  @POST('user/{userId}/lobby/{lobbyId}/poll')
  Future<void> postPoll (
    @Body() PollModel poll,
    @Path('userId') String userId, 
    @Path('lobbyId') String lobbyId, {
    @Header('Content-Type') String contentType = 'application/json',
    }
  );

  @DELETE('user/{userId}/lobby/{lobbyId}/poll/{pollId}')
  Future<void> deletePoll (
    @Path('userId') String userId, 
    @Path('lobbyId') String lobbyId, 
    @Path('pollId') String pollId,
  );
}
