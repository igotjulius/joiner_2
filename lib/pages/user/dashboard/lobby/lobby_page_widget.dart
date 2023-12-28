import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/joiners_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/lobby_dashboard/lobby_dashboard.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/poll/poll_comp_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/chat/chat_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/budget_widget.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LobbyPageWidget extends StatefulWidget {
  final String currentLobbyId;
  LobbyPageWidget({super.key, required this.currentLobbyId});

  @override
  _LobbyPageWidgetState createState() => _LobbyPageWidgetState();
}

final DateFormat dateFormat = DateFormat('MMMM dd');

class _LobbyPageWidgetState extends State<LobbyPageWidget>
    with TickerProviderStateMixin {
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
  late TabController _tabBarController;
  late BudgetModel budgetModel = BudgetModel();
  late PollCompModel pollModel = PollCompModel();
  late JoinersModel joinersModel = JoinersModel();
  bool showFab = true;
  late LobbyModel _currentLobby;

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: 0,
    );
    _tabBarController.addListener(() {
      if (_tabBarController.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentLobby = (context.watch<Auth>() as UserController)
        .activeLobbies
        .firstWhere((element) => element.id == widget.currentLobbyId);
    return mainDisplay();
  }

  Widget mainDisplay() {
    return Scaffold(
      appBar: appBar(),
      body: mainContent(),
      floatingActionButton: showFab && _tabBarController.index > 1
          ? Visibility(
              visible: showFab,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  switch (_tabBarController.index) {
                    case 2:
                      _fabControllers[0].onTapHandler!();
                      budgetModel.controller?.closed.then((value) {
                        setState(() {
                          showFab = true;
                        });
                      });
                      break;
                    case 3:
                      _fabControllers[1].onTapHandler!();
                      pollModel.controller?.closed.then((value) {
                        setState(() {
                          showFab = true;
                        });
                      });
                      break;
                    case 4:
                      _fabControllers[2].onTapHandler!();
                      joinersModel.controller?.closed.then((value) {
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
                  controller: _tabBarController,
                  children: [
                    LobbyDashboardWidget(
                      lobbyId: widget.currentLobbyId,
                    ),
                    ChatWidget(conversationId: _currentLobby.conversation!),
                    BudgetWidget(
                      currentLobby: _currentLobby,
                      fabController: _fabControllers[0],
                      model: budgetModel,
                    ),
                    PollCompWidget(
                      currentLobbyId: _currentLobby.id!,
                      fabController: _fabControllers[1],
                      model: pollModel,
                      polls: _currentLobby.poll!,
                    ),
                    JoinersWidget(
                      currentLobby: _currentLobby,
                      fabController: _fabControllers[2],
                      model: joinersModel,
                    ),
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
                  _currentLobby.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  _currentLobby.startDate == _currentLobby.endDate
                      ? (_currentLobby.startDate == null
                          ? 'Date undecided'
                          : "${dateFormat.format(_currentLobby.startDate!)}")
                      : "${dateFormat.format(_currentLobby.startDate!)} - ${dateFormat.format(_currentLobby.endDate!)}",
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
        controller: _tabBarController,
        onTap: (value) => setState(() {
          FocusScope.of(context).unfocus();
        }),
      ),
    );
  }

  PopupMenuButton menuOption() {
    return PopupMenuButton<int>(
      onSelected: (value) {
        switch (value) {
          case 0:
            context.pop();
            (context.read<Auth>() as UserController)
                .leaveLobby(widget.currentLobbyId);
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
