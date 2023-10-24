import 'package:flutter/material.dart';

class LobbyItem extends StatelessWidget {
  final String? label;
  final Icon? icon;
  const LobbyItem({super.key, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 80,
        child: Row(
          children: [
            Image.asset(
              'images/User_01c_(1).png',
              height: 40,
              width: 40,
            ),
            Column(
              children: [
                Text(label!),
                Text('Date'),
                icon!,
              ],
            ),
            Text('new messages'),
          ],
        ),
      ),
    );
  }
}
