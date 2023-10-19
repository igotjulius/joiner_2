import 'dart:js_interop';

import '../../widgets/atoms/budget_category.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BudgetGraphModel extends FlutterFlowModel {
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

  /// Additional helper methods are added here.
}
