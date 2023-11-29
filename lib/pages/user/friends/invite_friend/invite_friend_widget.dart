import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'invite_friend_model.dart';
export 'invite_friend_model.dart';

class InviteFriendWidget extends StatefulWidget {
  final void Function(Function())? parentSetState;
  const InviteFriendWidget({Key? key, this.parentSetState}) : super(key: key);

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
    context.watch<FFAppState>();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Invite your friend by sending an email to them.',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your friend\'s email',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 4,
                ),
                CustomTextInput(
                  controller: _model.textController,
                  hintText: 'Your friend\'s email..',
                ),
              ],
            ),
            FilledButton(
              onPressed: () async {
                await UserController.inviteFriend(_model.textController.text);
                widget.parentSetState!(() {});
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
