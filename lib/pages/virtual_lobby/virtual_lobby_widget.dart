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

class _VirtualLobbyWidgetState extends State<VirtualLobbyWidget>
    with TickerProviderStateMixin {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('LobbyCreation', extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.rightToLeft,
                ),
              });
            },
            child: const Icon(
              Icons.add,
              size: 32,
            ),
          ),
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Column(children: [
              Align(
                alignment: Alignment(0, 0),
                child: TabBar(
                  labelColor: FlutterFlowTheme.of(context).secondaryBackground,
                  unselectedLabelColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Open Sans',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                  unselectedLabelStyle: TextStyle(),
                  indicatorColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  tabs: [
                    Tab(
                      text: 'Lobby',
                    ),
                    Tab(
                      text: 'Discover trips',
                    ),
                  ],
                  controller:
                      TabController(length: 2, vsync: this, initialIndex: 0),
                  // create a local tabcontroller
                  onTap: (value) => setState(() {}),
                ),
              ),
            ]),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
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
