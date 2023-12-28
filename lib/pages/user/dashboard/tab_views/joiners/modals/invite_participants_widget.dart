import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import 'package:provider/provider.dart';

class InviteParticipantsWidget extends StatefulWidget {
  final LobbyModel currentLobby;
  const InviteParticipantsWidget({super.key, required this.currentLobby});

  @override
  State<InviteParticipantsWidget> createState() =>
      _InviteParticipantsWidgetState();
}

class _InviteParticipantsWidgetState extends State<InviteParticipantsWidget> {
  late UserController provider;
  late List<Map<String, String>> friendList;
  List<ParticipantModel> invitedFriends = [];

  List<Map<String, String>> filter(List<Map<String, String>> friendList) {
    widget.currentLobby.participants?.forEach((participant) {
      friendList.removeWhere((friend) {
        return friend['friendId'] == participant.userId;
      });
    });

    return friendList;
  }

  void addFriendToInvites(String friendId, String firstName, String lastName) {
    invitedFriends.add(new ParticipantModel(
      userId: friendId,
      firstName: firstName,
      lastName: lastName,
      joinStatus: 'Pending',
      type: 'Joiner',
    ));
  }

  @override
  void initState() {
    super.initState();
    provider = context.read<UserController>();
    friendList = filter(provider.friends);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invite your friends'),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendList.length,
                  itemBuilder: (context, index) {
                    return ParticipantMole(
                      firstName: friendList[index]['firstName']!,
                      lastName: friendList[index]['lastName']!,
                      friendUserId: friendList[index]['friendId']!,
                      showCheckBox: true,
                      addFriendToInvite: addFriendToInvites,
                    );
                  },
                ),
              ),
              FilledButton(
                child: Text('Invite'),
                onPressed: () {
                  showDialogLoading(context);
                  provider
                      .inviteParticipants(
                          invitedFriends, widget.currentLobby.id!)
                      .then((value) {
                    context.pop();
                    if (!value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showError('Invitation failed',
                            Theme.of(context).colorScheme.error),
                      );
                    }
                  });
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
