import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:joiner_1/models/allocated_budget_model.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class ParticipantBudget extends StatelessWidget {
  final String? id;
  final String? participant_fname;
  final String? participant_lname;
  final double? amount;
  const ParticipantBudget({super.key, this.id, this.participant_fname, this.participant_lname, this.amount});

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
                Text('${participant_fname!} ${participant_lname!}',  style: TextStyle(fontSize: 16),),
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
