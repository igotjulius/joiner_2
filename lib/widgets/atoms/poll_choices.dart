import 'package:flutter/material.dart';

class PollChoices extends StatelessWidget {
  final String? choice;
  final int? count;
  final Color? color;
  const PollChoices({super.key, this.choice, this.count, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              choice!,
            ),
            Text(
              "$count votes",
            ),
          ],
        ),
      ),
    );
  }
}
