import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final String? label;
  final double? amount;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  const BudgetCategoryWidget({
    super.key,
    this.label,
    this.amount,
    this.prefixIcon,
    this.suffixIcon,
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
                Icon(prefixIcon),
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
                Icon(suffixIcon),
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
