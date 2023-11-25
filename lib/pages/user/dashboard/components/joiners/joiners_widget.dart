import 'package:joiner_1/pages/user/dashboard/components/joiners/modals/invite_participants_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/lobby_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joiners_model.dart';
export 'joiners_model.dart';

class JoinersWidget extends StatefulWidget {
  final String? lobbyId;
  const JoinersWidget(this.lobbyId, {Key? key}) : super(key: key);

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
    _model.currentLobby = Provider.of<LobbyModel>(context, listen: false);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Joiners'),
                  FFButtonWidget(
                    text: 'INVITE',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InviteParticipantsWidget(
                            participants: _model.participants,
                            lobbyId: widget.lobbyId,
                            rebuildParent: _model.updatePage,
                          );
                        },
                      );
                      setState(() {});
                    },
                    options: FFButtonOptions(height: 40),
                  ),
                ],
              ),
              _model.getParticipants(widget.lobbyId!),
            ],
          ),
        ),
      ),
    );
  }
}
