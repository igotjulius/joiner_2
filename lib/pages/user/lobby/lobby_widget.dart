import 'package:joiner_1/components/user/budget_graph_widget.dart';
import 'package:joiner_1/components/user/chat_widget.dart';
import 'package:joiner_1/components/user/joiners_widget.dart';
import 'package:joiner_1/components/user/poll_widget.dart';
import 'package:joiner_1/widgets/molecules/widget_trip_details.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lobby_model.dart';
import 'package:joiner_1/models/lobby_model.dart' as ModelLobby;
export 'lobby_model.dart';

class LobbyWidget extends StatefulWidget {
  final ModelLobby.LobbyModel? currentLobby;
  LobbyWidget({Key? key, this.currentLobby}) : super(key: key);

  @override
  _LobbyWidgetState createState() => _LobbyWidgetState();
}

class _LobbyWidgetState extends State<LobbyWidget>
    with TickerProviderStateMixin {
  late LobbyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );
    if (widget.currentLobby == null) {
      _model.currentLobby = new ModelLobby.LobbyModel(
        title: 'Mock',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        budget: {
          'Gas': 1000,
          'Food': 1000,
        },
      );
    } else
      _model.currentLobby = widget.currentLobby!;
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Container(
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _model.currentLobby.title!,
                      // 'Title: ',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                    ),
                    Text(
                      _model.currentLobby.startDate ==
                              _model.currentLobby.endDate
                          ? (_model.currentLobby.startDate == null
                              ? 'Date undecided'
                              : "${_model.currentLobby.startDate.toString()}")
                          : "${_model.currentLobby.startDate.toString()} - ${_model.currentLobby.endDate.toString()}",
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
                Spacer(
                  flex: 1,
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/Vector.png',
                    width: 4.0,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Wrap(children: [
                          WidgetTripDetails(
                            currentLobby: widget.currentLobby!,
                          )
                        ]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
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
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: TabBar(
                        labelColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Open Sans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                        unselectedLabelStyle: TextStyle(),
                        indicatorColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        tabs: [
                          Tab(
                            text: 'Chat',
                          ),
                          Tab(
                            text: 'Resources',
                          ),
                          Tab(
                            text: 'Poll',
                          ),
                          Tab(
                            text: 'Joiners',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (value) => setState(() {}),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          wrapWithModel(
                            model: _model.chatModel,
                            updateCallback: () => setState(() {}),
                            child: ChatWidget(setState, _model.currentLobby.id,
                                _model.currentLobby.conversation),
                          ),
                          wrapWithModel(
                            model: _model.budgetGraphModel,
                            updateCallback: () => setState(() {}),
                            child: BudgetGraphWidget(
                              budget: _model.currentLobby.budget,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.pollModel,
                            updateCallback: () => setState(() {}),
                            child: PollWidget(_model.currentLobby.id),
                          ),
                          wrapWithModel(
                            model: _model.joinersModel,
                            updateCallback: () => setState(() {}),
                            child: JoinersWidget(widget.currentLobby!.id),
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
}
