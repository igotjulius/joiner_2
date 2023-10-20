import 'package:joiner_1/components/user/invite_participants_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                      builder: (context) => InviteParticipantsWidget(),
                    );
                  },
                  options: FFButtonOptions(height: 40),
                ),
              ],
            ),
            _model.getParticipants(widget.lobbyId!),
          ],
        ),
      ),
    );
  }
}
