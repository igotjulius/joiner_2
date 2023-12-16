import 'package:joiner_1/pages/user/dashboard/tab_views/poll/modals/survey_poll_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/mole/poll_mole.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'poll_comp_model.dart';
export 'poll_comp_model.dart';

class PollCompWidget extends StatefulWidget {
  final String? lobbyId;
  const PollCompWidget({
    Key? key,
    this.lobbyId,
  });

  @override
  _PollCompWidgetState createState() => _PollCompWidgetState();
}

class _PollCompWidgetState extends State<PollCompWidget> {
  late PollCompModel _model;
  PersistentBottomSheetController? _controller;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollCompModel());
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null) _controller?.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LobbyProvider>();
    _model.polls = provider.polls;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Poll'),
                  FilledButton(
                    child: Text('Create'),
                    onPressed: () {
                      _controller = showBottomSheet(
                        context: context,
                        builder: (context) {
                          return SurveyPollWidget(
                            lobbyId: widget.lobbyId!,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Flexible(
                child: _model.polls == null || _model.polls!.isEmpty
                    ? Center(child: Text('No polls as of the moment.'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _model.polls?.length,
                        itemBuilder: (context, index) {
                          return PollMolecule(
                            lobbyId: widget.lobbyId,
                            index: index,
                          );
                        },
                      ),
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
