import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class ParticipantBudget extends StatelessWidget {
  final String? id;
  final String? participantFname;
  final String? participantLname;
  final double? amount;
  const ParticipantBudget(
      {super.key,
      this.id,
      this.participantFname,
      this.participantLname,
      this.amount});

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
                  '${participantFname!} ${participantLname!}',
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
                Text(
                  NumberFormat.currency(
                    symbol: '₱', // Currency symbol
                    decimalDigits: 2, // Number of decimal places
                  ).format(amount!),
                  style: TextStyle(fontSize: 16),
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
