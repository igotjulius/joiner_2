import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/invite_participants_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';

class InviteParticipantsWidget extends StatefulWidget {
  final String? lobbyId;
  final List<ParticipantModel>? participants;
  final Function(Function())? rebuildParent;
  const InviteParticipantsWidget(
      {super.key, this.participants, this.lobbyId, this.rebuildParent});

  @override
  State<InviteParticipantsWidget> createState() =>
      _InviteParticipantsWidgetState();
}

class _InviteParticipantsWidgetState extends State<InviteParticipantsWidget> {
  late InviteParticipantsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(
        context, () => InviteParticipantsModel(lobbyId: widget.lobbyId));
    _model.participants = widget.participants!;
    _model.rebuildParent = widget.rebuildParent;
    _model.invitedFriends = [];
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Friends'),
                FFButtonWidget(
                    text: 'Invite',
                    onPressed: () {
                      _model.sendInvitation();
                      widget.rebuildParent!(() {});
                      setState(() {});
                      context.pop();
                    },
                    options: FFButtonOptions(height: 40)),
              ],
            ),
            _model.friendList(context),
          ],
        ),
      ),
    );
  }
}
