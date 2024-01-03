import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/friend_model.dart';
import 'package:joiner_1/pages/user/friends/components/pending_friend.dart';
import 'package:joiner_1/pages/user/friends/components/accepted_friend.dart';
import 'package:joiner_1/pages/user/friends/components/waiting_approval.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({super.key});

  @override
  _FriendsWidgetState createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  @override
  void initState() {
    super.initState();
    (context.read<Auth>() as UserController).refetchFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Auth>() as UserController;
    final pendingFriendsList = provider.pendingFriends;
    final acceptedFriendsList = provider.acceptedFriends;
    final forApprovalList = provider.forApproval;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friends',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: pendingFriendsList.isEmpty &&
                forApprovalList.isEmpty &&
                acceptedFriendsList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 48.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.0),
                    Text('Add your friends here'),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        if (pendingFriendsList.isNotEmpty)
                          pendingFriends(pendingFriendsList),
                        if (forApprovalList.isNotEmpty)
                          waitingApproval(forApprovalList),
                        if (acceptedFriendsList.isNotEmpty)
                          acceptedFriends(acceptedFriendsList),
                      ].divide(
                        SizedBox(
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('InviteFriend');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget pendingFriends(List<FriendModel> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friend Requests',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return PendingFriendAtom(
              name: '${list[index].firstName} ${list[index].lastName}',
              friendId: list[index].friendId,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }

  Widget acceptedFriends(List<FriendModel> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friends',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                showRemoveFriendConfirmationDialog(context, list[index]);
              },
              child: AcceptedFriendAtom(
                name: '${list[index].firstName} ${list[index].lastName}',
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }

  Widget waitingApproval(List<FriendModel> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'For Approval',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return WaitingApproval(
              friendId: list[index].friendId,
              name: '${list[index].firstName} ${list[index].lastName}',
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }

  void showRemoveFriendConfirmationDialog(BuildContext context, FriendModel friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Remove of Friend'),
          content: Text('Are you sure you want to remove ${friend.firstName} ${friend.lastName} as a friend?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                (context.read<Auth>() as UserController)
                    .removeFriendRequest(friend.friendId);
                Navigator.of(context).pop();
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
