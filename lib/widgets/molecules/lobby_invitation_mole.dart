import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/lobby_model.dart';

class LobbyInvitationMolecule extends StatefulWidget {
  final List<LobbyModel>? lobbies;
  const LobbyInvitationMolecule({super.key, this.lobbies});

  @override
  State<LobbyInvitationMolecule> createState() =>
      _LobbyInvitationMoleculeState();
}

class _LobbyInvitationMoleculeState extends State<LobbyInvitationMolecule> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.lobbies!.length,
        itemBuilder: (context, index) {
          final lobby = widget.lobbies![index];
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(
                          color: Colors.blueAccent,
                          Icons.help,
                          size: 50.0,
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invitation To: ${lobby.title}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Start Date: ${lobby.startDate}',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              text: 'Maybe next time',
                              onPressed: () {
                                // UserController.declineLobbyInvitation(
                                //     lobby.id!);
                                setState(() {});
                              },
                              options: FFButtonOptions(
                                color: Colors.blue,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              text: 'Accept',
                              onPressed: () {
                                // UserController.acceptLobbyInvitation(lobby.id!);
                                setState(() {});
                              },
                              options: FFButtonOptions(
                                color: Colors.blue,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
