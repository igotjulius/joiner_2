import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/lobby_model.dart';

class PendingLobbyMolecule extends StatefulWidget {
  final List<LobbyModel>? lobbies;
  const PendingLobbyMolecule({super.key, this.lobbies});

  @override
  State<PendingLobbyMolecule> createState() => _PendingLobbyMoleculeState();
}

class _PendingLobbyMoleculeState extends State<PendingLobbyMolecule> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.lobbies!.length,
      itemBuilder: (context, index) {
        final lobby = widget.lobbies![index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.question_mark),
                  Column(
                    children: [
                      Text(lobby.title!),
                      Text(
                        lobby.startDate != null
                            ? "${lobby.startDate} - ${lobby.endDate}"
                            : "Undecided",
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  FFButtonWidget(
                    text: 'Maybe next time',
                    onPressed: () async {
                      UserController.declineLobbyInvitation(lobby.id!);
                    },
                    options: FFButtonOptions(height: 40),
                  ),
                  FFButtonWidget(
                    text: 'Join',
                    onPressed: () async {
                      UserController.acceptLobbyInvitation(lobby.id!);
                    },
                    options: FFButtonOptions(height: 40),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
