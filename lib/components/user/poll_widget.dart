import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'poll_model.dart';
export 'poll_model.dart';

class PollWidget extends StatefulWidget {
  final String? lobbyId;
  const PollWidget(
    this.lobbyId, {
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
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Poll'),
                FFButtonWidget(
                  text: 'Add',
                  options: FFButtonOptions(height: 40),
                  onPressed: () async {
                    _model.addPoll(context, setState, widget.lobbyId!);
                  },
                ),
              ],
            ),
            Flexible(child: _model.getPoll(setState, widget.lobbyId!)),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
