import 'package:joiner_1/pages/user/dashboard/promo_list/promos_list.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'dashboard_model.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/widgets/molecules/active_lobby_mole.dart';
import 'package:joiner_1/widgets/molecules/lobby_invitation_mole.dart';

export 'dashboard_model.dart';

class LobbiesWidget extends StatefulWidget {
  const LobbiesWidget({Key? key}) : super(key: key);

  @override
  _LobbiesWidgetState createState() => _LobbiesWidgetState();
}

class _LobbiesWidgetState extends State<LobbiesWidget>
    with TickerProviderStateMixin {
  late LobbiesModel _model;
  Future<Map<String, List<LobbyModel>>>? _fetchLobbies;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbiesModel());
    _fetchLobbies = UserController.getLobbies();
    _model.tabController =
        TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      floatingActionButton: _model.tabController!.index != 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: FloatingActionButton(
                onPressed: () {
                  context.goNamed('LobbyCreation');
                },
                child: const Icon(
                  Icons.add,
                  size: 32,
                ),
              ),
            )
          : null,
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Color(0xfffafafa),
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Promos',
            ),
            Tab(
              text: 'Lobbies',
            ),
          ],
          controller: _model.tabController,
          onTap: (value) => setState(() {}),
        ),
      ),
      body: TabBarView(
        key: Key('userDashboard'),
        controller: _model.tabController,
        children: [
          Column(
            children: [
              Expanded(
                child: PromosList(),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: getUserLobbies(),
            ),
          ),
        ],
      ),
    );
  }

  // Fetch user lobbies
  FutureBuilder getUserLobbies() {
    return FutureBuilder(
      future: _fetchLobbies,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator());

        final Map<String, List<LobbyModel>> result = snapshot.data!;
        final {'active': activeLobbies, 'pending': pendingLobbies} = result;

        context.read<FFAppState>().setLinkableLobbies(activeLobbies);

        return Column(
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
                : ActiveLobbyMolecule(activeLobbies),
          ],
        );
      },
    );
  }
}
