import 'package:joiner_1/components/user/add_budget_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
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
  FutureBuilder<LobbyModel?> showBudget(String lobbyId) {
    return FutureBuilder(
      future: UserController.getLobby(lobbyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          ); 
        else if (budget?.keys == null)
          return Text("No Budget Plans yet.");
        else  
        budget = snapshot.data?.budget;
        keys = budget?.keys.toList();
        return ListView.builder(
          itemCount: keys!.length,
          itemBuilder: (context, index) {
            return BudgetCategoryWidget(
              label: keys?[index],
              amount: budget?[keys?[index]],
            );
          },
        );
      },
    );
  }

  void addBudget(BuildContext context, String lobbyId) async {
    await showDialog(
      context: context,
      builder: (context) => AddBudgetWidget(lobbyId: lobbyId),
    );
    updatePage(() {});
  }

  /// Additional helper methods are added here.
}
