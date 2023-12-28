import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class WaitingApproval extends StatelessWidget {
  final String name;
  final String friendId;
  const WaitingApproval({
    super.key,
    required this.name,
    required this.friendId,
  });

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
            Text(name),
            Text(
              'Waiting for approval',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            showDialogLoading(context);
            (context.read<Auth>() as UserController)
                .removeFriendRequest(friendId)
                .then((value) {
              context.pop();
              if (!value)
                ScaffoldMessenger.of(context).showSnackBar(
                  showError(
                      'Can\'t remove :(', Theme.of(context).colorScheme.error),
                );
            });
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
