import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/pages/user/dashboard/promo_list/promos_list.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/widgets/molecules/active_lobby_mole.dart';
import 'package:joiner_1/widgets/molecules/lobby_invitation_mole.dart';

class LobbiesWidget extends StatefulWidget {
  const LobbiesWidget({Key? key}) : super(key: key);

  @override
  _LobbiesWidgetState createState() => _LobbiesWidgetState();
}

class _LobbiesWidgetState extends State<LobbiesWidget>
    with TickerProviderStateMixin {
  final _tabs = [
    Tab(
      text: 'Promos',
    ),
    Tab(
      text: 'Lobbies',
    ),
  ];
  late TabController _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late UserController provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<Auth>() as UserController;
    provider.refetchLobbies();
    provider.refetchRentals();
    provider.refetchFriendsList();
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Auth>();
    return ChangeNotifierProvider<UserController>.value(
      value: provider,
      child: Scaffold(
        floatingActionButton: _tabController.index != 0
            ? FloatingActionButton(
                onPressed: () {
                  context.goNamed('LobbyCreation');
                },
                child: const Icon(
                  Icons.add,
                ),
              )
            : null,
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: Color(0xfffafafa),
          bottom: TabBar(
            tabs: _tabs,
            controller: _tabController,
            onTap: (value) => setState(() {}),
          ),
        ),
        body: TabBarView(
          key: Key('userDashboard'),
          controller: _tabController,
          children: [
            Column(
              children: [
                Expanded(
                  child: PromosList(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: displayLobbies(),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayLobbies() {
    final pendingLobbies = provider.pendingLobbies;
    final activeLobbies = provider.activeLobbies;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pendingLobbies.length != 0)
            Column(
              children: [
                Text('Invitations'),
                LobbyInvitationMolecule(lobbies: pendingLobbies),
              ],
            ),
          activeLobbies.length == 0
              ? Text('No active lobbies')
              : ActiveLobbyMolecule(),
        ],
      ),
    );
  }
}
