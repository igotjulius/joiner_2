import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';

class PendingFriendAtom extends StatelessWidget {
  final String? name;
  final String? friendId;
  final void Function(Function())? parentSetState;
  const PendingFriendAtom({
    super.key,
    this.name,
    this.friendId,
    this.parentSetState,
  });

  void acceptFriendRequest(String friendId) async {
    await UserController.acceptFriendRequest(friendId);
    parentSetState!(() {});
  }

  void removeFriendRequest(String friendId) async {
    await UserController.removeFriendRequest(friendId);
    parentSetState!(() {});
  }

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
                    removeFriendRequest(friendId!);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: LinearBorder(),
                  ),
                ),
              ),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: LinearBorder(),
                  ),
                  child: Text('Accept'),
                  onPressed: () {
                    acceptFriendRequest(friendId!);
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
