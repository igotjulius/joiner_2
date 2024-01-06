import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/friend_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
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
  late List<FriendModel> friendList;
  List<ParticipantModel> invitedFriends = [];

  List<FriendModel> filter(List<FriendModel> friendList) {
    widget.currentLobby.participants?.forEach((participant) {
      friendList.removeWhere((friend) {
        return friend.friendId == participant.userId;
      });
    });

    return friendList;
  }

  void addFriendToInvites(String friendId, String firstName, String lastName) {
    setState(() {});
  }

  void removeFromInvites(String friendId) {
    invitedFriends.removeWhere((element) => element.id == friendId);
    setState(() {});
  }

  void onCheckBoxTap(
      bool value, String friendId, String firstName, String lastName) {
    if (value) {
      invitedFriends.add(new ParticipantModel(
        userId: friendId,
        firstName: firstName,
        lastName: lastName,
        joinStatus: 'Pending',
        type: 'Joiner',
      ));
    } else {
      invitedFriends.removeWhere((element) => element.userId == friendId);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    provider = context.read<UserController>();
    friendList = filter(provider.friends
        .where((element) => element.status == 'Accepted')
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
              child: friendList.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: friendList.length,
                      itemBuilder: (context, index) {
                        return ParticipantMole(
                          firstName: friendList[index].firstName,
                          lastName: friendList[index].lastName,
                          friendUserId: friendList[index].friendId,
                          showCheckBox: true,
                          onCheckBoxTap: onCheckBoxTap,
                        );
                      },
                    )
                  : Center(child: Text('There\'s no one to invite :(')),
            ),
            if (invitedFriends.length > 0)
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
    );
  }
}
