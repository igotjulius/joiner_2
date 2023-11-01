import 'package:joiner_1/components/user/survey_poll_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/widgets/molecules/poll_mole.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'poll_item_model.dart';
export 'poll_item_model.dart';

class PollItemWidget extends StatefulWidget {
  final String? lobbyId;
  final List<PollModel>? polls;
  const PollItemWidget({
    Key? key,
    this.lobbyId,
    this.polls,
  });

  @override
  _PollItemWidgetState createState() => _PollItemWidgetState();
}

class _PollItemWidgetState extends State<PollItemWidget> {
  late PollItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollItemModel());
    _model.pollStateNotifier =
        PollStateNotifier(lobbyId: widget.lobbyId, polls: widget.polls);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return ChangeNotifierProvider.value(
        value: _model.pollStateNotifier,
        builder: (context, child) {
          context.watch<PollStateNotifier>();
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
                        onPressed: () {
                          showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return SurveyPollWidget(lobbyId: widget.lobbyId!);
                            },
                          ).then(
                              (value) => _model.pollStateNotifier?.getPoll());
                        },
                      ),
                    ],
                  ),
                  Flexible(
                    child: _model.pollStateNotifier?.polls == null ||
                            _model.pollStateNotifier!.polls!.isEmpty
                        ? Text('empty')
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _model.pollStateNotifier!.polls?.length,
                            itemBuilder: (context, index) {
                              return PollMolecule(
                                poll: _model.pollStateNotifier!.polls?[index],
                                lobbyId: _model.pollStateNotifier?.lobbyId,
                                index: index,
                              );
                            },
                          ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          );
        });
  }
}
