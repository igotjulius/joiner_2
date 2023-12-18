import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/modals/survey_poll_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/mole/poll_mole.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollCompWidget extends StatefulWidget {
  final String? lobbyId;
  final FabController? fabController;
  final PollCompModel? model;
  const PollCompWidget(
    this.lobbyId,
    this.fabController,
    this.model, {
    Key? key,
  });

  @override
  _PollCompWidgetState createState() =>
      _PollCompWidgetState(fabController!, model!);
}

class _PollCompWidgetState extends State<PollCompWidget> {
  _PollCompWidgetState(FabController fabController, PollCompModel model) {
    fabController.onTapHandler = fabHandler;
    _model = model;
  }
  late PollCompModel _model;

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.controller != null) _model.controller?.close();
    });
  }

  void fabHandler() {
    _model.controller = showBottomSheet(
      context: context,
      builder: (context) {
        return SurveyPollWidget(
          lobbyId: widget.lobbyId!,
        );
      },
    );
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Poll'),
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

class PollCompModel {
  List<PollModel>? polls;
  PersistentBottomSheetController? controller;
  void dispose() {}
}
