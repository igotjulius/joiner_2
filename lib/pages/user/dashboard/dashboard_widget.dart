import 'package:joiner_1/widgets/atoms/promos_list.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_model.dart';

export 'dashboard_model.dart';

class LobbiesWidget extends StatefulWidget {
  const LobbiesWidget({Key? key}) : super(key: key);

  @override
  _LobbiesWidgetState createState() => _LobbiesWidgetState();
}

class _LobbiesWidgetState extends State<LobbiesWidget>
    with TickerProviderStateMixin {
  late LobbiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbiesModel());
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
              child: _model.getUserLobbies(),
            ),
          ),
        ],
      ),
    );
  }
}
