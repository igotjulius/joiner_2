import 'package:joiner_1/components/user/add_budget_widget.dart';
import '../../widgets/atoms/budget_category.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BudgetModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  List<String>? keys;
  Map<String, double>? budget;

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  Widget showBudget() {
    return keys == null
        ? Center(
            child: Text('Theres no budget yet'),
          )
        : ListView.builder(
            itemCount: keys!.length,
            itemBuilder: ((context, index) {
              return BudgetCategoryWidget(
                label: keys?[index],
                amount: budget?[keys?[index]],
                prefixIcon: Icons.money,
                suffixIcon: Icons.wallet,
              );
            }),
          );
  }

  void addBudget(BuildContext context, String lobbyId) {
    showDialog(
      context: context,
      builder: (context) => AddBudgetWidget(lobbyId: lobbyId),
    );
  }

  /// Additional helper methods are added here.
}
