import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/widgets/molecules/active_lobby_mole.dart';
import 'package:joiner_1/widgets/molecules/lobby_invitation_mole.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LobbiesModel extends FlutterFlowModel {

  TabController? tabController;
  ///  State fields for stateful widgets in this page.

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  // Fetch user lobbies
  FutureBuilder getUserLobbies() {
    return FutureBuilder(
      future: UserController.getLobbies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Map<String, List<LobbyModel>> result = snapshot.data!.data!;
          // final activeLobbies = result['active']!;
          final {'active': activeLobbies, 'pending': pendingLobbies} = result;

          return SingleChildScrollView(
            child: Column(
              children: [
                if (pendingLobbies.length != 0)
                  Column(
                    children: [
                      Text('Invitations'),
                      LobbyInvitationMolecule(lobbies: pendingLobbies),
                    ],
                  ),
                Column(
                  children: [
                    activeLobbies.length == 0
                        ? Text('No active lobbies')
                        : ActiveLobbyMolecule(activeLobbies),
                  ],
                ),
              ],
            ),
          );
        }
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  /// Additional helper methods are added here.
}
