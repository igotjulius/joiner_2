import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:provider/provider.dart';

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
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.lobbies!.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        final lobby = widget.lobbies![index];
        return Material(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    width: 8, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(
                          color: Theme.of(context).colorScheme.secondary,
                          Icons.info_rounded,
                          size: 48,
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
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  'Planned Date: ${lobby.startDate ?? ''} - ${lobby.endDate ?? ''}',
                                  style: Theme.of(context).textTheme.titleSmall,
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
                            TextButton(
                              child: Text('Maybe next time'),
                              onPressed: () {
                                (context.read<Auth>() as UserController)
                                    .declineLobbyInvitation(lobby.id!);
                              },
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
                            FilledButton(
                              child: Text('Accept'),
                              onPressed: () {
                                (context.read<Auth>() as UserController)
                                    .acceptLobbyInvitation(lobby.id!);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
