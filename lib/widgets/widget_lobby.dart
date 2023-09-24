import 'package:flutter/material.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/service/api_service.dart';
import '../flutter_flow/flutter_flow_util.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class WidgetLobby extends StatelessWidget {
  WidgetLobby(this.lobbies, {super.key});
  late List<LobbyModel> lobbies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
                            // await showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return _deleteLobby(lobbies[index].id!);
                            //   },
                            // );
                            // _deleteLobby(lobbies[index].id!);
                            Navigator.pop(context);
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
            onTap: () async {
              context.pushNamed(
                'Lobby',
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                  ),
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
                              //'Trip to Lambug Beach',
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
                              //'Planned Date: Jul 30',
                              lobbies[index].plannedDate!,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '4 new messages',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                        Icon(
                          Icons.circle_rounded,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 16.0,
                        ),
                      ],
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

  // FutureBuilder _deleteLobby(String lobbyId) {
  //   return FutureBuilder(
  //     future: apiService.deleteLobby(LobbyModel(id: lobbyId)),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return Dialog(
  //           child: Text('Trip cancelled.'),
  //         );
  //       } else {
  //         return Dialog(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }
}
