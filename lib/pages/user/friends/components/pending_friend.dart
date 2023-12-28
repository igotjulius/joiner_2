import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class PendingFriendAtom extends StatelessWidget {
  final String name;
  final String friendId;
  const PendingFriendAtom({
    super.key,
    required this.name,
    required this.friendId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
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
                Expanded(
                  child: Text(
                    '$name sent you a friend request',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align buttons evenly
            children: [
              Expanded(
                child: TextButton(
                  child: Text('Decline'),
                  onPressed: () {
                    showDialogLoading(context);
                    (context.read<Auth>() as UserController)
                        .removeFriendRequest(friendId)
                        .then((value) {
                      context.pop();
                      if (!value)
                        ScaffoldMessenger.of(context).showSnackBar(
                          showError('Error declining',
                              Theme.of(context).colorScheme.error),
                        );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: LinearBorder(),
                  ),
                ),
              ),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: LinearBorder(),
                  ),
                  child: Text('Accept'),
                  onPressed: () {
                    showDialogLoading(context);
                    (context.read<Auth>() as UserController)
                        .acceptFriendRequest(friendId)
                        .then((value) {
                      context.pop();
                      if (!value)
                        ScaffoldMessenger.of(context).showSnackBar(
                          showError('Error in accepting',
                              Theme.of(context).colorScheme.error),
                        );
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
