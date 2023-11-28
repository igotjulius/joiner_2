import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class JoinersModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  bool checkboxVal = false;
  List<ParticipantModel>? participants;
  LobbyModel? currentLobby;
  Future<List<ParticipantModel>>? fetchParticipants;

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  FutureBuilder<List<ParticipantModel>> getParticipants(String currentUserId) {
    return FutureBuilder(
      future: fetchParticipants,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );

        participants = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: participants!.length,
          itemBuilder: (context, index) {
            bool showRemove = currentUserId == currentLobby?.hostId &&
                currentLobby?.hostId != participants?[index].userId;
            return ParticipantMole(
              firstName: participants?[index].firstName,
              lastName: participants?[index].lastName,
              userId: participants?[index].id,
              suffixLabel: participants?[index].joinStatus,
              showRemoveOption: showRemove,
              rebuildParent: updatePage,
            );
          },
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
