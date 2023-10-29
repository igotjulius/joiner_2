import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/lobby_dashboard_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class LobbyDashboardWidget extends StatefulWidget {
  final String? lobbyId;
  const LobbyDashboardWidget({super.key, this.lobbyId});

  @override
  State<LobbyDashboardWidget> createState() => _LobbyDashboardWidgetState();
}

class _LobbyDashboardWidgetState extends State<LobbyDashboardWidget> {
  late LobbyDashboardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyDashboardModel());
    _model.fetchLobby(widget.lobbyId!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: _model.currentLobby == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_model.currentLobby?.title}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Host: Peter Parker'),
                    Text('Meeting place: LLC'),
                  ],
                ),
                Divider(),
                Text('Details'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Meeting Place'),
                            Text('LLC'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Meeting Time'),
                            Text('9:00 AM'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Destination'),
                            Text('Moalboal Cebu'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Planned Date'),
                            Text('Oct. 1, 2023'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Budget'),
                            Text('Min. 100 / person'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
            ),
    );
  }
}
