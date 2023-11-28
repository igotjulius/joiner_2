import 'package:joiner_1/components/user/add_budget_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/atoms/participant_budget.dart';
import '../../widgets/atoms/budget_category.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BudgetModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  List<ParticipantModel>? participants;
  List<String>? keys;
  Map<String, double>? budget;
  TabController? tabController;
  int get tabBarCurrentIndex =>
      tabController != null ? tabController!.index : 0;
  double? total = 0.0;
  Future<List<ParticipantModel>>? fetchParticipants;

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  FutureBuilder<ResponseModel<ExpenseModel?>> showExpenses(
      String lobbyId, String hostId) {
    return FutureBuilder(
      future: UserController.getExpenses(lobbyId),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        budget = snapshot.data?.data?.items;
        if (budget == null) return Text("No Budget Plans yet.");
        if (budget?.isEmpty == true)
          return Center(
            child: Text(
              "No Expenses",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          );
        keys = budget?.keys.toList();
        total = snapshot.data?.data?.total;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: keys!.length,
          itemBuilder: (context, index) {
            return BudgetCategoryWidget(
              hostId: hostId,
              lobbyId: lobbyId,
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

  FutureBuilder<List<ParticipantModel>> showBudget(String lobbyId) {
    return FutureBuilder(
      // future: UserController.getParticipants(lobbyId),
      future: fetchParticipants,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );

        participants = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: participants?.length,
          itemBuilder: (context, index) {
            if (participants?[index].joinStatus == 'Joined')
              return ParticipantBudget(
                id: participants?[index].id,
                participantFname: participants?[index].firstName,
                participantLname: participants?[index].lastName,
                amount: participants?[index].contribution!['amount'],
              );
            return null;
          },
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
