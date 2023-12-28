import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/modals/invite_participants_widget.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import 'package:provider/provider.dart';

class JoinersWidget extends StatefulWidget {
  final FabController fabController;
  final LobbyModel currentLobby;
  final JoinersModel model;
  const JoinersWidget({
    super.key,
    required this.fabController,
    required this.currentLobby,
    required this.model,
  });

  @override
  _JoinersWidgetState createState() => _JoinersWidgetState();
}

class _JoinersWidgetState extends State<JoinersWidget> {
  late UserController provider;

  void fabHandler() {
    widget.model.controller = showBottomSheet(
      context: context,
      builder: (context) {
        return ListenableProvider<UserController>.value(
          value: provider,
          child: InviteParticipantsWidget(currentLobby: widget.currentLobby),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    provider = context.read<Auth>() as UserController;
    widget.fabController.onTapHandler = fabHandler;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.model.controller != null) widget.model.controller?.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = provider.profile?.id;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Joiners'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.currentLobby.participants?.length,
                itemBuilder: (context, index) {
                  bool showRemove =
                      currentUserId == widget.currentLobby.hostId &&
                          widget.currentLobby.hostId !=
                              widget.currentLobby.participants?[index].userId;
                  return ParticipantMole(
                    firstName:
                        widget.currentLobby.participants![index].firstName!,
                    lastName:
                        widget.currentLobby.participants![index].lastName!,
                    friendUserId: widget.currentLobby.participants![index].id!,
                    lobbyId: widget.currentLobby.id,
                    suffixLabel:
                        widget.currentLobby.participants?[index].joinStatus,
                    showRemoveOption: showRemove,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinersModel {
  PersistentBottomSheetController? controller;
}
