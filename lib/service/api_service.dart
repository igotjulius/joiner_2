import 'package:dio/dio.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import 'package:retrofit/http.dart';
import '../models/lobby_model.dart';

//
part 'api_service.g.dart';

// local environment, use ngrok for port forwarding
const String serverUrl = 'https://joiner-backend-v2.onrender.com/';

final apiService =
    ApiService(Dio(BaseOptions(contentType: 'application/json')));

@RestApi(baseUrl: serverUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Register user
  @POST('user/register')
  Future<String> registerUser(
    @Body() UserModel nUser, {
    @Header('Content-Type')
    String contentType = 'application/json',
  });

  // Get lobby
  @POST('/user/{userId}/lobby')
  Future<String> postLobby(
    @Body() LobbyModel lobbies,
    @Path('userId')String userId,{
    @Header('Content-Type')
    String contentType = 'application/json',
  });

  // Get all lobby
  @GET('/user/650963e2ff267fdf6ea95a73/lobby')
  Future<List<LobbyModel>> getLobby(
    @Path('650963e2ff267fdf6ea95a73')String userId
  );









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

  
  

  // Login user
  @POST('login')
  Future<UserModel> loginUser(
    @Body() UserModel user, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  // Get all transaction
  @GET('transaction')
  Future<List<TransactionModel>> getTransaction();

  // Add transaction
  @POST('transaction')
  Future<TransactionModel> addTransaction(
    @Body() TransactionModel transaction, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });

  // Cancel transaction
  @POST('cancelTransaction')
  Future<TransactionModel> cancelTransaction(
    @Body() TransactionModel transaction, {
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',
  });
}
