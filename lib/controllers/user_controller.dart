import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/car_item_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/molecules/widget_lobby.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class UserController {
  static String _userId = '6522a0c73e680ea09ee89d5f';
  static String _lobbyId = '65279f410e8b2ee1b1412372';
  static String _conversationId = '65279f410e8b2ee1b1412375';

  // Login user
  static void loginUser(UserModel user, FFAppState appState) async {
    await apiService.loginUser(user).then((response) {
      if (response.code == HttpStatus.ok) {
        appState.setCurrentUser(response.data!);
      }
    });
  }

  // Get user lobbies
  static FutureBuilder<ResponseModel<Map<String, List<LobbyModel>>>>
      userLobbies(FFAppState appState) {
    return FutureBuilder(
      future: apiService.getLobby(appState.currentUser!.id!),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.code == HttpStatus.ok) {
            final Map<String, List<LobbyModel>> result = snapshot.data!.data!;
            // final activeLobbies = result['active']!;
            final {'active': activeLobbies, 'pending': pendingLobbies} = result;
            return activeLobbies.length == 0
                ? Text('No active lobbies')
                : WidgetLobby(activeLobbies);
          } else {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(snapshot.data!.message!),
                ),
              ],
            );
          }
        } else
          return Dialog(child: SizedBox.shrink());
      }),
    );
  }

  // Create lobby
  static Future<void> createLobby(
      LobbyModel lobby, BuildContext context) async {
    final appState = Provider.of<FFAppState>(context, listen: false);
    await apiService.createLobby(lobby, appState.currentUser!.id!).then(
      (response) {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(response.message!),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Create message
  static Future<void> createMessage(
      MessageModel message, BuildContext context) async {
    await apiService
        .createMessage(message, _userId, _lobbyId, _conversationId)
        .catchError((error) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text('Message not sent.'),
        ),
      );
    });
  }

  // Get conversation
  static FutureBuilder<ResponseModel<List<MessageModel>>> getConversation() {
    return FutureBuilder(
      future: apiService.getConversation(_userId, _lobbyId, _conversationId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> result = snapshot.data!.data!;
          if (result.isEmpty)
            return Center(
              child: Text('Say hi!'),
            );
          return ListView.separated(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return Text(
                  result[index].creator! + ' ' + result[index].message!);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 10, thickness: 1);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Fetch available cars
  static FutureBuilder<ResponseModel<List<CarModel>>> getAvailableCars(
      Function callback) {
    return FutureBuilder(
      future: apiService.getAvailableCars(_userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.data!.isEmpty)
            return Center(
              child: Text('No available cars for today :('),
            );
          final cars = snapshot.data!.data!;
          double width = MediaQuery.of(context).size.width / 2;
          return GridView.extent(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            maxCrossAxisExtent: width,
            children: List.generate(
              cars.length,
              (i) => CarItemWidget(callback, car: cars[i]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Book a car
  static Future<void> bookCar(String licensePlate) async {
    await apiService
        .bookCar({'licensePlate': licensePlate}, _userId).catchError((error) {
      print(error);
    });
  }

  static Future<void> addBudget(String label, double amount) async {
    await apiService
        .addBudget({'label': label, 'amount': amount}, _userId, _lobbyId);
  }
}
