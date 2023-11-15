import 'package:joiner_1/widgets/atoms/promos_list.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lobbies_model.dart';

export 'lobbies_model.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('LobbyCreation');
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        bottom: TabBar(
          unselectedLabelStyle: TextStyle(),
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
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: TabBarView(controller: _model.tabController, children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
              child: PromosList(),
            )),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                child: _model.getUserLobbies(),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
