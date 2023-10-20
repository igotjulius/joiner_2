import 'package:flutter/material.dart';

class PendingFriendAtom extends StatelessWidget {
  final String? name;
  final String? friendId;
  final Function(String)? acceptEventAction;
  const PendingFriendAtom(
      {super.key, this.name, this.friendId, this.acceptEventAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/Group.png',
                fit: BoxFit.cover,
              ),
              Text("$name sent you friend request."),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('Decline'),
              ),
              OutlinedButton(
                onPressed: () {
                  acceptEventAction!(friendId!);
                },
                child: Text('Accept'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
