import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/controllers/user_controller.dart';

class AddBudgetModel extends FlutterFlowModel {
  TextEditingController? labelController;
  String? Function(BuildContext, String?)? labelValidator;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountValidator;

  @override
  void dispose() {
    labelController!.dispose();
  }

  @override
  void initState(BuildContext context) {}

  void addBudget() async {
    await UserController.addBudget(
      labelController.text,
      double.parse(amountController.text),
    );
  }
}
