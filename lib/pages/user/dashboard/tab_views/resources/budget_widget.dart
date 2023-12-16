import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_widget.dart';
import 'package:joiner_1/widgets/atoms/budget_category.dart';
import 'package:joiner_1/widgets/atoms/participant_budget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetWidget extends StatefulWidget {
  final String? hostId;
  final String? lobbyId;
  const BudgetWidget({Key? key, this.lobbyId, this.hostId}) : super(key: key);

  @override
  _BudgetWidgetState createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: TabBar(
                  unselectedLabelStyle: TextStyle(),
                  labelPadding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  tabs: _tabs,
                  controller: _tabController,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                text: 'Add Expenses',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddBudgetWidget(
                                        lobbyId: _currentLobby?.id),
                                  );
                                },
                                options: FFButtonOptions(height: 40),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 10),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 10, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Items',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Prices',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                showExpenses(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Budget
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text('Total Expenses: ₱${_expense?.total}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 30, 10, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Participants',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Budgets',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          showBudget(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showBudget() {
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

  Widget showExpenses() {
    final keys = _expense?.items?.keys.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: keys!.length,
      itemBuilder: (context, index) {
        return BudgetCategoryWidget(
          hostId: _currentLobby?.hostId,
          lobbyId: _currentLobby?.id,
          label: keys[index],
          amount: _expense?.items?[keys[index]],
        );
      },
    );
  }
}
