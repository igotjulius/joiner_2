import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/joiners_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/lobby_dashboard/lobby_dashboard.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/poll_comp_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/chat/chat_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/budget_widget.dart';
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
  final _tabs = [
    Tab(text: 'Dashboard'),
    Tab(text: 'Chat'),
    Tab(text: 'Resources'),
    Tab(text: 'Poll'),
    Tab(text: 'Joiners'),
  ];
  List<FabController> _fabControllers = [
    FabController(),
    FabController(),
    FabController()
  ];
  bool showFab = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = LobbyPageModel();
    _model.initModel(widget.currentLobby!);
    // _fetchLobby = UserController.getLobby(widget.lobbyId!);
    _model.tabBarController = TabController(
      vsync: this,
      length: _tabs.length,
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
      return fetchLobby();
    else
      return mainDisplay();
  }

  Widget mainDisplay() {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(),
      body: mainContent(),
      floatingActionButton: showFab && _model.tabBarController!.index > 1
          ? Visibility(
              visible: showFab,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  switch (_model.tabBarController!.index) {
                    case 2:
                      _fabControllers[0].onTapHandler!();
                      _model.budgetModel?.controller?.closed.then((value) {
                        setState(() {
                          showFab = true;
                        });
                      });
                      break;
                    case 3:
                      _fabControllers[1].onTapHandler!();
                      _model.pollModel?.controller?.closed.then((value) {
                        setState(() {
                          showFab = true;
                        });
                      });
                      break;
                    case 4:
                      _fabControllers[2].onTapHandler!();
                      _model.joinersModel?.controller?.closed.then((value) {
                        setState(() {
                          showFab = true;
                        });
                      });
                    default:
                  }
                },
                child: Icon(Icons.add_rounded),
              ),
            )
          : null,
    );
  }

  Widget mainContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _model.tabBarController,
                  children: [
                    LobbyDashboardWidget(
                      model: _model.lobbyDashboardModel,
                      lobbyId: widget.lobbyId,
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
                      _fabControllers[0],
                      _model.budgetModel,
                      _model.currentLobby!.id,
                      _model.currentLobby!.hostId,
                    ),
                    PollCompWidget(
                      _model.currentLobby!.id,
                      _fabControllers[1],
                      _model.pollModel,
                    ),
                    JoinersWidget(_fabControllers[2], _model.joinersModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          context.goNamed('MainDashboard');
        },
      ),
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
                  _model.currentLobby!.startDate == _model.currentLobby!.endDate
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
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        tabs: _tabs,
        controller: _model.tabBarController,
        onTap: (value) => setState(() {
          FocusScope.of(context).unfocus();
        }),
      ),
    );
  }

  FutureBuilder<LobbyModel?> fetchLobby() {
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

class FabController {
  void Function()? onTapHandler;
}
