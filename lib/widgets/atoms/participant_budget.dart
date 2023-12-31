import 'package:flutter/material.dart';
import 'package:joiner_1/utils/utils.dart';

class ParticipantBudget extends StatelessWidget {
  final String? id;
  final String? participantFname;
  final String? participantLname;
  final double? amount;
  const ParticipantBudget({
    super.key,
    this.id,
    this.participantFname,
    this.participantLname,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${participantFname!} ${participantLname!}',
          ),
          withCurrency(
            Text(
              amount.toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
