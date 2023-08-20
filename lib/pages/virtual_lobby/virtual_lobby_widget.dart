import '/components/empty_lobby_widget.dart';
import '/components/filled_lobby_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'virtual_lobby_model.dart';
export 'virtual_lobby_model.dart';

class VirtualLobbyWidget extends StatefulWidget {
  const VirtualLobbyWidget({Key? key}) : super(key: key);

  @override
  _VirtualLobbyWidgetState createState() => _VirtualLobbyWidgetState();
}

class _VirtualLobbyWidgetState extends State<VirtualLobbyWidget> {
  late VirtualLobbyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VirtualLobbyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'Travel Lobby',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (FFAppState().isLobbyEmpty)
                  Expanded(
                    child: wrapWithModel(
                      model: _model.emptyLobbyModel,
                      updateCallback: () => setState(() {}),
                      child: EmptyLobbyWidget(),
                    ),
                  ),
                if (!FFAppState().isLobbyEmpty)
                  Expanded(
                    child: wrapWithModel(
                      model: _model.filledLobbyModel,
                      updateCallback: () => setState(() {}),
                      child: FilledLobbyWidget(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
