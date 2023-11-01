import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final String? label;
  final double? amount;
  const BudgetCategoryWidget({
    super.key,
    this.label,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(label!),
              ].divide(
                SizedBox(
                  width: 8,
                ),
              ),
            ),
            Row(
              children: [
                Text("₱$amount"),
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
