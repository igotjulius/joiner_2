import 'package:joiner_1/components/user/budget_widget.dart';
import 'package:joiner_1/components/user/chat_widget.dart';
import 'package:joiner_1/components/user/joiners_widget.dart';
import 'package:joiner_1/components/user/lobby_dashboard.dart';
import 'package:joiner_1/components/user/poll_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lobby_model.dart';
import 'package:joiner_1/models/lobby_model.dart' as ModelLobby;
export 'lobby_model.dart';

class LobbyWidget extends StatefulWidget {
  final ModelLobby.LobbyModel? currentLobby;
  final String? lobbyId;

  LobbyWidget({Key? key, this.currentLobby, this.lobbyId}) : super(key: key);

  @override
  _LobbyWidgetState createState() => _LobbyWidgetState();
}

final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

class _LobbyWidgetState extends State<LobbyWidget>
    with TickerProviderStateMixin {
  late LobbyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyModel());
    _model.currentLobby = widget.currentLobby;
    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return fetchLobby();
  }

  Widget mainDisplay() {
    return Provider<ModelLobby.LobbyModel>(
      create: (_) => _model.currentLobby!,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _model.currentLobby!.title!,
                      // 'Title: ',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                    ),
                    Text(
                      _model.currentLobby!.startDate ==
                              _model.currentLobby!.endDate
                          ? (_model.currentLobby!.startDate == null
                              ? 'Date undecided'
                              : "${_model.currentLobby!.startDate.toString()}")
                          : "${_model.currentLobby!.startDate.toString()} - ${_model.currentLobby!.endDate.toString()}",
                      //'Date',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Roboto Flex',
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            menuOption(),
          ],
          centerTitle: false,
          elevation: 0.0,
          bottom: TabBar(
            // isScrollable: true,
            labelColor: FlutterFlowTheme.of(context).secondaryBackground,
            unselectedLabelColor:
                FlutterFlowTheme.of(context).primaryBackground,
            labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
            unselectedLabelStyle: TextStyle(),
            indicatorColor: FlutterFlowTheme.of(context).secondaryBackground,
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Chat'),
              Tab(text: 'Resources'),
              Tab(text: 'Poll'),
              Tab(text: 'Joiners'),
            ],
            controller: _model.tabBarController,
            onTap: (value) => setState(() {}),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF52B2FA),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          wrapWithModel(
                            model: _model.lobbyDashboardModel,
                            child: LobbyDashboardWidget(
                              lobbyId: widget.lobbyId,
                            ),
                            updateCallback: () => setState(() {}),
                          ),
                          wrapWithModel(
                            model: _model.chatModel,
                            updateCallback: () => setState(() {}),
                            child: ChatWidget(
                              setState,
                              _model.currentLobby!.id,
                              _model.currentLobby!.conversation,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.budgetGraphModel,
                            updateCallback: () => setState(() {}),
                            child: BudgetWidget(
                              lobbyId: widget.lobbyId,
                              budget: _model.currentLobby!.budget,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.pollModel,
                            updateCallback: () => setState(() {}),
                            child: PollItemWidget(
                              lobbyId: _model.currentLobby!.id,
                              polls: _model.currentLobby!.poll,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.joinersModel,
                            updateCallback: () => setState(() {}),
                            child: JoinersWidget(_model.currentLobby!.id),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<ModelLobby.LobbyModel?> fetchLobby() {
    return FutureBuilder(
      future: _model.fetchLobby(widget.lobbyId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        _model.currentLobby = snapshot.data;
        return mainDisplay();
      },
    );
  }

  PopupMenuButton menuOption() {
    return PopupMenuButton<int>(
      onSelected: (value) {
        switch (value) {
          case 0:
            {
              _model.leaveLobby(widget.lobbyId!);
              setState(() {});
              context.pop();
            }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text('Leave lobby'),
        ),
      ],
    );
  }
}
