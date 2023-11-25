import 'package:flutter/material.dart';

class PollChoices extends StatelessWidget {
  final String? choice;
  final int? count;
  final Color? textColor;
  const PollChoices({super.key, this.choice, this.count, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            choice!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                ),
          ),
          Text(
            "$count votes",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                ),
          ),
        ],
      ),
    );
  }
}
