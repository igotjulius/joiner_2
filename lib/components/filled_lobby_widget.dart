import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/widget_lobby.dart';

import '../models/lobby_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filled_lobby_model.dart';
export 'filled_lobby_model.dart';

class FilledLobbyWidget extends StatefulWidget {
  const FilledLobbyWidget({Key? key}) : super(key: key);

  @override
  _FilledLobbyWidgetState createState() => _FilledLobbyWidgetState();
}

class _FilledLobbyWidgetState extends State<FilledLobbyWidget> {
  late FilledLobbyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilledLobbyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
        child: _getLobby(),
      ),
    );
  }

  FutureBuilder<List<LobbyModel>> _getLobby() {
    return FutureBuilder(
      future: apiService.getLobby(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<LobbyModel> lobbies = snapshot.data!;
          return WidgetLobby(lobbies);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
