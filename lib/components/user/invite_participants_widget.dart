import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/invite_participants_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';

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
            // FriendsAtom(),
            _model.friendList(),
          ],
        ),
      ),
    );
  }
}
