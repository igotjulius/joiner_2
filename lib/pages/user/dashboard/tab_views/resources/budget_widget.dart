import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_widget.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/budget_category.dart';
import 'package:joiner_1/widgets/atoms/participant_budget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Amount',
                style: Theme.of(context).textTheme.titleMedium,
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
        children: [
          Row(
            children: [
              Text(
                'Contributions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              if (context.read<Auth?>()?.profile?.id ==
                  widget.currentLobby.hostId)
                splitOption(),
            ],
          ),
          contributions(),
        ],
      ),
    );
  }

  Widget splitOption() {
    return Row(
      children: [
        Text(
          'Split equally',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Checkbox(
          value: widget.currentLobby.expense?.splitEqually,
          onChanged: (value) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Split expenses'),
                  content: Text(
                      'This will reset each participant\'s contribution. Do you want to continue?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final nExpenses = ExpenseModel(
                          items: widget.currentLobby.expense?.items,
                          total: widget.currentLobby.expense?.total,
                          splitEqually: value,
                        );
                        (context.read<Auth?>() as UserController)
                            .resetExpenses(nExpenses, widget.currentLobby.id!)
                            .then((value) => context.pop());
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget contributions() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.currentLobby.participants?.length,
      itemBuilder: (context, index) {
        if (widget.currentLobby.participants?[index].joinStatus == 'Joined')
          return ParticipantBudget(
            lobbyId: widget.currentLobby.id!,
            participant: widget.currentLobby.participants![index],
            totalExpense: widget.currentLobby.expense!.total!,
          );
        return null;
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    context.watch<Auth?>();
    return Padding(
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
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Total Expenses: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              withCurrency(
                Text(
                  '${widget.currentLobby.expense?.total}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
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
    );
  }
}

class BudgetModel {
  PersistentBottomSheetController? controller;
}
