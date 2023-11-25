import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/modals/invite_participants_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joiners_model.dart';
export 'joiners_model.dart';

class JoinersWidget extends StatefulWidget {
  const JoinersWidget({Key? key}) : super(key: key);

  @override
  _JoinersWidgetState createState() => _JoinersWidgetState();
}

class _JoinersWidgetState extends State<JoinersWidget> {
  late JoinersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JoinersModel());
    _model.currentLobby = context.read<LobbyProvider>().currentLobby;
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.watch<FFAppState>().currentUser!.id!;
    final lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Joiners'),
                FilledButton(
                  child: Text('Invite'),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ListenableProvider.value(
                          value: lobbyProvider,
                          child: InviteParticipantsWidget(),
                        );
                      },
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: _model.getParticipants(currentUserId),
            ),
          ],
        ),
      ),
    );
  }
}
