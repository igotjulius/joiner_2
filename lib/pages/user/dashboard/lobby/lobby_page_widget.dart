import 'package:joiner_1/components/user/budget_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/joiners_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/lobby_dashboard/lobby_dashboard.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/poll_comp_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/chat/chat_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lobby_page_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
export 'lobby_page_model.dart';

class LobbyPageWidget extends StatefulWidget {
  final LobbyModel? currentLobby;
  final String? lobbyId;

  LobbyPageWidget({Key? key, this.currentLobby, this.lobbyId})
      : super(key: key);

  @override
  _LobbyPageWidgetState createState() => _LobbyPageWidgetState();
}

final DateFormat dateFormat = DateFormat('MMMM dd');

class _LobbyPageWidgetState extends State<LobbyPageWidget>
    with TickerProviderStateMixin {
  late LobbyPageModel _model;
  Future<LobbyModel?>? _fetchLobby;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyPageModel());
    _model.initModel();
    _model.currentLobby = widget.currentLobby;
    _fetchLobby = UserController.getLobby(widget.lobbyId!);
    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _model.tabBarController?.addListener(() {
      if (_model.tabBarController!.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model.currentLobby = context.watch<LobbyProvider>().currentLobby;
    if (_model.currentLobby == null)
      return displayLobby();
    else
      return mainDisplay();
  }

  Widget mainDisplay() {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    _model.currentLobby!.startDate ==
                            _model.currentLobby!.endDate
                        ? (_model.currentLobby!.startDate == null
                            ? 'Date undecided'
                            : "${dateFormat.format(_model.currentLobby!.startDate!)}")
                        : "${dateFormat.format(_model.currentLobby!.startDate!)} - ${dateFormat.format(_model.currentLobby!.endDate!)}",
                    style: Theme.of(context).textTheme.titleSmall,
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
          tabs: [
            Tab(text: 'Dashboard'),
            Tab(text: 'Chat'),
            Tab(text: 'Resources'),
            Tab(text: 'Poll'),
            Tab(text: 'Joiners'),
          ],
          controller: _model.tabBarController,
          onTap: (value) => setState(() {
            FocusScope.of(context).unfocus();
          }),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _model.tabBarController,
                    children: [
                      wrapWithModel(
                        model: _model.lobbyDashboardModel!,
                        child: LobbyDashboardWidget(
                          lobbyId: widget.lobbyId,
                        ),
                        updateCallback: () => setState(() {}),
                      ),
                      wrapWithModel(
                        model: _model.chatModel!,
                        updateCallback: () => setState(() {}),
                        child: ChatWidget(
                          setState,
                          _model.currentLobby!.id,
                          _model.currentLobby!.conversation,
                        ),
                      ),
                      BudgetWidget(
                        lobbyId: _model.currentLobby!.id,
                        hostId: _model.currentLobby!.hostId,
                      ),
                      PollCompWidget(
                        lobbyId: _model.currentLobby!.id,
                      ),
                      JoinersWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<LobbyModel?> displayLobby() {
    return FutureBuilder(
      future: _fetchLobby,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );
        _model.currentLobby = snapshot.data;
        Provider.of<LobbyProvider>(context, listen: false)
            .setCurrentLobby(_model.currentLobby!);
        return mainDisplay();
      },
    );
  }

  PopupMenuButton menuOption() {
    return PopupMenuButton<int>(
      onSelected: (value) {
        switch (value) {
          case 0:
            context.pop();
            _model.leaveLobby(widget.lobbyId!);
            break;
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
