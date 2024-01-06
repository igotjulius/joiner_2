import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/modals/survey_poll_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/mole/poll_mole.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';
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
    var polls;
    (context.watch<Auth?>() as UserController).activeLobbies.forEach((element) {
      if (element.id == widget.currentLobbyId) polls = element.poll;
      return;
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Poll'),
                ],
              ),
              polls == null || polls.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.not_interested,
                                size: 48.0,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.poll,
                                size: 48.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text('No widget polls as of the moment.'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: polls.length,
                      itemBuilder: (context, index) {
                        return PollMolecule(
                          poll: polls[index],
                          lobbyId: widget.currentLobbyId,
                        );
                      },
                    ),
              SizedBox(height: 64),
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
