import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class JoinersModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  bool checkboxVal = false;
  List<ParticipantModel>? participants;
  LobbyModel? currentLobby;

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  FutureBuilder<ResponseModel<List<ParticipantModel>>> getParticipants(
      String currentUserId) {
    return FutureBuilder(
      future: UserController.getParticipants(currentLobby!.id!),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        participants = snapshot.data!.data;
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
