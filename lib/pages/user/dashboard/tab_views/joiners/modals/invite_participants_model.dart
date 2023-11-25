import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import 'package:joiner_1/models/participant_model.dart';

class InviteParticipantsModel extends FlutterFlowModel {
  List<ParticipantModel>? invitedFriends;
  List<ParticipantModel>? participants;

  @override
  void dispose() {}

  @override
  void initState(BuildContext context) {}

  FutureBuilder<ResponseModel<List<Map<String, String>>>?> friendList(
      BuildContext context) {
    return FutureBuilder(
      future: UserController.getFriends(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        final result = snapshot.data!.data;
        if (result == null)
          return Center(
            child: Text('Add your friends here'),
          );

        List<Map<String, String>> friends = [];
        result.forEach(
          (element) {
            if (element['status'] == 'Accepted') friends.add(element);
          },
        );
        friends = filter(friends);

        return ListView.builder(
          shrinkWrap: true,
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return ParticipantMole(
              firstName: friends[index]['firstName'],
              lastName: friends[index]['lastName'],
              userId: friends[index]['friendId'],
              showCheckBox: true,
              eventCallback: addFriendToInvites,
            );
          },
        );
      },
    );
  }

  List<Map<String, String>> filter(List<Map<String, String>> friends) {
    participants!.forEach((participant) {
      friends.removeWhere((friend) {
        return friend['friendId'] == participant.userId;
      });
    });

    return friends;
  }

  void addFriendToInvites(String friendId, String firstName, String lastName) {
    invitedFriends!.add(new ParticipantModel(
        userId: friendId, firstName: firstName, lastName: lastName));
  }

  void sendInvitation(String lobbyId) async {
    await UserController.inviteParticipants(invitedFriends!, lobbyId);
  }
}
