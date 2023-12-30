import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/pages/user/dashboard/promo_list/promos_list.dart';
import 'package:provider/provider.dart';
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    return activeLobbies.length == 0 && pendingLobbies.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 52.0,
                  color: Colors.grey,
                ),
                SizedBox(height: 8.0),
                Text('No Active Lobbies'),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                if (pendingLobbies.length != 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Invitations'),
                      LobbyInvitationMolecule(lobbies: pendingLobbies),
                    ],
                  ),
                ActiveLobbyMolecule(),
              ],
            ),
          );
  }
}
