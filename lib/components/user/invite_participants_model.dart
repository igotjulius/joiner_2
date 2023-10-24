import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/atoms/participant_atom.dart';
import 'package:joiner_1/models/participant_model.dart';

class InviteParticipantsModel extends FlutterFlowModel {
  List<ParticipantModel>? invitedFriends;
  final String? lobbyId;

  InviteParticipantsModel({this.lobbyId});

  @override
  void dispose() {}

  @override
  void initState(BuildContext context) {
    invitedFriends = [];
  }

  FutureBuilder<ResponseModel<List<Map<String, String>>>?> friendList() {
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Friends'),
                FFButtonWidget(
                    text: 'Invite',
                    onPressed: () {
                      sendInvitation();
                    },
                    options: FFButtonOptions(height: 40)),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ParticipantAtom(
                  name: friends[index]['friendName'],
                  friendId: friends[index]['friendId'],
                  showCheckBox: true,
                  eventCallback: addFriendToInvites,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void addFriendToInvites(String friendId, String name) {
    invitedFriends!.add(new ParticipantModel(
      userId: friendId,
      name: name,
    ));
  }

  void sendInvitation() async {
    await UserController.inviteParticipants(invitedFriends!, lobbyId!);
  }
}
