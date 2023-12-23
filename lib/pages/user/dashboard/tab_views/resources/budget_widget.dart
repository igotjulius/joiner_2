import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_widget.dart';
import 'package:joiner_1/widgets/atoms/budget_category.dart';
import 'package:joiner_1/widgets/atoms/participant_budget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetWidget extends StatefulWidget {
  final FabController? fabController;
  final BudgetModel? model;
  final String? hostId, lobbyId;
  const BudgetWidget(this.fabController, this.model, this.lobbyId, this.hostId,
      {super.key});

  @override
  _BudgetWidgetState createState() =>
      _BudgetWidgetState(fabController!, model!);
}

class _BudgetWidgetState extends State<BudgetWidget>
    with TickerProviderStateMixin {
  _BudgetWidgetState(FabController fabController, this._model) {
    fabController.onTapHandler = fabHandler;
  }
  late BudgetModel _model;
  LobbyModel? _currentLobby;
  List<ParticipantModel>? _participants;
  ExpenseModel? _expense;
  TabController? _tabController;
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
    _currentLobby = context.read<LobbyProvider>().currentLobby;
    _participants = _currentLobby?.participants;
    _expense = _currentLobby?.expense;
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.controller != null) _model.controller?.close();
    });
  }

  void fabHandler() {
    _model.controller = showBottomSheet(
      context: context,
      builder: (context) => AddBudgetWidget(lobbyId: _currentLobby?.id),
    );
  }

  Widget expensesTab() {
    if (_expense?.items?.length == 0) {
      return Center(
        child: Text('There\'s no expenses listed'),
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
    final keys = _expense?.items?.keys.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: keys!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            final currentUserId = context.read<FFAppState>().currentUser?.id;
            if (currentUserId == _currentLobby?.hostId) {
              showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: Text('Delete'),
                      content: Text(
                          'Are you sure you want to delete ${keys[index]} expense?'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            // await UserController.deleteSpecificExpense(
                            //     lobbyId!, label!);
                            // Fluttertoast.showToast(
                            //   msg: '$label Expense Deleted.',
                            //   toastLength: Toast.LENGTH_SHORT,
                            //   gravity: ToastGravity.BOTTOM,
                            //   timeInSecForIosWeb: 2,
                            //   backgroundColor: Colors.green,
                            //   textColor: Colors.white,
                            //   fontSize: 10.0,
                            // );
                            context
                                .read<LobbyProvider>()
                                .removeExpense(keys[index]);
                            context.pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    )),
              );
            }
          },
          child: BudgetCategoryWidget(
            hostId: _currentLobby?.hostId,
            lobbyId: _currentLobby?.id,
            label: keys[index],
            amount: _expense?.items?[keys[index]],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
                        _tabController?.index = 0;
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
                        _tabController?.index = 1;
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
      ),
    );
  }

  Widget budgetTab() {
    if (_expense?.items?.length == 0) {
      return Center(
        child: Text('There\'s no expenses yet'),
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
          Text('Total Expenses: ₱${_expense?.total}',
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
      itemCount: _participants?.length,
      itemBuilder: (context, index) {
        if (_participants?[index].joinStatus == 'Joined')
          return ParticipantBudget(
            id: _participants?[index].id,
            participantFname: _participants?[index].firstName,
            participantLname: _participants?[index].lastName,
            amount: _participants?[index].contribution!['amount'],
          );
        return null;
      },
    );
  }
}

class BudgetModel {
  PersistentBottomSheetController? controller;
}
