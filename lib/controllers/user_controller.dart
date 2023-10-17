import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/index.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/widget_lobby.dart';
import 'package:retrofit/dio.dart';

import '../models/user_model.dart';

class UserController {
  static String _userId = '6522a0c73e680ea09ee89d5f';
  static String _lobbyId = '65279f410e8b2ee1b1412372';
  static String _conversationId = '65279f410e8b2ee1b1412375';

  // Login user
  static Future<void> loginUser(UserModel user, BuildContext context) async {
    await apiService.loginUser(user).then((response) {
      if (response.code == HttpStatus.ok) {
        FFAppState().setCurrentUser(response.data!);
        context.goNamed('VirtualLobby', extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.rightToLeft,
          ),
        });
      } else {
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
            });
      }
    });
  }

  // Get user lobbies
  static FutureBuilder<ResponseModel<Map<String, List<LobbyModel>>>>
      userLobbies(String userId) {
    return FutureBuilder(
      future: apiService.getLobby(FFAppState().getCurrentUser().id!),
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
    await apiService.createLobby(lobby, FFAppState().getCurrentUser().id!).then(
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
        return ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 10, bottom: 7, top: 5), 
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue, 
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result[index].message!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
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
}
