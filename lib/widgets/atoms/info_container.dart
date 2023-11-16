import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final Widget? child;
  final bool? filled;
  const InfoContainer({super.key, this.child, this.filled});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        color: filled == true
            ? Theme.of(context).colorScheme.primaryContainer
            : null,
      ),
    );
  }
}
