import 'package:flutter/material.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/modals/invite_participants_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:provider/provider.dart';

class InviteParticipantsWidget extends StatefulWidget {
  const InviteParticipantsWidget({super.key});

  @override
  State<InviteParticipantsWidget> createState() =>
      _InviteParticipantsWidgetState();
}

class _InviteParticipantsWidgetState extends State<InviteParticipantsWidget> {
  late InviteParticipantsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InviteParticipantsModel());
    _model.participants = context.read<LobbyProvider>().participants;
    _model.invitedFriends = [];
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
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
                child: _model.friendList(context),
              ),
              FilledButton(
                child: Text('Invite'),
                onPressed: () {
                  _model.sendInvitation(context.read<LobbyProvider>().lobbyId);
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
