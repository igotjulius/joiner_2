import 'package:dio/dio.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/pages/account/account_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

//
part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
const String serverUrl = 'https://joiner-backend-v3.onrender.com/';

final apiService =
    ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Login user
  @POST('user/login')
  Future<String> loginUser(
    @Body() UserModel user, {
    @Header('Content-Type') String contentType = 'application/json',
  });

// Get user profile
  @GET('user/{userId}/profile')
  Future<UserModel> getAccount(@Path('userId') String userId);

  // Register user
  @POST('user/register')
  Future<String> registerUser(
    @Body() UserModel nUser, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Create lobby
  @POST('/user/{userId}/lobby')
  Future<String> postLobby(
    @Body() LobbyModel lobbies,
    @Path('userId') String userId, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  // Get user lobby
  @GET('/user/{userId}/lobby')
  Future<Map<String, List<LobbyModel>>> getLobby(@Path('userId') String userId);

  //Post Conversation
  @POST('/user/{userId}/lobby/{lobbyId}/conversation/{conversationId}/message')
  Future<String> postConversation(
    @Body() MessageModel messages,
    @Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId, {
      @Header('Content-Type') String contentType = 'application/json',
    });

  //Get Conversation
  @GET('/user/{userId}/lobby/{lobbyId}/conversation/{conversationId}')
  Future<List<MessageModel>> getConversation(@Path('userId') String userId,
    @Path('lobbyId') String lobbyId,
    @Path('conversationId') String conversationId);
}
