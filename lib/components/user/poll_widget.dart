import 'package:joiner_1/controllers/user_controller.dart';
import '/components/user/survey_poll_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'poll_model.dart';
export 'poll_model.dart';

class PollWidget extends StatefulWidget {
  final String? lobbyId;
  const PollWidget(this.lobbyId,{
    Key? key,
    this.index,
  }) : super(key: key);

  final Color? index;

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  late PollModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(child: UserController.getPoll(setState, widget.lobbyId!)),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.0, 1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 20.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 50.0,
              borderWidth: 1.0,
              buttonSize: 52.0,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 40.0,
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SurveyPollWidget(setState, widget.lobbyId);
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}
