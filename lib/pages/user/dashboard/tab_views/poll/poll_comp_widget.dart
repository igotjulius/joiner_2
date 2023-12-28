import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/modals/survey_poll_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/mole/poll_mole.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PollCompWidget extends StatefulWidget {
  final String currentLobbyId;
  final FabController fabController;
  final PollCompModel model;
  final List<PollModel> polls;
  const PollCompWidget({
    super.key,
    required this.currentLobbyId,
    required this.fabController,
    required this.model,
    required this.polls,
  });

  @override
  _PollCompWidgetState createState() => _PollCompWidgetState();
}

class _PollCompWidgetState extends State<PollCompWidget> {
  @override
  void initState() {
    super.initState();
    widget.fabController.onTapHandler = fabHandler;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.model.controller != null) widget.model.controller?.close();
    });
  }

  void fabHandler() {
    widget.model.controller = showBottomSheet(
      context: context,
      builder: (context) {
        return SurveyPollWidget(lobbyId: widget.currentLobbyId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final polls = (context.watch<Auth>() as UserController)
        .activeLobbies
        .firstWhere((element) => element.id == widget.currentLobbyId)
        .poll;
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
                child: polls!.isEmpty
                    ? Center(child: Text('No widget.polls as of the moment.'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: polls.length,
                        itemBuilder: (context, index) {
                          return PollMolecule(
                            poll: polls[index],
                            lobbyId: widget.currentLobbyId,
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
  PersistentBottomSheetController? controller;
}
