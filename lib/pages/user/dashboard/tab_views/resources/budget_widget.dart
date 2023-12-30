import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_widget.dart';
import 'package:joiner_1/widgets/atoms/budget_category.dart';
import 'package:joiner_1/widgets/atoms/participant_budget.dart';
import 'package:flutter/material.dart';

class BudgetWidget extends StatefulWidget {
  final FabController fabController;
  final BudgetModel model;
  final LobbyModel currentLobby;
  const BudgetWidget({
    super.key,
    required this.fabController,
    required this.model,
    required this.currentLobby,
  });

  @override
  _BudgetWidgetState createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    Tab(
      text: 'Expenses',
    ),
    Tab(
      text: 'Budget',
    ),
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    widget.fabController.onTapHandler = fabHandler;
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.model.controller != null) widget.model.controller?.close();
    });
  }

  void fabHandler() {
    widget.model.controller = showBottomSheet(
      context: context,
      builder: (context) => AddBudgetWidget(lobbyId: widget.currentLobby.id!),
    );
  }

  Widget expensesTab() {
    if (widget.currentLobby.expense?.items?.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on,
              size: 48.0,
              color: Colors.grey,
            ),
            SizedBox(height: 8.0),
            Text("There's no expenses listed"),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Amount',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          expenses(),
        ],
      ),
    );
  }

  Widget expenses() {
    final keys = widget.currentLobby.expense?.items?.keys.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: keys!.length,
      itemBuilder: (context, index) {
        return BudgetCategoryWidget(
          hostId: widget.currentLobby.hostId!,
          lobbyId: widget.currentLobby.id!,
          label: keys[index],
          amount: widget.currentLobby.expense!.items![keys[index]]!,
        );
      },
    );
  }

  Widget budgetTab() {
    if (widget.currentLobby.expense?.items?.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on,
              size: 48.0,
              color: Colors.grey,
            ),
            SizedBox(height: 8.0),
            Text("There's no expenses yet"),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Total Expenses: ₱${widget.currentLobby.expense?.total}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Participants',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  'Budgets',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          contributions(),
        ],
      ),
    );
  }

  Widget contributions() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.currentLobby.participants?.length,
      itemBuilder: (context, index) {
        if (widget.currentLobby.participants?[index].joinStatus == 'Joined')
          return ParticipantBudget(
            id: widget.currentLobby.participants?[index].id,
            participantFname:
                widget.currentLobby.participants?[index].firstName,
            participantLname: widget.currentLobby.participants?[index].lastName,
            amount: widget
                .currentLobby.participants?[index].contribution!['amount'],
          );
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Expenses'),
                  selected: _index == 0 ? true : false,
                  showCheckmark: false,
                  onSelected: (_) {
                    setState(() {
                      _index = 0;
                      _tabController.index = 0;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  label: Text('Budget'),
                  selected: _index == 1 ? true : false,
                  showCheckmark: false,
                  onSelected: (_) {
                    setState(() {
                      _index = 1;
                      _tabController.index = 1;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  expensesTab(),
                  budgetTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BudgetModel {
  PersistentBottomSheetController? controller;
}
