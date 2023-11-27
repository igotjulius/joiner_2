import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_model.dart';
export 'budget_model.dart';

class BudgetWidget extends StatefulWidget {
  final String? hostId;
  final String? lobbyId;
  const BudgetWidget({Key? key, this.lobbyId, this.hostId}) : super(key: key);

  @override
  _BudgetWidgetState createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget>
    with TickerProviderStateMixin {
  late BudgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BudgetModel());
    _model.tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
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
                tabs: [
                  Tab(
                    text: 'Expenses',
                  ),
                  Tab(
                    text: 'Budget',
                  ),
                ],
                controller: _model.tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _model.tabController,
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
                                _model.addBudget(context, widget.lobbyId!);
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
                              _model.showExpenses(
                                  widget.lobbyId!, widget.hostId!),
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
                        Text('Total Expenses: ₱${_model.total}',
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
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        _model.showBudget(widget.lobbyId!),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
