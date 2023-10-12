import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/index.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/widget_lobby.dart';
import 'package:retrofit/dio.dart';

import '../models/user_model.dart';

class UserController {
  static Future<void> loginUser(UserModel user, BuildContext context) async {
    await apiService.loginUser(user).then((response) {
      if (response.data.code == HttpStatus.ok) {
        FFAppState().setCurrentUser(response.data.data!);
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
                      child: Text(response.data.message!),
                    ),
                  ],
                ),
              );
            });
      }
    });
  }

  static FutureBuilder<
          HttpResponse<ResponseModel<Map<String, List<LobbyModel>>>>>
      userLobbies(String userId) {
    return FutureBuilder(
      future: apiService.getLobby(FFAppState().getCurrentUser().id!),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.data.code == HttpStatus.ok) {
            final Map<String, List<LobbyModel>> result =
                snapshot.data!.data.data!;
            // final activeLobbies = result['active']!;
            final {'active': activeLobbies, 'pending': pendingLobbies} = result;
            print(result);
            return activeLobbies.length == 0
                ? Text('No active lobbies')
                : WidgetLobby(activeLobbies);
          } else {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(snapshot.data!.data.message!),
                ),
              ],
            );
          }
        } else
          return Dialog(child: SizedBox.shrink());
      }),
    );
  }
}
