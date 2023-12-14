import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'invite_friend_model.dart';
export 'invite_friend_model.dart';

class InviteFriendWidget extends StatefulWidget {
  const InviteFriendWidget({Key? key}) : super(key: key);

  @override
  _InviteFriendWidgetState createState() => _InviteFriendWidgetState();
}

class _InviteFriendWidgetState extends State<InviteFriendWidget> {
  late InviteFriendModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InviteFriendModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Text(
              'Invite your friend by sending an email to them.',
            ),
            CustomTextInput(
              label: 'Enter your friend\'s email',
              controller: _model.textController,
              hintText: 'Your friend\'s email..',
            ),
            FilledButton(
              onPressed: () async {
                await UserController.inviteFriend(_model.textController.text);
                context.pop();
              },
              child: Text('Send friend request'),
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
