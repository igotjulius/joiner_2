import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/lobby_model.dart';

class ActiveLobbyMolecule extends StatelessWidget {
  ActiveLobbyMolecule(this.lobbies, {super.key});
  late final List<LobbyModel> lobbies;

  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: lobbies.length,
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onLongPress: () async {
              showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: Text('Delete'),
                      content:
                          Text('Are you sure you want to cancel this trip?'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await UserController.deleteLobby(
                                lobbies[index].id!);
                            showSnackbar(context, 'Lobby Deleted');
                            context.pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    )),
              );
            },
            onTap: () {
              context.pushNamed(
                'Lobby',
                pathParameters: {'lobbyId': lobbies[index].id!},
                extra: <String, dynamic>{
                  'currentLobby': lobbies[index],
                },
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).accent3,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/lambug-beach-badian.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lobbies[index].title!,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Flex',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              lobbies[index].startDate != null
                                  ? "${dateFormat.format(lobbies[index].startDate!)} - ${dateFormat.format(lobbies[index].endDate!)}"
                                  : '-',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Flex',
                                    color: FlutterFlowTheme.of(context).accent4,
                                    fontSize: 12.0,
                                  ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
