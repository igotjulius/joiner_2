import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/expense_model.dart';

class AddBudgetModel extends FlutterFlowModel {
  TextEditingController? labelController;
  String? Function(String?)? labelValidator;
  TextEditingController? amountController;
  String? Function(String?)? amountValidator;

  @override
  void dispose() {
    labelController!.dispose();
  }

  @override
  void initState(BuildContext context) {}

  void addExpenses(String lobbyId) async {
    double amount = double.parse(amountController.text);
    await UserController.putExpenses(
      ExpenseModel(items: {labelController.text : amount}),
      lobbyId
    );
  }
}