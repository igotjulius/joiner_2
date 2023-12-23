import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final String? lobbyId;
  final String? label;
  final double? amount;
  final String? hostId;
  const BudgetCategoryWidget({
    super.key,
    this.hostId,
    this.lobbyId,
    this.label,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xff9c9c9c),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  label!,
                  style: TextStyle(fontSize: 16),
                ),
              ].divide(
                SizedBox(
                  width: 8,
                ),
              ),
            ),
            Row(
              children: [
                withCurrency(
                  Text(amount.toString()),
                ),
              ].divide(
                SizedBox(
                  width: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
