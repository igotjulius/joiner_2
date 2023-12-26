import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';

class WaitingApproval extends StatelessWidget {
  final String? name;
  final String? friendId;
  final void Function(Function())? parentSetState;
  const WaitingApproval(
      {super.key, this.name, this.friendId, this.parentSetState});

  void removeFriendRequest(String friendId) async {
    // await UserController.removeFriendRequest(friendId);
    parentSetState!(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/User_01c_(1).png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name!),
            Text(
              'Waiting for approval',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            removeFriendRequest(friendId!);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
