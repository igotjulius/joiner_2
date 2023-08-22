import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

//
part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
const String serverUrl = 'http://10.0.2.2:3000/';

final apiService =
    ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Get all lobby
  @GET('lobby')
  Future<List<LobbyModel>> getLobby();

  // Get lobby
  @POST('lobby')
  Future<LobbyModel> postLobby(
    @Body() LobbyModel lobbies, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  // Update lobby
  @POST('updateLobby')
  Future<LobbyModel> updateLobby(
    @Body() LobbyModel lobby, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  // Delete lobby
  @POST('deleteLobby')
  Future deleteLobby(
    @Body() LobbyModel lobby, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  // Register user
  @POST('register')
  Future<UserModel> registerUser(
    @Body() UserModel nUser, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  //Login user
  @POST('login')
  Future<UserModel> loginUser(
    @Body() UserModel user, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });
}
