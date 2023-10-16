import 'package:joiner_1/components/user/budget_graph_widget.dart';
import 'package:joiner_1/components/user/chat_widget.dart';
import 'package:joiner_1/components/user/joiners_widget.dart';
import 'package:joiner_1/components/user/poll_widget.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'participants_model.dart';
export 'participants_model.dart';

class ParticipantsWidget extends StatefulWidget {
  const ParticipantsWidget({Key? key}) : super(key: key);

  @override
  _ParticipantsWidgetState createState() => _ParticipantsWidgetState();
}

class _ParticipantsWidgetState extends State<ParticipantsWidget>
    with TickerProviderStateMixin {
  late ParticipantsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ParticipantsModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
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
                      'Trip to Lambug Beach',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                    ),
                    Text(
                      'Planned Date: Jul 30',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Roboto Flex',
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                    ),
                  ],
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/Vector.png',
                        width: 4.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
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
                              child: ChatWidget(setState),
                            ),
                            wrapWithModel(
                              model: _model.budgetGraphModel,
                              updateCallback: () => setState(() {}),
                              child: BudgetGraphWidget(),
                            ),
                            wrapWithModel(
                              model: _model.pollModel,
                              updateCallback: () => setState(() {}),
                              child: PollWidget(),
                            ),
                            wrapWithModel(
                              model: _model.joinersModel,
                              updateCallback: () => setState(() {}),
                              child: JoinersWidget(),
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
      ),
    );
  }
}
