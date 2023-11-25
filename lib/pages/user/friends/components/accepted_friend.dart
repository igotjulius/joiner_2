import 'package:flutter/material.dart';

class AcceptedFriendAtom extends StatelessWidget {
  final String? name;
  const AcceptedFriendAtom({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/User_01c_(1).png',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name!,
        ),
      ],
    );
  }
}
